#!/bin/bash -e

unset KERNEL_REL
unset KERNEL_PATCH
unset BUILD
unset CC
unset GIT_MODE
unset IS_LUCID
unset IS_ZIPPY_TWO

CCACHE=ccache
DIR=$PWD

CORES=`cat /proc/cpuinfo | grep cpu\ cores | head -1 | awk '{print $4}'`

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
if [ "${GIT_MODE}" ] ; then
	git init
	git add .
        git commit -a -m ''$KERNEL_REL' Kernel'
        git tag -a $KERNEL_REL -m $KERNEL_REL
fi
if [ "${KERNEL_PATCH}" ] ; then
	echo "Applying: ${KERNEL_PATCH} Patch"
	bzcat ${DL_DIR}/patch-${KERNEL_PATCH}.bz2 | patch -s -p1
if [ "${GIT_MODE}" ] ; then
	git add .
        git commit -a -m ''$KERNEL_PATCH' Kernel'
        git tag -a $KERNEL_PATCH -m $KERNEL_PATCH
fi
fi
	cd ${DIR}/
}

function patch_kernel {
	cd ${DIR}/KERNEL
	export DIR KERNEL_REL GIT_MODE BOARD IS_ZIPPY_TWO
	/bin/bash -e ${DIR}/patch.sh
if [ "${KERNEL_PATCH}" ] ; then
	sed -i 's/EXTRAVERSION = .'$STABLE_PATCH'/EXTRAVERSION = .'$STABLE_PATCH'-'$BUILD'/g' ${DIR}/KERNEL/Makefile
else
	sed -i 's/EXTRAVERSION =/EXTRAVERSION = -'$BUILD'/g' ${DIR}/KERNEL/Makefile
fi
if [ "${GIT_MODE}" ] ; then
if [ "${KERNEL_PATCH}" ] ; then
        git add .
        git commit -a -m ''$KERNEL_PATCH'-'$BUILD''
        git tag -a $KERNEL_PATCH-$BUILD -m $KERNEL_PATCH-$BUILD
else
        git add .
        git commit -a -m ''$KERNEL_REL'-'$BUILD''
        git tag -a $KERNEL_REL-$BUILD -m $KERNEL_REL-$BUILD
fi
fi
#Test Patches:

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

function make_uImage {
	cd ${DIR}/KERNEL/
	time make -j${CORES} ARCH=arm CROSS_COMPILE="${CCACHE} ${CC}" CONFIG_DEBUG_SECTION_MISMATCH=y uImage
	KERNEL_UTS=$(cat ${DIR}/KERNEL/include/generated/utsrelease.h | awk '{print $3}' | sed 's/\"//g' )
	cp arch/arm/boot/uImage ${DIR}/deploy/${KERNEL_UTS}.uImage
	cd ${DIR}
}

function make_modules {
	cd ${DIR}/KERNEL/
	time make -j${CORES} ARCH=arm CROSS_COMPILE="${CCACHE} ${CC}" modules
	rm -rfd ${DIR}/deploy/mod &> /dev/null || true
	mkdir -p ${DIR}/deploy/mod
	make ARCH=arm CROSS_COMPILE=${CC} modules_install INSTALL_MOD_PATH=${DIR}/deploy/mod
	cd ${DIR}/deploy/mod
	tar czf ../${KERNEL_UTS}-modules.tar.gz *
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
	make_menuconfig
	make_uImage
	make_modules
else
	echo "Missing system.sh, please copy system.sh.sample to system.sh and edit as needed"
	echo "cp system.sh.sample system.sh"
	echo "gedit system.sh"
fi

