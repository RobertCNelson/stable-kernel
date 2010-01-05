#!/bin/bash -e
#SGX Modules

unset CC

. version.sh

DIR=$PWD

if [ -e ${DIR}/system.sh ]; then
	. system.sh

if [ -e ${DIR}/KERNEL/arch/arm/boot/uImage ]; then
{

rm -rfd omap3-sgx-modules-${PV} || true

mkdir -p ${DIR}/deploy/sgx-modules

tar xjf ${DIR}/sgx/omap3-sgx-modules-${PV}.tar.bz2

cd omap3-sgx-modules-${PV}

patch -p1 < ${DIR}/sgx/0002-Compile-fixes-for-DSS2.patch
patch -p1 < ${DIR}/sgx/rotation-dss2.patch
patch -p1 < ${DIR}/sgx/build_es3.x_sgx.patch
patch -p1 < ${DIR}/sgx/proc-interface.patch
sed -i -e 's:/home1/pratheesh/workdir/opt/linux/kernel_org/REL_OMAP35x_02.01.00.04/src/kernel/linux-02.01.00.04:'$DIR'/KERNEL/:g' Makefile

PVRBUILD=release
MAKE_TARGETS=BUILD=${PVRBUILD}

make ARCH=arm CROSS_COMPILE=${CC}

cp ./pvrsrvkm.ko ${DIR}/deploy/sgx-modules/
cp ./services4/3rdparty/dc_omap3430_linux/omaplfb.ko ${DIR}/deploy/sgx-modules/

cd ${DIR}

}
else
{

echo "run build_kernel.sh first"

}
fi
else
	echo "Missing system.sh, please copy system.sh.sample to system.sh and edit as needed"
	echo "cp system.sh.sample system.sh"
	echo "gedit system.sh"
fi
