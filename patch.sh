#!/bin/bash
# Split out, so build_kernel.sh and build_deb.sh can share..

function musb {
echo "musb fifo tweaks"
patch -s -p1 < ${DIR}/patches/musb/musb-Add-new-fifo-table-for-a-OMAP3-errata.patch
patch -s -p1 < ${DIR}/patches/musb/enable-fifo_mode_5_for_OMAP34XX.diff
}

function micrel {
echo "micrel patches"

patch -s -p1 < ${DIR}/patches/micrel/linux-2.6.33/01_eeprom_93cx6_2.6.33.patch
patch -s -p1 < ${DIR}/patches/micrel/linux-2.6.33/02_eeprom_93cx6_2.6.33.patch
patch -s -p1 < ${DIR}/patches/micrel/linux-2.6.33/03_ksz8851_2.6.33.patch
patch -s -p1 < ${DIR}/patches/micrel/linux-2.6.33/04_ksz8851_2.6.33.patch
patch -s -p1 < ${DIR}/patches/micrel/linux-2.6.33/05_ksz8851_2.6.33.patch
patch -s -p1 < ${DIR}/patches/micrel/linux-2.6.33/06_ksz8851_2.6.33.patch
patch -s -p1 < ${DIR}/patches/micrel/linux-2.6.33/07_ksz8851_2.6.33.patch
patch -s -p1 < ${DIR}/patches/micrel/linux-2.6.33/08_ksz8851_2.6.33.patch
patch -s -p1 < ${DIR}/patches/micrel/linux-2.6.33/09_ksz8851_2.6.33.patch
patch -s -p1 < ${DIR}/patches/micrel/linux-2.6.33/10_ksz8851_2.6.33.patch
patch -s -p1 < ${DIR}/patches/micrel/linux-2.6.33/11_ksz8851_2.6.33.patch
patch -s -p1 < ${DIR}/patches/micrel/linux-2.6.33/12_ksz8851_2.6.33.patch
#patch -s -p1 < ${DIR}/patches/micrel/linux-2.6.33/13_omap3_beagle_2.6.33.patch
#patch -s -p1 < ${DIR}/patches/micrel/linux-2.6.33/14_omap3_beagle_2.6.33.patch
patch -s -p1 < ${DIR}/patches/micrel/linux-2.6.33/15_ksz8851_2.6.33.patch
patch -s -p1 < ${DIR}/patches/micrel/linux-2.6.33/16_compressed_2.6.33.patch
patch -s -p1 < ${DIR}/patches/micrel/micrel-eth.patch
}

function rcn {
echo "rcn patches"
patch -s -p1 < ${DIR}/patches/rcn/CONFIG-enable-arm-rt2870-staging.diff
}

function dss2 {
echo "dss2 patches"
patch -s -p1 < ${DIR}/patches/dss2/DSS2-koen-beagle.diff
patch -s -p1 < ${DIR}/patches/rcn/beagle-enable-2nd-i2c.diff
patch -s -p1 < ${DIR}/patches/rcn/0001-OMAP-DSS2-fix-irq-stats-compilation.patch
patch -s -p1 < ${DIR}/patches/dss2/DSS2-overo-fixup.patch
}

function vfp {
echo "Apply vfp patches, should help pixman"

if [ "${GIT_MODE}" ] ; then
 git am ${DIR}/patches/vfp/0001-ARM-vfp-fix-vfp_sync_state.patch
 git am ${DIR}/patches/vfp/0001-ARM-vfp-ptrace-no-point-flushing-hw-context-for-PTRA.patch
 git am ${DIR}/patches/vfp/0001-Recently-the-UP-versions-of-these-functions-were-ref.patch
 git am ${DIR}/patches/vfp/0002-Signal-handlers-can-use-floating-point-so-prevent-th.patch
else
 patch -s -p1 < ${DIR}/patches/vfp/0001-ARM-vfp-fix-vfp_sync_state.patch
 patch -s -p1 < ${DIR}/patches/vfp/0001-ARM-vfp-ptrace-no-point-flushing-hw-context-for-PTRA.patch
 patch -s -p1 < ${DIR}/patches/vfp/0001-Recently-the-UP-versions-of-these-functions-were-ref.patch
 patch -s -p1 < ${DIR}/patches/vfp/0002-Signal-handlers-can-use-floating-point-so-prevent-th.patch
fi
}

musb
rcn
dss2
vfp

if [ "${IS_ZIPPY_TWO}" ] ; then
	micrel
fi

echo "Patching Successful"




