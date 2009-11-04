#!/bin/bash

. version.sh

#x86 use:
CC=/OE/angstrom-dev/cross/armv7a/bin/arm-angstrom-linux-gnueabi-

#arm use:
#CC=

DIR=$PWD

echo "checking for uboot-mkimage"
sudo apt-get install uboot-mkimage

mkdir -p ${DIR}/deploy/
mkdir -p ${DIR}/dl

wget -c --directory-prefix=${DIR}/dl/ http://www.kernel.org/pub/linux/kernel/v2.6/linux-${KERNEL_REL}.tar.bz2

function extract_kernel {
	rm -rfd ${DIR}/KERNEL/
	tar xjf ${DIR}/dl/linux-${KERNEL_REL}.tar.bz2
	mv linux-${KERNEL_REL} KERNEL
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
	cp arch/arm/boot/uImage ${DIR}/deploy/${KERNEL_REL}-${BUILD}.uImage
	cd ${DIR}
}

function make_modules {
	cd ${DIR}/KERNEL/
	make -j2 ARCH=arm CROSS_COMPILE=${CC} modules
	mkdir -p ${DIR}/deploy/mod
	make ARCH=arm CROSS_COMPILE=${CC} modules_install INSTALL_MOD_PATH=${DIR}/deploy/mod
	cd ${DIR}/deploy/mod
	tar czf ../${KERNEL_REL}-${BUILD}-modules.tar.gz *
	cd ${DIR}
}

extract_kernel
patch_kernel
copy_defconfig
make_menuconfig
make_uImage
make_modules


