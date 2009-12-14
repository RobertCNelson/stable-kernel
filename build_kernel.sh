#!/bin/bash

unset KERNEL_PATCH
unset SNAPSHOT

. version.sh

#x86 use:
CC=/OE/angstrom-dev/cross/armv7a/bin/arm-angstrom-linux-gnueabi-

#arm use:
#CC=

DIR=$PWD

mkdir -p ${DIR}/deploy/

DL_DIR=${DIR}/dl

mkdir -p ${DL_DIR}

wget -c --directory-prefix=${DL_DIR} http://www.kernel.org/pub/linux/kernel/v2.6/linux-${KERNEL_REL}.tar.bz2

if [ "${KERNEL_PATCH}" ] ; then
wget -c --directory-prefix=${DL_DIR} http://www.kernel.org/pub/linux/kernel/v2.6/${DL_PATCH}.bz2
fi

if [ "${SNAPSHOT}" ] ; then
wget -c --directory-prefix=${DL_DIR} http://www.kernel.org/pub/linux/kernel/v2.6/${DL_SNAPSHOT}.bz2
fi

function extract_kernel {
	echo "Cleaning Up"
	rm -rfd ${DIR}/KERNEL
	echo "Extracting: ${KERNEL_REL} Kernel"
	tar xjf ${DL_DIR}/linux-${KERNEL_REL}.tar.bz2
	mv linux-${KERNEL_REL} KERNEL
if [ "${KERNEL_PATCH}" ] ; then
	cd ${DIR}/KERNEL
	echo "Applying: ${KERNEL_PATCH} Patch"
	bzcat ${DL_DIR}/patch-${KERNEL_PATCH}.bz2 | patch -s -p1
	cd ${DIR}
fi
if [ "${SNAPSHOT}" ] ; then
	cd ${DIR}/KERNEL
	echo "Applying: ${KERNEL_PATCH}-${SNAPSHOT} Patch"
	bzcat ${DL_DIR}/patch-${KERNEL_PATCH}-${SNAPSHOT}.bz2 | patch -s -p1
	cd ${DIR}
fi
	cd ${DIR}
}

function patch_kernel {
	cd ${DIR}/KERNEL
	export DIR KERNEL_REL GIT BOARD
	/bin/bash ${DIR}/patch.sh
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
if [ "${SNAPSHOT}" ] ; then
	cp arch/arm/boot/uImage ${DIR}/deploy/${KERNEL_PATCH}-${SNAPSHOT}-${BUILD}.uImage
else
if [ "${KERNEL_PATCH}" ] ; then
	cp arch/arm/boot/uImage ${DIR}/deploy/${KERNEL_PATCH}-${BUILD}.uImage
else
	cp arch/arm/boot/uImage ${DIR}/deploy/${KERNEL_REL}-${BUILD}.uImage
fi
fi
	cd ${DIR}
}

function make_modules {
	cd ${DIR}/KERNEL/
	make -j2 ARCH=arm CROSS_COMPILE=${CC} modules
	mkdir -p ${DIR}/deploy/mod
	make ARCH=arm CROSS_COMPILE=${CC} modules_install INSTALL_MOD_PATH=${DIR}/deploy/mod
	cd ${DIR}/deploy/mod
if [ "${SNAPSHOT}" ] ; then
	tar czf ../${KERNEL_PATCH}-${SNAPSHOT}-${BUILD}-modules.tar.gz *
else
if [ "${KERNEL_PATCH}" ] ; then
	tar czf ../${KERNEL_PATCH}-${BUILD}-modules.tar.gz *
else
	tar czf ../${KERNEL_REL}-${BUILD}-modules.tar.gz *
fi
fi
	cd ${DIR}
}

extract_kernel
patch_kernel
copy_defconfig
make_menuconfig
make_uImage
make_modules


