#!/bin/bash
# Split out, so build_kernel.sh and build_deb.sh can share..

echo "Starting patch.sh"

patch -s -p1 < "${DIR}/patches/rcn/bug16310.diff"

patch -s -p1 < "${DIR}/patches/gpio/0001-ARM-OMAP-Beagle-revision-detection.patch"
patch -s -p1 < "${DIR}/patches/gpio/0002-ARM-OMAP-Beagle-Cx-boards-use-revision-detection.patch"
patch -s -p1 < "${DIR}/patches/gpio/0003-ARM-OMAP-Beagle-support-MMC-gpio_wp-differences-on-x.patch"


function dss2 {
echo "dss2 patches"
patch -s -p1 < ${DIR}/patches/dss2/DSS2-overo-fixup.patch

#http://www.spinics.net/lists/linux-omap/msg34582.html
patch -s -p1 < "${DIR}/patches/dss2/0001-OMAP-DSS2-don-t-power-off-a-panel-twice.patch"

patch -s -p1 < "${DIR}/patches/dss2/OMAP2-OMAPFB-Fix-invalid-bpp-for-PAL-and-NTSC-modes.patch"

}

function musb {
echo "musb patches"
patch -s -p1 < "${DIR}/patches/musb/force-fifo_mode-5.diff"
}

function micrel {
echo "micrel patches"
patch -s -p1 < "${DIR}/patches/micrel/linux-2.6.35/01_eeprom_93cx6_2.6.35.patch"
patch -s -p1 < "${DIR}/patches/micrel/linux-2.6.35/02_eeprom_93cx6_2.6.35.patch"
patch -s -p1 < "${DIR}/patches/micrel/linux-2.6.35/03_ksz8851_2.6.35.patch"
patch -s -p1 < "${DIR}/patches/micrel/linux-2.6.35/04_ksz8851_2.6.35.patch"

patch -s -p1 < "${DIR}/patches/micrel/linux-2.6.35/06_ksz8851_2.6.35.patch"
patch -s -p1 < "${DIR}/patches/micrel/linux-2.6.35/07_ksz8851_2.6.35.patch"
patch -s -p1 < "${DIR}/patches/micrel/linux-2.6.35/08_ksz8851_2.6.35.patch"
patch -s -p1 < "${DIR}/patches/micrel/linux-2.6.35/09_ksz8851_2.6.35.patch"
patch -s -p1 < "${DIR}/patches/micrel/linux-2.6.35/10_ksz8851_2.6.35.patch"
patch -s -p1 < "${DIR}/patches/micrel/linux-2.6.35/11_ksz8851_2.6.35.patch"
patch -s -p1 < "${DIR}/patches/micrel/linux-2.6.35/12_ksz8851_2.6.35.patch"

patch -s -p1 < "${DIR}/patches/micrel/linux-2.6.35/15_ksz8851_2.6.35.patch"

patch -s -p1 < "${DIR}/patches/micrel/linux-2.6.35/18_ksz8851_2.6.35.patch"

#noticed by cwillu july 18th
patch -s -p1 < "${DIR}/patches/micrel/linux-2.6.35/null-pointer-memory-leak.patch"
}

function zippy {
echo "zippy support"
patch -s -p1 < ${DIR}/patches/angstrom/0003-ARM-OMAP-add-support-for-TCT-Zippy-to-Beagle-board-fixup.patch
patch -s -p1 < ${DIR}/patches/angstrom/0043-ARM-OMAP-beagleboard-Add-infrastructure-to-do-fixups-fixup.patch
patch -s -p1 < ${DIR}/patches/rcn/beagle-zippy-dont-load-i2c-on-boards-with-nozippy.diff
}

function xm {
echo "early xm support"
patch -s -p1 < ${DIR}/patches/xm/xm-dvi-ehci-support.diff
patch -s -p1 < ${DIR}/patches/xm/sakoman/0001-ARM-OMAP-Add-macros-for-comparing-silicon-revision.patch
patch -s -p1 < ${DIR}/patches/xm/sakoman/0001-OMAP-DSS2-check-for-both-cpu-type-and-revision-rathe.patch
patch -s -p1 < ${DIR}/patches/xm/sakoman/0001-OMAP-DSS2-enable-hsclk-in-dsi_pll_init-for-OMAP36XX.patch
patch -s -p1 < "${DIR}/patches/arago-project/0001-omap3-Increase-limit-on-bootarg-mpurate.patch"
patch -s -p1 < "${DIR}/patches/arago-project/0001-AM37x-Switch-SGX-clocks-to-200MHz.patch"
}

function nand {
echo "new nand interface"
patch -s -p1 < ${DIR}/patches/nand/0001-ARM-OMAP-Beagle-use-new-gpmc-nand-infrastructure-fixup.patch
patch -s -p1 < ${DIR}/patches/nand/0001-ARM-OMAP-Overo-use-new-gpmc-nand-infrastructure.patch
}

function sgx {
echo "merge in ti sgx modules"
patch -s -p1 < ${DIR}/patches/sgx/0001-OMAP3-SGX-Merge-TI-3.01.00.02-Kernel-Modules.patch
patch -s -p1 < ${DIR}/patches/sgx/0001-OMAP3-SGX-setup-staging-makefile.patch
patch -s -p1 < ${DIR}/patches/sgx/0001-OMAP3-SGX-TI-3.01.00.02-mach-to-plat.diff
patch -s -p1 < ${DIR}/patches/sgx/0001-OMAP3-SGX-Kconfig-updates.diff
patch -s -p1 < ${DIR}/patches/sgx/0001-OMAP3-SGX-TI-3.01.00.02-update-bufferclass_ti-Kbuild.diff
patch -s -p1 < ${DIR}/patches/sgx/0001-OMAP3-SGX-TI-3.01.00.02-update-bufferclass_ti-kfree-kmalloc.diff
patch -s -p1 < ${DIR}/patches/sgx/0001-OMAP3-SGX-TI-3.01.00.02-update-dc_omap3430_linux-Kbuild.diff
#3.01.00.06
patch -s -p1 < ${DIR}/patches/sgx/0001-OMAP3-SGX-Merge-TI-3.01.00.06-into-TI-3.01.00.02.patch
patch -s -p1 < ${DIR}/patches/sgx/0001-OMAP3-SGX-TI-3.01.00.06-update-bufferclass_ti-kfree-kmalloc.diff
patch -s -p1 < ${DIR}/patches/sgx/0001-OMAP3-SGX-TI-3.01.00.06-2.6.32-PSP.diff
patch -s -p1 < ${DIR}/patches/sgx/0001-OMAP3-SGX-TI-3.01.00.06-use-omap3630.diff
}

function panda {
echo "merge in panda support"
patch -s -p1 < "${DIR}/patches/panda/0001-omap4-Add-OMAP4-Panda-Support.patch"
}

function igepv2 {
echo "igepv2 board related patches"
patch -s -p1 < "${DIR}/patches/igepv2/0001-ARM-OMAP3-Add-S-Video-output-to-IGEPv2-board.patch"
}

dss2
musb
micrel
zippy
xm
nand
sgx
panda
igepv2

echo "patch.sh ran successful"

