#!/bin/bash
# Split out, so build_kernel.sh and build_deb.sh can share..

echo "Starting patch.sh"

function dss2 {
echo "dss2 patches"

patch -s -p1 < ${DIR}/patches/dss2/tomba/0001-OMAP-Enable-DSS2-in-OMAP3EVM-defconfig.patch
patch -s -p1 < ${DIR}/patches/dss2/tomba/0002-OMAP-AM3517-Enable-DSS2-in-AM3517EVM-defconfig.patch
patch -s -p1 < ${DIR}/patches/dss2/tomba/0003-OMAP-DSS2-Add-Kconfig-option-for-DPI-display-type.patch
patch -s -p1 < ${DIR}/patches/dss2/tomba/0004-OMAP-DSS2-Remove-redundant-enable-disable-calls-from.patch
patch -s -p1 < ${DIR}/patches/dss2/tomba/0005-OMAP-DSS2-Use-vdds_sdi-regulator-supply-in-SDI.patch
patch -s -p1 < ${DIR}/patches/dss2/tomba/0006-OMAP-DSS2-fix-lock_fb_info-and-omapfb_lock-locking-o.patch
patch -s -p1 < ${DIR}/patches/dss2/tomba/0007-OMAP-DSS2-check-lock_fb_info-return-value.patch
patch -s -p1 < ${DIR}/patches/dss2/tomba/0008-OMAP-DSS2-VENC-don-t-call-platform_enable-disable-tw.patch
patch -s -p1 < ${DIR}/patches/dss2/tomba/0009-OMAP-DSS2-Fix-device-disable-when-driver-is-not-load.patch
patch -s -p1 < ${DIR}/patches/dss2/tomba/0010-OMAP-DSS2-Make-partial-update-width-even.patch
patch -s -p1 < ${DIR}/patches/dss2/tomba/0011-OMAP-DSS2-Taal-add-mutex-to-protect-panel-data.patch
patch -s -p1 < ${DIR}/patches/dss2/tomba/0012-OMAP-DSS2-Taal-Fix-DSI-bus-locking-problem.patch
patch -s -p1 < ${DIR}/patches/dss2/tomba/0013-OMAP-LCD-LS037V7DW01-Add-Backlight-driver-support.patch
patch -s -p1 < ${DIR}/patches/dss2/tomba/0014-OMAP-DSS2-TPO-TD03MTEA1-fix-Kconfig-dependency.patch
patch -s -p1 < ${DIR}/patches/dss2/tomba/0015-OMAP-RX51-Add-LCD-Panel-support.patch
patch -s -p1 < ${DIR}/patches/dss2/tomba/0016-OMAP-RX51-Add-Touch-Controller-in-SPI-board-info.patch
patch -s -p1 < ${DIR}/patches/dss2/tomba/0017-OMAP-DSS2-Add-ACX565AKM-Panel-Driver.patch
patch -s -p1 < ${DIR}/patches/dss2/tomba/0018-OMAP-RX51-Update-board-defconfig.patch
patch -s -p1 < ${DIR}/patches/dss2/tomba/0019-OMAP3630-DSS2-Updating-MAX-divider-value.patch
patch -s -p1 < ${DIR}/patches/dss2/tomba/0020-OMAP2-DSS-Add-missing-line-for-update-bg-color.patch
patch -s -p1 < ${DIR}/patches/dss2/tomba/0021-board-omap3-beagle-add-DSS2-support.patch
patch -s -p1 < ${DIR}/patches/dss2/tomba/0022-OMAP-DSS2-omap_dss_probe-conditional-compilation-cle.patch
patch -s -p1 < ${DIR}/patches/dss2/tomba/0023-OMAP-DSS2-Fix-omap_dss_probe-error-path.patch

patch -s -p1 < ${DIR}/patches/dss2/DSS2-overo-fixup.patch
patch -s -p1 < ${DIR}/patches/dss2/reboot-fix.diff
}

function musb {
echo "musb patches"
patch -s -p1 < ${DIR}/patches/musb/force-fifo_mode-5.diff
}

function vfp {
echo "vfp patches"
#git am ${DIR}/patches/vfp/0002-Signal-handlers-can-use-floating-point-so-prevent-th.patch
}

function micrel {
echo "micrel patches"
patch -s -p1 < ${DIR}/patches/micrel/linux-2.6.34/01_eeprom_93cx6_2.6.34.patch
patch -s -p1 < ${DIR}/patches/micrel/linux-2.6.34/02_eeprom_93cx6_2.6.34.patch

patch -s -p1 < ${DIR}/patches/micrel/linux-2.6.34/03_ksz8851_2.6.34-fixup.patch
#patch -s -p1 < ${DIR}/patches/micrel/linux-2.6.34/03_ksz8851_2.6.34.patch

patch -s -p1 < ${DIR}/patches/micrel/linux-2.6.34/04_ksz8851_2.6.34.patch
patch -s -p1 < ${DIR}/patches/micrel/linux-2.6.34/05_ksz8851_2.6.34.patch
patch -s -p1 < ${DIR}/patches/micrel/linux-2.6.34/06_ksz8851_2.6.34.patch
patch -s -p1 < ${DIR}/patches/micrel/linux-2.6.34/07_ksz8851_2.6.34.patch
patch -s -p1 < ${DIR}/patches/micrel/linux-2.6.34/08_ksz8851_2.6.34.patch
patch -s -p1 < ${DIR}/patches/micrel/linux-2.6.34/09_ksz8851_2.6.34.patch
patch -s -p1 < ${DIR}/patches/micrel/linux-2.6.34/10_ksz8851_2.6.34.patch

patch -s -p1 < ${DIR}/patches/micrel/linux-2.6.34/11_ksz8851_2.6.34-fixup.patch
#patch -s -p1 < ${DIR}/patches/micrel/linux-2.6.34/11_ksz8851_2.6.34.patch

patch -s -p1 < ${DIR}/patches/micrel/linux-2.6.34/12_ksz8851_2.6.34.patch

patch -s -p1 < ${DIR}/patches/micrel/linux-2.6.34/15_ksz8851_2.6.34-fixup.patch
#patch -s -p1 < ${DIR}/patches/micrel/linux-2.6.34/15_ksz8851_2.6.34.patch

#patch -s -p1 < ${DIR}/patches/micrel/linux-2.6.34/16_compressed_2.6.33.patch

patch -s -p1 < ${DIR}/patches/micrel/linux-2.6.34/18_ksz8851_2.6.34-rc7.patch
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
#Not Ready...
patch -s -p1 < ${DIR}/patches/sgx/0001-OMAP3-SGX-Merge-TI-3.01.00.06-into-TI-3.01.00.02.patch
patch -s -p1 < ${DIR}/patches/sgx/0001-OMAP3-SGX-TI-3.01.00.06-update-bufferclass_ti-kfree-kmalloc.diff
patch -s -p1 < ${DIR}/patches/sgx/0001-OMAP3-SGX-TI-3.01.00.06-2.6.32-PSP.diff
patch -s -p1 < ${DIR}/patches/sgx/0001-OMAP3-SGX-TI-3.01.00.06-use-omap3630.diff
}

function dsp {
echo "merge in dspbridge"

patch -s -p1 < ${DIR}/patches/dspbridge/0001-staging-ti-dspbridge-add-driver-documentation.patch
patch -s -p1 < ${DIR}/patches/dspbridge/0002-staging-ti-dspbridge-add-core-driver-sources.patch
patch -s -p1 < ${DIR}/patches/dspbridge/0003-staging-ti-dspbridge-add-platform-manager-code.patch
patch -s -p1 < ${DIR}/patches/dspbridge/0004-staging-ti-dspbridge-add-resource-manager.patch
patch -s -p1 < ${DIR}/patches/dspbridge/0005-staging-ti-dspbridge-add-MMU-support.patch
patch -s -p1 < ${DIR}/patches/dspbridge/0006-staging-ti-dspbridge-add-generic-utilities.patch
patch -s -p1 < ${DIR}/patches/dspbridge/0007-staging-ti-dspbridge-add-services.patch
patch -s -p1 < ${DIR}/patches/dspbridge/0008-staging-ti-dspbridge-add-DOFF-binaries-loader.patch
patch -s -p1 < ${DIR}/patches/dspbridge/0009-staging-ti-dspbridge-add-header-files.patch
patch -s -p1 < ${DIR}/patches/dspbridge/0010-staging-ti-dspbridge-add-TODO-file.patch

#patch -s -p1 < ${DIR}/patches/dspbridge/0011-staging-ti-dspbridge-enable-driver-building.patch
patch -s -p1 < ${DIR}/patches/dspbridge/0011-staging-ti-dspbridge-enable-driver-building-fixup.patch
}

dss2
musb
#vfp
micrel
zippy
xm
nand
sgx
dsp

echo "patch.sh ran successful"

