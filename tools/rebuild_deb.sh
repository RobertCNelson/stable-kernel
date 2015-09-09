#!/bin/sh -e
#
# Copyright (c) 2009-2015 Robert Nelson <robertcnelson@gmail.com>
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

DIR=$PWD
CORES=$(getconf _NPROCESSORS_ONLN)

mkdir -p ${DIR}/deploy/

patch_kernel () {
	cd ${DIR}/KERNEL

	export DIR
	/bin/sh -e ${DIR}/patch.sh || { git add . ; exit 1 ; }

	if [ ! "${RUN_BISECT}" ] ; then
		git add --all
		git commit --allow-empty -a -m "${KERNEL_TAG}-${BUILD} patchset"
	fi

	cd ${DIR}/
}

copy_defconfig () {
	cd ${DIR}/KERNEL/
	make ARCH=arm CROSS_COMPILE="${CC}" distclean
	make ARCH=arm CROSS_COMPILE="${CC}" ${config}
	cp -v .config ${DIR}/patches/ref_${config}
	cp -v ${DIR}/patches/defconfig .config
	cd ${DIR}/
}

make_menuconfig () {
	cd ${DIR}/KERNEL/
	make ARCH=arm CROSS_COMPILE="${CC}" menuconfig
	cp -v .config ${DIR}/patches/defconfig
	cd ${DIR}/
}

make_deb () {
	cd ${DIR}/KERNEL/

	deb_distro=$(lsb_release -cs | sed 's/\//_/g')
	if [ "x${deb_distro}" = "xn_a" ] ; then
		deb_distro="unstable"
	fi

	echo "-----------------------------"
	echo "make -j${CORES} ARCH=arm KBUILD_DEBARCH=${DEBARCH} KDEB_CHANGELOG_DIST=${deb_distro} LOCALVERSION=-${BUILD} CROSS_COMPILE="${CC}" KDEB_PKGVERSION=1${DISTRO} deb-pkg"
	echo "-----------------------------"
	fakeroot make -j${CORES} ARCH=arm KBUILD_DEBARCH=${DEBARCH} KDEB_CHANGELOG_DIST=${deb_distro} LOCALVERSION=-${BUILD} CROSS_COMPILE="${CC}" KDEB_PKGVERSION=1${DISTRO} deb-pkg
	mv ${DIR}/*.deb ${DIR}/deploy/

	if grep -q dtbs "${DIR}/KERNEL/arch/arm/Makefile"; then
		echo "make -j${CORES} ARCH=arm LOCALVERSION=-${BUILD} CROSS_COMPILE="${CC}" dtbs"
		echo "-----------------------------"
		make -j${CORES} ARCH=arm LOCALVERSION=-${BUILD} CROSS_COMPILE="${CC}" dtbs
		echo "-----------------------------"
	fi

	KERNEL_UTS=$(cat ${DIR}/KERNEL/include/generated/utsrelease.h | awk '{print $3}' | sed 's/\"//g' )

	cd ${DIR}/
}

make_pkg () {
	cd ${DIR}/KERNEL/

	deployfile="-${pkg}.tar.gz"
	tar_options="--create --gzip --file"

	if [ -f "${DIR}/deploy/${KERNEL_UTS}${deployfile}" ] ; then
		rm -rf "${DIR}/deploy/${KERNEL_UTS}${deployfile}" || true
	fi

	if [ -d ${DIR}/deploy/tmp ] ; then
		rm -rf ${DIR}/deploy/tmp || true
	fi
	mkdir -p ${DIR}/deploy/tmp

	echo "-----------------------------"
	echo "Building ${pkg} archive..."

	case "${pkg}" in
	modules)
		make -s ARCH=arm CROSS_COMPILE="${CC}" modules_install INSTALL_MOD_PATH=${DIR}/deploy/tmp
		;;
	firmware)
		make -s ARCH=arm CROSS_COMPILE="${CC}" firmware_install INSTALL_FW_PATH=${DIR}/deploy/tmp
		;;
	dtbs)
		if grep -q dtbs_install "${DIR}/KERNEL/arch/arm/Makefile"; then
			make -s ARCH=arm LOCALVERSION=-${BUILD} CROSS_COMPILE="${CC}" dtbs_install INSTALL_DTBS_PATH=${DIR}/deploy/tmp
		else
			find ./arch/arm/boot/ -iname "*.dtb" -exec cp -v '{}' ${DIR}/deploy/tmp/ \;
		fi
		;;
	esac

	echo "Compressing ${KERNEL_UTS}${deployfile}..."
	cd ${DIR}/deploy/tmp
	tar ${tar_options} ../${KERNEL_UTS}${deployfile} *

	cd ${DIR}/
	rm -rf ${DIR}/deploy/tmp || true

	if [ ! -f "${DIR}/deploy/${KERNEL_UTS}${deployfile}" ] ; then
		export ERROR_MSG="File Generation Failure: [${KERNEL_UTS}${deployfile}]"
		/bin/sh -e "${DIR}/scripts/error.sh" && { exit 1 ; }
	else
		ls -lh "${DIR}/deploy/${KERNEL_UTS}${deployfile}"
	fi
}

make_firmware_pkg () {
	pkg="firmware"
	make_pkg
}

make_dtbs_pkg () {
	pkg="dtbs"
	make_pkg
}

/bin/sh -e ${DIR}/tools/host_det.sh || { exit 1 ; }

if [ ! -f ${DIR}/system.sh ] ; then
	cp -v ${DIR}/system.sh.sample ${DIR}/system.sh
fi

unset CC
unset LINUX_GIT
. ${DIR}/system.sh
/bin/sh -e "${DIR}/scripts/gcc.sh" || { exit 1 ; }
. ${DIR}/.CC
echo "CROSS_COMPILE=${CC}"
if [ -f /usr/bin/ccache ] ; then
	echo "ccache [enabled]"
	CC="ccache ${CC}"
fi

. ${DIR}/version.sh
export LINUX_GIT

unset FULL_REBUILD
#FULL_REBUILD=1
if [ "${FULL_REBUILD}" ] ; then
	/bin/sh -e "${DIR}/scripts/git.sh" || { exit 1 ; }

	if [ "${RUN_BISECT}" ] ; then
		/bin/sh -e "${DIR}/scripts/bisect.sh" || { exit 1 ; }
	fi

	patch_kernel
	copy_defconfig
fi
if [ ! ${AUTO_BUILD} ] ; then
	make_menuconfig
fi
make_deb
make_firmware_pkg
if grep -q dtbs "${DIR}/KERNEL/arch/arm/Makefile"; then
	make_dtbs_pkg
fi