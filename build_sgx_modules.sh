#!/bin/bash -e
#SGX Modules

unset DIR
unset SGX
unset CC
unset GIT_MODE

. version.sh

DIR=$PWD

KERNEL_UTS=$(cat ${DIR}/KERNEL/include/generated/utsrelease.h | awk '{print $3}' | sed 's/\"//g' )

SGX_VERSION=3_01_00_02

#Currently Unsupported:
#bc_cat.c:490: error: implicit declaration of function ‘omap_rev_lt_3_0’
#SGX_VERSION=3_01_00_06

SGX_BIN=OMAP35x_Graphics_SDK_setuplinux_${SGX_VERSION}.bin

function sgx_setup {
if [ -e ${DIR}/dl/${SGX_BIN} ]; then
  echo "${SGX_BIN} found"
  if [ -e  ${DIR}/dl/OMAP35x_Graphics_SDK_setuplinux_${SGX_VERSION}/Makefile ]; then
    echo "Extracted ${SGX_BIN} found"
    SGX+=E
  else
    cd ${DIR}/dl/
    echo "${SGX_BIN} needs to be executable"
    sudo chmod +x ./${SGX_BIN}
    echo "running ${SGX_BIN}, accept all defaults and agree to the license"
    ./${SGX_BIN} --mode console --prefix ${DIR}/dl/OMAP35x_Graphics_SDK_setuplinux_${SGX_VERSION}
    cd ${DIR}
    SGX+=E
  fi
else
  echo ""
  echo "${SGX_BIN} not found"
  echo "Download ${SGX_BIN}"
  echo "DL From: http://software-dl.ti.com/dsps/dsps_public_sw/sdo_sb/targetcontent/gfxsdk/latest/index_FDS.html" 
  echo "Copy to: ${DIR}/dl"
  echo ""
fi
}

function build_sgx_modules {
	rm -rfd ${DIR}/omap3-sgx-modules || true
	mkdir ${DIR}/omap3-sgx-modules
	cp -r ${DIR}/dl/OMAP35x_Graphics_SDK_setuplinux_${SGX_VERSION}/GFX_Linux_KM/* ${DIR}/omap3-sgx-modules
	cd ${DIR}/omap3-sgx-modules

if [ "${GIT_MODE}" ] ; then
	git init
	git add .
        git commit -a -m 'OMAP35x_Graphics_SDK_setuplinux_'$SGX_VERSION''
        git tag -a OMAP35x_Graphics_SDK_setuplinux_${SGX_VERSION} -m OMAP35x_Graphics_SDK_setuplinux_${SGX_VERSION}
fi

if test "-$SGX_VERSION-" = "-3_01_00_02-"
then
	patch -s -p1 < ${DIR}/sgx/0001-Compile-fixes-for-recent-kernels.patch
	sed -i -e 's:/opt/oe/stuff/build/tmp/work/beagleboard-angstrom-linux-gnueabi/linux-omap-2.6.29-r44/git/:'$DIR'/KERNEL/:g' Makefile

	PVRBUILD = "release"
	MAKE_TARGETS=BUILD=${PVRBUILD}
fi

if test "-$SGX_VERSION-" = "-3_01_00_06-"
then
	sed -i -e 's:/opt/oe/stuff/build/tmp/work/beagleboard-angstrom-linux-gnueabi/linux-omap-2.6.29-r44/git/:'$DIR'/KERNEL/:g' Makefile

	PVRBUILD = "release"
	MAKE_TARGETS = " BUILD=${PVRBUILD} TI_PLATFORM=omap3630"
fi

if [ "${GIT_MODE}" ] ; then
	git add .
        git commit -a -m 'sgx patches'
        git tag -a OMAP35x_Graphics_SDK_setuplinux_${SGX_VERSION}-patch -m OMAP35x_Graphics_SDK_setuplinux_${SGX_VERSION}-patch
fi

	make ARCH=arm CROSS_COMPILE=${CC}

	mkdir -p ${DIR}/deploy/mod/lib/modules/${KERNEL_UTS}/kernel/drivers/gpu/pvr/
	cp -v ./pvrsrvkm.ko ${DIR}/deploy/mod/lib/modules/${KERNEL_UTS}/kernel/drivers/gpu/pvr/
	cp -v ./services4/3rdparty/dc_omap3430_linux/omaplfb.ko ${DIR}/deploy/mod/lib/modules/${KERNEL_UTS}/kernel/drivers/gpu/pvr/
	cp -v ./services4/3rdparty/bufferclass_ti/bufferclass_ti.ko ${DIR}/deploy/mod/lib/modules/${KERNEL_UTS}/kernel/drivers/gpu/pvr/

	cd ${DIR}
}

function copy_sgx_system_files {
	mkdir -p ${DIR}/deploy/mod/usr/lib/ES2.0
	mkdir -p ${DIR}/deploy/mod/usr/bin/ES2.0
	mkdir -p ${DIR}/deploy/mod/usr/lib/ES3.0
	mkdir -p ${DIR}/deploy/mod/usr/bin/ES3.0
	mkdir -p ${DIR}/deploy/mod/opt/pvr

	sudo cp ${DIR}/dl/OMAP35x_Graphics_SDK_setuplinux_${SGX_VERSION}/gfx_rel_es2.x/lib* ${DIR}/deploy/mod/usr/lib/ES2.0
	sudo cp ${DIR}/dl/OMAP35x_Graphics_SDK_setuplinux_${SGX_VERSION}/gfx_rel_es2.x/p[dv]* ${DIR}/deploy/mod/usr/bin/ES2.0

	sudo cp ${DIR}/dl/OMAP35x_Graphics_SDK_setuplinux_${SGX_VERSION}/gfx_rel_es3.x/lib* ${DIR}/deploy/mod/usr/lib/ES3.0
	sudo cp ${DIR}/dl/OMAP35x_Graphics_SDK_setuplinux_${SGX_VERSION}/gfx_rel_es3.x/p[dv]* ${DIR}/deploy/mod/usr/bin/ES3.0

	cp -v ${DIR}/tools/pvr ${DIR}/deploy/mod/opt/pvr
	cd ${DIR}
}

function rebuild_system_modules {
	cd ${DIR}/deploy/mod
	echo "Rebuilding $KERNEL_UTS-modules.tar.gz with SGX Libraries and Modules"
	tar czf ${DIR}/deploy/${KERNEL_UTS}-modules.tar.gz *
	echo "SGX modules are now in: $KERNEL_UTS-modules.tar.gz"
	cd ${DIR}
}

function tar_up_examples {
	cd ${DIR}/dl/OMAP35x_Graphics_SDK_setuplinux_${SGX_VERSION}/GFX_Linux_SDK
	echo "taring SDK example files for use on the OMAP board"
	tar czf ${DIR}/deploy/GFX_Linux_SDK.tar.gz *
	echo "SGX examples are in: GFX_Linux_SDK.tar.gz"
	cd ${DIR}
}

if [ -e ${DIR}/system.sh ]; then
	. system.sh

if [ -e ${DIR}/KERNEL/arch/arm/boot/uImage ]; then
{
	sgx_setup

if [ "$SGX" = "E" ]; then
	build_sgx_modules
	copy_sgx_system_files
	rebuild_system_modules
	tar_up_examples
fi

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
