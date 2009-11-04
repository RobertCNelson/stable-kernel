#!/bin/bash
#2.6.29-x45.2

KERNEL_REL=2.6.29
BUILD=x45.2
GIT=58cf2f1

BUILDREV=1.0
DISTRO=jaunty

echo "This should be run natively on arm"

MAKE_KPKG=$(make-kpkg --help | grep Version | awk '{print $2}' | sed 's/\.//g')
REQ_MAKE_KPKG=12024

#x86 use:
#CC=/OE/angstrom-dev/cross/armv7a/bin/arm-angstrom-linux-gnueabi-

#arm use:
CC=

#USB patches is board specific
BOARD=beagleboard

DIR=$PWD

mkdir -p ${DIR}/deploy/
mkdir -p ${DIR}/dl

wget -c --directory-prefix=${DIR}/dl/ http://www.kernel.org/pub/linux/kernel/v2.6/linux-${KERNEL_REL}.tar.bz2

function extract_kernel {
	rm -rfd ${DIR}/KERNEL
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

extract_kernel
patch_kernel
copy_defconfig
make_menuconfig
make_deb

else

echo "Your Version of make-kpkg is too old, please upgrade"
echo "Debian/Ubuntu"
echo "wget http://ftp.us.debian.org/debian/pool/main/k/kernel-package/kernel-package_12.024_all.deb"
echo "sudo dpkg -i kernel-package_12.024_all.deb"

fi
