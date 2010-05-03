#!/bin/bash -e

unset KERNEL_REL
unset KERNEL_PATCH
unset BUILD
unset CC
unset GIT_MODE
unset IS_LUCID
unset IS_ZIPPY_TWO

DIR=$PWD

mkdir -p ${DIR}/deploy/

DL_DIR=${DIR}/dl

mkdir -p ${DL_DIR}

function dl_kernel {
	wget -c --directory-prefix=${DL_DIR} http://www.kernel.org/pub/linux/kernel/v2.6/linux-${KERNEL_REL}.tar.bz2

if [ "${KERNEL_PATCH}" ] ; then
	wget -c --directory-prefix=${DL_DIR} http://www.kernel.org/pub/linux/kernel/v2.6/${DL_PATCH}.bz2
fi
}

function extract_kernel {
	echo "Cleaning Up"
	rm -rfd ${DIR}/KERNEL || true
	echo "Extracting: ${KERNEL_REL} Kernel"
	tar xjf ${DL_DIR}/linux-${KERNEL_REL}.tar.bz2
	mv linux-${KERNEL_REL} KERNEL
	cd ${DIR}/KERNEL
if [ "${KERNEL_PATCH}" ] ; then
	echo "Applying: ${KERNEL_PATCH} Patch"
	bzcat ${DL_DIR}/patch-${KERNEL_PATCH}.bz2 | patch -s -p1
fi
	cd ${DIR}/
}

function patch_kernel {
	cd ${DIR}/KERNEL
	export DIR KERNEL_REL GIT BOARD IS_ZIPPY_TWO
	/bin/bash -e ${DIR}/patch.sh
if [ "${KERNEL_PATCH}" ] ; then
	sed -i 's/EXTRAVERSION = .'$STABLE_PATCH'/EXTRAVERSION = .'$STABLE_PATCH'-'$BUILD'/g' ${DIR}/KERNEL/Makefile
else
	sed -i 's/EXTRAVERSION =/EXTRAVERSION = -'$BUILD'/g' ${DIR}/KERNEL/Makefile
fi
	cd ${DIR}/
}

function copy_defconfig {
	cd ${DIR}/KERNEL/
	make ARCH=arm CROSS_COMPILE=${CC} distclean
if [ "${IS_LUCID}" ] ; then
	cp ${DIR}/patches/lucid-defconfig .config
else
	cp ${DIR}/patches/defconfig .config
fi
	cd ${DIR}/
}

function make_menuconfig {
	cd ${DIR}/KERNEL/
	make ARCH=arm CROSS_COMPILE=${CC} menuconfig
if [ "${IS_LUCID}" ] ; then
	cp .config ${DIR}/patches/lucid-defconfig
else
	cp .config ${DIR}/patches/defconfig
fi
	cd ${DIR}/
}

function make_deb {
	cd ${DIR}/KERNEL/
	echo "fakeroot make ARCH=arm CROSS_COMPILE=${CC} KDEB_PKGVERSION=${BUILDREV}${DISTRO} deb-pkg"
	fakeroot make ARCH=arm CROSS_COMPILE=${CC} KDEB_PKGVERSION=${BUILDREV}${DISTRO} deb-pkg
	mv ${DIR}/*.deb ${DIR}/deploy/
	cd ${DIR}
}

if [ -e ${DIR}/system.sh ]; then
	. system.sh
	. version.sh

if [ "${IS_LUCID}" ] ; then
	echo ""
	echo "Building for Lucid (10.04)"
	echo ""
else
	echo ""
	echo "Building for Debian Lenny/Squeeze/Sid & Ubuntu 9.04/9.10"
	echo ""
fi

if [ "${IS_ZIPPY_TWO}" ] ; then
	echo "Building with Zippy2 Support"
	echo ""
fi

	dl_kernel
	extract_kernel
	patch_kernel
	copy_defconfig
	#make_menuconfig
	make_deb
else
	echo "Missing system.sh, please copy system.sh.sample to system.sh and edit as needed"
	echo "cp system.sh.sample system.sh"
	echo "gedit system.sh"
fi

