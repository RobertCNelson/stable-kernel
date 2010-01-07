#!/bin/bash -e

unset KERNEL_PATCH
unset CC
unset GIT_MODE

. version.sh

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
	cd ${DIR}
}

function patch_kernel {
	cd ${DIR}/KERNEL
	export DIR KERNEL_REL GIT BOARD
	/bin/bash -e ${DIR}/patch.sh
if [ "${KERNEL_PATCH}" ] ; then
	sed -i 's/EXTRAVERSION = .'$STABLE_PATCH'/EXTRAVERSION = .'$STABLE_PATCH'-'$BUILD'/g' ${DIR}/KERNEL/Makefile
else
	sed -i 's/EXTRAVERSION = /EXTRAVERSION = -'$BUILD'/g' ${DIR}/KERNEL/Makefile
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
	cd ${DIR}/
}

function copy_defconfig {
	cd ${DIR}/KERNEL/
	make ARCH=arm CROSS_COMPILE=${CC} distclean
	cp ${DIR}/patches/defconfig .config
	cd ${DIR}/
}

function make_menuconfig {
	cd ${DIR}/KERNEL/
	make ARCH=arm CROSS_COMPILE=${CC} menuconfig
	cp .config ${DIR}/patches/defconfig
	cd ${DIR}/
}

function make_uImage {
	cd ${DIR}/KERNEL/
	make -j2 ARCH=arm CROSS_COMPILE=${CC} uImage
	#for: 2.6.33+
	#KERNEL_UTS=$(cat ${DIR}/KERNEL/include/generated/utsrelease.h | awk '{print $3}' | sed 's/\"//g' )
	KERNEL_UTS=$(cat ${DIR}/KERNEL/include/linux/utsrelease.h | awk '{print $3}' | sed 's/\"//g' )
	cp arch/arm/boot/uImage ${DIR}/deploy/${KERNEL_UTS}.uImage
	cd ${DIR}
}

function make_modules {
	cd ${DIR}/KERNEL/
	make -j2 ARCH=arm CROSS_COMPILE=${CC} modules
	rm -rfd ${DIR}/deploy/mod &> /dev/null || true
	mkdir -p ${DIR}/deploy/mod
	make ARCH=arm CROSS_COMPILE=${CC} modules_install INSTALL_MOD_PATH=${DIR}/deploy/mod
	cd ${DIR}/deploy/mod
	tar czf ../${KERNEL_UTS}-modules.tar.gz *
	cd ${DIR}
}

if [ -e ${DIR}/system.sh ]; then
	. system.sh

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

