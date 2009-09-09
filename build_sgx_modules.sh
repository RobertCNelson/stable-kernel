#!/bin/bash
#SGX Modules

PV=1.3.13.1607

#x86 use:
CC=~/bin/arm-2009q1-203/bin/arm-none-linux-gnueabi-

#arm use:
#CC=

DIR=$PWD

if [ -e ${DIR}/KERNEL/arch/arm/boot/uImage ]; then
{

mkdir -p ${DIR}/deploy/sgx-modules

tar xjf ${DIR}/sgx/omap3-sgx-modules-${PV}.tar.bz2

cd omap3-sgx-modules-${PV}

patch -p1 < ${DIR}/sgx/0002-Compile-fixes-for-DSS2.patch
patch -p1 < ${DIR}/sgx/rotation-dss2.patch
patch -p1 < ${DIR}/sgx/build_es3.x_sgx.patch
sed -i -e 's:/home1/pratheesh/workdir/opt/linux/kernel_org/REL_OMAP35x_02.01.00.04/src/kernel/linux-02.01.00.04:'$DIR'/KERNEL/:g' Makefile

PVRBUILD=release
MAKE_TARGETS=BUILD=${PVRBUILD}

make CROSS_COMPILE=${CC}

cp ./pvrsrvkm.ko ${DIR}/deploy/sgx-modules/
cp ./services4/3rdparty/dc_omap3430_linux/omaplfb.ko ${DIR}/deploy/sgx-modules/

cd ${DIR}

}
else
{

echo "run build_kernel.sh first"

}
fi

