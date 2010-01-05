#!/bin/bash

unset KERNEL_PATCH
unset SNAPSHOT

. version.sh

echo "This should be run natively on arm"

MAKE_KPKG=$(make-kpkg --help | grep Version | awk '{print $2}' | sed 's/\.//g')
REQ_MAKE_KPKG=12031

#x86 use:
#CC=/OE/angstrom-dev/cross/armv7a/bin/arm-angstrom-linux-gnueabi-

#arm use:
CC=

DIR=$PWD

mkdir -p ${DIR}/deploy/

DL_DIR=${DIR}/dl

mkdir -p ${DL_DIR}

function dl_kernel {
	wget -c --directory-prefix=${DL_DIR} http://www.kernel.org/pub/linux/kernel/v2.6/linux-${KERNEL_REL}.tar.bz2

if [ "${KERNEL_PATCH}" ] ; then
	wget -c --directory-prefix=${DL_DIR} http://www.kernel.org/pub/linux/kernel/v2.6/${DL_PATCH}.bz2
fi

if [ "${SNAPSHOT}" ] ; then
	wget -c --directory-prefix=${DL_DIR} http://www.kernel.org/pub/linux/kernel/v2.6/${DL_SNAPSHOT}.bz2
fi
}

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

function make_deb {
	cd ${DIR}/KERNEL/
	make-kpkg --arch=arm --cross_compile - clean
	fakeroot make-kpkg --append-to-version=-${BUILD} --revision=${BUILDREV}${DISTRO} --arch=armel --cross_compile - kernel_image
	cp ${DIR}/*.deb ${DIR}/deploy/
	cd ${DIR}
}

if [ "$MAKE_KPKG" -ge "$REQ_MAKE_KPKG" ] ; then

dl_kernel
extract_kernel
patch_kernel
copy_defconfig
make_menuconfig
make_deb

else

echo "Your Version of make-kpkg is too old, please upgrade"
echo "Debian/Ubuntu"
echo "wget http://ftp.us.debian.org/debian/pool/main/k/kernel-package/kernel-package_12.031_all.deb"
echo "sudo dpkg -i kernel-package_12.031_all.deb"

fi
