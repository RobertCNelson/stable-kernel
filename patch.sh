#!/bin/bash -e
#
# Copyright (c) 2009-2019 Robert Nelson <robertcnelson@gmail.com>
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
# THE SOFTWARE.

# Split out, so build_kernel.sh and build_deb.sh can share..

shopt -s nullglob

. ${DIR}/version.sh
if [ -f ${DIR}/system.sh ] ; then
	. ${DIR}/system.sh
fi
git_bin=$(which git)
#git hard requirements:
#git: --no-edit

git="${git_bin} am"
#git_patchset=""
#git_opts

if [ "${RUN_BISECT}" ] ; then
	git="${git_bin} apply"
fi

echo "Starting patch.sh"

git_add () {
	${git_bin} add .
	${git_bin} commit -a -m 'testing patchset'
}

start_cleanup () {
	git="${git_bin} am --whitespace=fix"
}

cleanup () {
	if [ "${number}" ] ; then
		if [ "x${wdir}" = "x" ] ; then
			${git_bin} format-patch -${number} -o ${DIR}/patches/
		else
			if [ ! -d ${DIR}/patches/${wdir}/ ] ; then
				mkdir -p ${DIR}/patches/${wdir}/
			fi
			${git_bin} format-patch -${number} -o ${DIR}/patches/${wdir}/
			unset wdir
		fi
	fi
	exit 2
}

dir () {
	wdir="$1"
	if [ -d "${DIR}/patches/$wdir" ]; then
		echo "dir: $wdir"

		if [ "x${regenerate}" = "xenable" ] ; then
			start_cleanup
		fi

		number=
		for p in "${DIR}/patches/$wdir/"*.patch; do
			${git} "$p"
			number=$(( $number + 1 ))
		done

		if [ "x${regenerate}" = "xenable" ] ; then
			cleanup
		fi
	fi
	unset wdir
}

cherrypick () {
	if [ ! -d ../patches/${cherrypick_dir} ] ; then
		mkdir -p ../patches/${cherrypick_dir}
	fi
	${git_bin} format-patch -1 ${SHA} --start-number ${num} -o ../patches/${cherrypick_dir}
	num=$(($num+1))
}

external_git () {
	git_tag=""
	echo "pulling: ${git_tag}"
	${git_bin} pull --no-edit ${git_patchset} ${git_tag}
	${git_bin} describe
}

aufs_fail () {
	echo "aufs failed"
	exit 2
}

aufs () {
	echo "dir: aufs"
	aufs_prefix="aufs5-"
	#regenerate="enable"
	if [ "x${regenerate}" = "xenable" ] ; then
		wget https://raw.githubusercontent.com/sfjro/${aufs_prefix}standalone/aufs${KERNEL_REL}/${aufs_prefix}kbuild.patch
		patch -p1 < ${aufs_prefix}kbuild.patch || aufs_fail
		rm -rf ${aufs_prefix}kbuild.patch
		${git_bin} add .
		${git_bin} commit -a -m 'merge: aufs-kbuild' -s

		wget https://raw.githubusercontent.com/sfjro/${aufs_prefix}standalone/aufs${KERNEL_REL}/${aufs_prefix}base.patch
		patch -p1 < ${aufs_prefix}base.patch || aufs_fail
		rm -rf ${aufs_prefix}base.patch
		${git_bin} add .
		${git_bin} commit -a -m 'merge: aufs-base' -s

		wget https://raw.githubusercontent.com/sfjro/${aufs_prefix}standalone/aufs${KERNEL_REL}/${aufs_prefix}mmap.patch
		patch -p1 < ${aufs_prefix}mmap.patch || aufs_fail
		rm -rf ${aufs_prefix}mmap.patch
		${git_bin} add .
		${git_bin} commit -a -m 'merge: aufs-mmap' -s

		wget https://raw.githubusercontent.com/sfjro/${aufs_prefix}standalone/aufs${KERNEL_REL}/${aufs_prefix}standalone.patch
		patch -p1 < ${aufs_prefix}standalone.patch || aufs_fail
		rm -rf ${aufs_prefix}standalone.patch
		${git_bin} add .
		${git_bin} commit -a -m 'merge: aufs-standalone' -s

		${git_bin} format-patch -4 -o ../patches/aufs/

		cd ../
		if [ ! -d ./${aufs_prefix}standalone ] ; then
			${git_bin} clone -b aufs${KERNEL_REL} https://github.com/sfjro/${aufs_prefix}standalone --depth=1
		else
			rm -rf ./${aufs_prefix}standalone || true
			${git_bin} clone -b aufs${KERNEL_REL} https://github.com/sfjro/${aufs_prefix}standalone --depth=1
		fi
		cd ./KERNEL/

		cp -v ../${aufs_prefix}standalone/Documentation/ABI/testing/*aufs ./Documentation/ABI/testing/
		mkdir -p ./Documentation/filesystems/aufs/
		cp -rv ../${aufs_prefix}standalone/Documentation/filesystems/aufs/* ./Documentation/filesystems/aufs/
		mkdir -p ./fs/aufs/
		cp -v ../${aufs_prefix}standalone/fs/aufs/* ./fs/aufs/
		cp -v ../${aufs_prefix}standalone/include/uapi/linux/aufs_type.h ./include/uapi/linux/

		${git_bin} add .
		${git_bin} commit -a -m 'merge: aufs' -s
		${git_bin} format-patch -5 -o ../patches/aufs/

		rm -rf ../${aufs_prefix}standalone/ || true

		${git_bin} reset --hard HEAD~5

		start_cleanup

		${git} "${DIR}/patches/aufs/0001-merge-aufs-kbuild.patch"
		${git} "${DIR}/patches/aufs/0002-merge-aufs-base.patch"
		${git} "${DIR}/patches/aufs/0003-merge-aufs-mmap.patch"
		${git} "${DIR}/patches/aufs/0004-merge-aufs-standalone.patch"
		${git} "${DIR}/patches/aufs/0005-merge-aufs.patch"

		wdir="aufs"
		number=5
		cleanup
	fi

	${git} "${DIR}/patches/aufs/0001-merge-aufs-kbuild.patch"
	${git} "${DIR}/patches/aufs/0002-merge-aufs-base.patch"
	${git} "${DIR}/patches/aufs/0003-merge-aufs-mmap.patch"
	${git} "${DIR}/patches/aufs/0004-merge-aufs-standalone.patch"
	${git} "${DIR}/patches/aufs/0005-merge-aufs.patch"
}

rt_cleanup () {
	echo "rt: needs fixup"
	exit 2
}

rt () {
	echo "dir: rt"
	rt_patch="${KERNEL_REL}${kernel_rt}"

	#${git_bin} revert --no-edit xyz

	#regenerate="enable"
	if [ "x${regenerate}" = "xenable" ] ; then
		wget -c https://www.kernel.org/pub/linux/kernel/projects/rt/${KERNEL_REL}/patch-${rt_patch}.patch.xz
		xzcat patch-${rt_patch}.patch.xz | patch -p1 || rt_cleanup
		rm -f patch-${rt_patch}.patch.xz
		rm -f localversion-rt
		${git_bin} add .
		${git_bin} commit -a -m 'merge: CONFIG_PREEMPT_RT Patch Set' -s
		${git_bin} format-patch -1 -o ../patches/rt/

		exit 2
	fi

	${git} "${DIR}/patches/rt/0001-merge-CONFIG_PREEMPT_RT-Patch-Set.patch"
}

wireguard_fail () {
	echo "WireGuard failed"
	exit 2
}

wireguard () {
	echo "dir: WireGuard"
	#regenerate="enable"
	if [ "x${regenerate}" = "xenable" ] ; then
		cd ../
		if [ ! -d ./WireGuard ] ; then
			${git_bin} clone https://git.zx2c4.com/WireGuard --depth=1
		else
			rm -rf ./WireGuard || true
			${git_bin} clone https://git.zx2c4.com/WireGuard --depth=1
		fi
		cd ./KERNEL/

		../WireGuard/contrib/kernel-tree/create-patch.sh | patch -p1 || wireguard_fail

		${git_bin} add .
		${git_bin} commit -a -m 'merge: WireGuard' -s
		${git_bin} format-patch -1 -o ../patches/WireGuard/

		rm -rf ../WireGuard/ || true

		${git_bin} reset --hard HEAD^

		start_cleanup

		${git} "${DIR}/patches/WireGuard/0001-merge-WireGuard.patch"

		wdir="WireGuard"
		number=1
		cleanup
	fi

	${git} "${DIR}/patches/WireGuard/0001-merge-WireGuard.patch"
}

ti_pm_firmware () {
	#http://git.ti.com/gitweb/?p=processor-firmware/ti-amx3-cm3-pm-firmware.git;a=shortlog;h=refs/heads/ti-v4.1.y-next
	echo "dir: drivers/ti/firmware"
	#regenerate="enable"
	if [ "x${regenerate}" = "xenable" ] ; then

		cd ../
		if [ ! -d ./ti-amx3-cm3-pm-firmware ] ; then
			${git_bin} clone -b ti-v4.1.y-next git://git.ti.com/processor-firmware/ti-amx3-cm3-pm-firmware.git --depth=1
		else
			rm -rf ./ti-amx3-cm3-pm-firmware || true
			${git_bin} clone -b ti-v4.1.y-next git://git.ti.com/processor-firmware/ti-amx3-cm3-pm-firmware.git --depth=1
		fi
		cd ./KERNEL/

		cp -v ../ti-amx3-cm3-pm-firmware/bin/am* ./firmware/

		${git_bin} add -f ./firmware/am*
		${git_bin} commit -a -m 'add am33x firmware' -s
		${git_bin} format-patch -1 -o ../patches/drivers/ti/firmware/

		rm -rf ../ti-amx3-cm3-pm-firmware/ || true

		${git_bin} reset --hard HEAD^

		start_cleanup

		${git} "${DIR}/patches/drivers/ti/firmware/0001-add-am33x-firmware.patch"

		wdir="drivers/ti/firmware"
		number=1
		cleanup
	fi

	${git} "${DIR}/patches/drivers/ti/firmware/0001-add-am33x-firmware.patch"
}

local_patch () {
	echo "dir: dir"
	${git} "${DIR}/patches/dir/0001-patch.patch"
}

#external_git
#aufs
#rt
#wireguard
ti_pm_firmware
#local_patch

pre_backports () {
	echo "dir: backports/${subsystem}"

	cd ~/linux-src/
	${git_bin} pull --no-edit https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git master
	${git_bin} pull --no-edit https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git master --tags
	${git_bin} pull --no-edit https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master --tags
	if [ ! "x${backport_tag}" = "x" ] ; then
		${git_bin} checkout ${backport_tag} -b tmp
	fi
	cd -
}

post_backports () {
	if [ ! "x${backport_tag}" = "x" ] ; then
		cd ~/linux-src/
		${git_bin} checkout master -f ; ${git_bin} branch -D tmp
		cd -
	fi

	${git_bin} add .
	${git_bin} commit -a -m "backports: ${subsystem}: from: linux.git" -s
	if [ ! -d ../patches/backports/${subsystem}/ ] ; then
		mkdir -p ../patches/backports/${subsystem}/
	fi
	${git_bin} format-patch -1 -o ../patches/backports/${subsystem}/
}

patch_backports (){
	echo "dir: backports/${subsystem}"
	${git} "${DIR}/patches/backports/${subsystem}/0001-backports-${subsystem}-from-linux.git.patch"
}

backports () {
	backport_tag="v4.x-y"

	subsystem="xyz"
	#regenerate="enable"
	if [ "x${regenerate}" = "xenable" ] ; then
		pre_backports

		mkdir -p ./x/
		cp -v ~/linux-src/x/* ./x/

		post_backports
		exit 2
	else
		patch_backports
	fi
}

###
#backports

packaging () {
	echo "dir: packaging"
	#regenerate="enable"
	if [ "x${regenerate}" = "xenable" ] ; then
		cp -v "${DIR}/3rdparty/packaging/Makefile" "${DIR}/KERNEL/scripts/package"
		cp -v "${DIR}/3rdparty/packaging/builddeb" "${DIR}/KERNEL/scripts/package"
		#Needed for v4.11.x and less
		patch -p1 < "${DIR}/patches/packaging/0002-Revert-deb-pkg-Remove-the-KBUILD_IMAGE-workaround.patch"
		${git_bin} commit -a -m 'packaging: sync builddeb changes' -s
		${git_bin} format-patch -1 -o "${DIR}/patches/packaging"
		exit 2
	else
		${git} "${DIR}/patches/packaging/0001-packaging-sync-builddeb-changes.patch"
	fi
}

packaging
echo "patch.sh ran successfully"
