#!/bin/bash
# Split out, so build_kernel.sh and build_deb.sh can share..

echo "Starting patch.sh"

patch -s -p1 < "${DIR}/patches/rcn/bug16310.diff"

patch -s -p1 < "${DIR}/patches/gpio/0001-ARM-OMAP-Beagle-revision-detection.patch"
patch -s -p1 < "${DIR}/patches/gpio/0002-ARM-OMAP-Beagle-only-Cx-boards-use-pin-23-for-write-.patch"
patch -s -p1 < "${DIR}/patches/gpio/0003-ARM-OMAP-Beagle-no-gpio_wp-pin-connection-on-xM.patch"
patch -s -p1 < "${DIR}/patches/beagle/0001-Adding-i2c-eeprom-driver-to-read-EDID.patch"

function sakoman {
echo "sakoman's patches"
patch -s -p1 < "${DIR}/patches/sakoman/2.6.35/0001-video-add-timings-for-hd720.patch"
patch -s -p1 < "${DIR}/patches/sakoman/2.6.35/0002-OMAP-hsmmc-boards-with-8-wires-are-also-capable-of-4.patch"
patch -s -p1 < "${DIR}/patches/sakoman/2.6.35/0003-Don-t-turn-SDIO-cards-off-to-save-power.-Doing-so-wi.patch"
patch -s -p1 < "${DIR}/patches/sakoman/2.6.35/0004-mmc-don-t-display-single-block-read-console-messages.patch"
patch -s -p1 < "${DIR}/patches/sakoman/2.6.35/0005-scripts-Makefile.fwinst-fix-typo-missing-space-in-se.patch"
patch -s -p1 < "${DIR}/patches/sakoman/2.6.35/0006-drivers-net-smsc911x-return-ENODEV-if-device-is-not-.patch"
patch -s -p1 < "${DIR}/patches/sakoman/2.6.35/0007-drivers-input-touchscreen-ads7846-return-ENODEV-if-d.patch"
patch -s -p1 < "${DIR}/patches/sakoman/2.6.35/0008-ASoC-enable-audio-capture-by-default-for-twl4030.patch"
patch -s -p1 < "${DIR}/patches/sakoman/2.6.35/0009-ARM-OMAP-Overo-Add-support-for-second-ethernet-port.patch"
#patch -s -p1 < "${DIR}/patches/sakoman/2.6.35/0010-ARM-OMAP-add-support-for-TCT-Zippy-to-Beagle-board-f.patch"
patch -s -p1 < "${DIR}/patches/sakoman/2.6.35/0011-ARM-OMAP-Make-beagle-u-boot-partition-writable.patch"
patch -s -p1 < "${DIR}/patches/sakoman/2.6.35/0012-MFD-enable-madc-clock.patch"
patch -s -p1 < "${DIR}/patches/sakoman/2.6.35/0013-MFD-add-twl4030-madc-driver.patch"
patch -s -p1 < "${DIR}/patches/sakoman/2.6.35/0014-ARM-OMAP-Add-twl4030-madc-support-to-Overo.patch"
patch -s -p1 < "${DIR}/patches/sakoman/2.6.35/0015-ARM-OMAP-Add-twl4030-madc-support-to-Beagle.patch"
patch -s -p1 < "${DIR}/patches/sakoman/2.6.35/0016-OMAP-DSS2-Add-support-for-Samsung-LTE430WQ-F0C-panel.patch"
patch -s -p1 < "${DIR}/patches/sakoman/2.6.35/0017-OMAP-DSS2-Add-support-for-LG-Philips-LB035Q02-panel.patch"
patch -s -p1 < "${DIR}/patches/sakoman/2.6.35/0018-OMAP-DSS2-Add-DSS2-support-for-Overo.patch"
patch -s -p1 < "${DIR}/patches/sakoman/2.6.35/0019-OMAP-DSS2-add-bootarg-for-selecting-svideo-or-compos.patch"
patch -s -p1 < "${DIR}/patches/sakoman/2.6.35/0020-ARM-OMAP2-mmc-twl4030-move-clock-input-selection-pri.patch"
patch -s -p1 < "${DIR}/patches/sakoman/2.6.35/0021-RTC-add-support-for-backup-battery-recharge.patch"
#patch -s -p1 < "${DIR}/patches/sakoman/2.6.35/0022-ARM-OMAP-automatically-set-musb-mode-in-platform-dat.patch"
#patch -s -p1 < "${DIR}/patches/sakoman/2.6.35/0023-ARM-OMAP-Beagle-use-new-gpmc-nand-infrastructure.patch"
patch -s -p1 < "${DIR}/patches/sakoman/2.6.35/0024-ARM-OMAP-Overo-use-new-gpmc-nand-infrastructure.patch"
patch -s -p1 < "${DIR}/patches/sakoman/2.6.35/0025-MTD-silence-ecc-errors-on-mtdblock0.patch"
patch -s -p1 < "${DIR}/patches/sakoman/2.6.35/0026-ARM-OMAP-Add-macros-for-comparing-silicon-revision.patch"
patch -s -p1 < "${DIR}/patches/sakoman/2.6.35/0027-OMAP-DSS2-check-for-both-cpu-type-and-revision-rathe.patch"
patch -s -p1 < "${DIR}/patches/sakoman/2.6.35/0028-OMAP-DSS2-enable-hsclk-in-dsi_pll_init-for-OMAP36XX.patch"
patch -s -p1 < "${DIR}/patches/sakoman/2.6.35/0029-ARM-OMAP-Beagle-support-twl-gpio-differences-on-xM.patch"
patch -s -p1 < "${DIR}/patches/sakoman/2.6.35/0030-Revert-Input-ads7846-add-regulator-support.patch"
patch -s -p1 < "${DIR}/patches/sakoman/2.6.35/0031-Revert-omap2_mcspi-Flush-posted-writes.patch"

}

function dss2 {
echo "dss2 patches"

#http://www.spinics.net/lists/linux-omap/msg34582.html
patch -s -p1 < "${DIR}/patches/dss2/0001-OMAP-DSS2-don-t-power-off-a-panel-twice.patch"

patch -s -p1 < "${DIR}/patches/dss2/OMAP2-OMAPFB-Fix-invalid-bpp-for-PAL-and-NTSC-modes.patch"
patch -s -p1 < "${DIR}/patches/dss2/Combine-dsi-and-sdi-under-the-same-vdds-supply..patch"

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
patch -s -p1 < "${DIR}/patches/arago-project/0001-omap3-Increase-limit-on-bootarg-mpurate.patch"
patch -s -p1 < "${DIR}/patches/arago-project/0001-AM37x-Switch-SGX-clocks-to-200MHz.patch"
}

function nand {
echo "new nand interface"
patch -s -p1 < ${DIR}/patches/nand/0001-ARM-OMAP-Beagle-use-new-gpmc-nand-infrastructure-fixup.patch
}

function sgx {
echo "merge in ti sgx modules"
patch -s -p1 < "${DIR}/patches/sgx/0001-OMAP3-SGX-Merge-TI-3.01.00.02-Kernel-Modules.patch"
patch -s -p1 < "${DIR}/patches/sgx/0001-OMAP3-SGX-enable-driver-building.patch"

#3.01.00.06
patch -s -p1 < "${DIR}/patches/sgx/0001-OMAP3-SGX-Merge-TI-3.01.00.06-into-TI-3.01.00.02.patch"

#3.01.00.07 'the first wget-able release!!'
patch -s -p1 < "${DIR}/patches/sgx/0001-OMAP3-SGX-Merge-TI-3.01.00.07-into-TI-3.01.00.06.patch"

#4.00.00.01 adds ti8168 support, drops bc_cat.c patch
patch -s -p1 < "${DIR}/patches/sgx/0001-OMAP3-SGX-Merge-TI-4.00.00.01-into-TI-3.01.00.07.patch"

#3.01.00.06/07 & 4.00.00.01 Patches
patch -s -p1 < "${DIR}/patches/sgx/0001-OMAP3-SGX-TI-3.01.00.06-2.6.32-PSP.diff"
patch -s -p1 < "${DIR}/patches/sgx/0001-OMAP3-SGX-TI-3.01.00.06-use-omap3630.diff"

#dropped with 4.00.00.01
#patch -s -p1 < "${DIR}/patches/sgx/0001-OMAP3-SGX-TI-3.01.00.06-Compile-Fixes.patch"
}

function panda {
echo "merge in panda support"
patch -s -p1 < "${DIR}/patches/panda/0001-omap4-Add-OMAP4-Panda-Support.patch"
}

function igepv2 {
echo "igepv2 board related patches"
patch -s -p1 < "${DIR}/patches/igepv2/0001-ARM-OMAP3-Add-S-Video-output-to-IGEPv2-board.patch"
}

function touchbook {
echo "touchbook related patches"
patch -s -p1 < "${DIR}/patches/touchbook/0001-ARM-OMAP-Touchbook-DSS2-support.patch"
patch -s -p1 < "${DIR}/patches/touchbook/0002-ARM-OMAP-Touchbook-move-omap3_mux_init-beagle-like.patch"
patch -s -p1 < "${DIR}/patches/touchbook/0003-ARM-OMAP-Touchbook-DSS2-support-fix-supplies.patch"
patch -s -p1 < "${DIR}/patches/touchbook/0004-ARM-OMAP-Touchbook-based-on-schematic-there-is-no-wp.patch"
patch -s -p1 < "${DIR}/patches/touchbook/0005-ARM-OMAP-Touchbook-adis7846-use-mux-init-gpio.patch"
patch -s -p1 < "${DIR}/patches/touchbook/0006-ARM-OMAP-Touchbook-upstream-sync-remove-NAND_BLOCK_S.patch"
patch -s -p1 < "${DIR}/patches/touchbook/0007-ARM-OMAP-Touchbook-upstream-sync-formatting.patch"

patch -s -p1 < "${DIR}/patches/touchbook/0001-ARM-OMAP-Touchbook-2.6.35-omap3touchbook-to-touchboo.patch"
#patch -s -p1 < "${DIR}/patches/touchbook/0008-ARM-OMAP-Touchbook-upstream-omap3touchbook-to-touchb.patch"
patch -s -p1 < "${DIR}/patches/touchbook/0009-ARM-OMAP-Touchbook-upstream-mmc-to-touchbook_mmc.patch"
patch -s -p1 < "${DIR}/patches/touchbook/0010-ARM-OMAP-Touchbook-upstream-add-madc.patch"
patch -s -p1 < "${DIR}/patches/touchbook/0011-ARM-OMAP-Touchbook-upstream-use-super_init.patch"
patch -s -p1 < "${DIR}/patches/touchbook/0012-ARM-OMAP-Touchbook-upstream-omap3_ads_init-to-touchb.patch"

patch -s -p1 < "${DIR}/patches/touchbook/0001-ARM-OMAP-touchbook-2.6.35-rename-touchbook_irq.patch"
#patch -s -p1 < "${DIR}/patches/touchbook/0013-ARM-OMAP-Touchbook-upstream-rename-touchbook_irq.patch"
patch -s -p1 < "${DIR}/patches/touchbook/0014-ARM-OMAP-Touchbook-upstream-rename-i2c_init.patch"
patch -s -p1 < "${DIR}/patches/touchbook/0015-ARM-OMAP-Touchbook-upstream-rename-both-i2c-boardinf.patch"

##patch -s -p1 < "${DIR}/patches/touchbook/touchscreen-chacha.patch"
#patch -s -p1 < "${DIR}/patches/touchbook/0016-ARM-OMAP-Touchbook-upstream-Chacha-Tablet-driver.patch"

##patch -s -p1 < "${DIR}/patches/touchbook/battery2-bq27x00-charging-management.patch"
#patch -s -p1 < "${DIR}/patches/touchbook/0017-ARM-OMAP-Touchbook-upstream-add-bq27x00-battery-driv.patch"
#patch -s -p1 < "${DIR}/patches/touchbook/0018-ARM-OMAP-Touchbook-upstream-add-Chacha-Tablet.patch"

#patch -s -p1 < "${DIR}/patches/touchbook/0019-MMA7455L-driver.patch"
#patch -s -p1 < "${DIR}/patches/touchbook/0020-ARM-OMAP-Touchbook-upstream-add-move-touchbook_init_.patch"
#patch -s -p1 < "${DIR}/patches/touchbook/0021-ARM-OMAP-Touchbook-upstream-add-moving-touchscreen-i.patch"
#patch -s -p1 < "${DIR}/patches/touchbook/0022-ARM-OMAP-Touchbook-upstream-add-accelerometer.patch"
#patch -s -p1 < "${DIR}/patches/touchbook/0001-chacha-tablet-kzalloc-fix.patch"
#patch -s -p1 < "${DIR}/patches/touchbook/0001-chacha-tablet-fix-id.patch"

#patch -s -p1 < "${DIR}/patches/touchbook/0001-ARM-OMAP-Touchbook-upstream-match-leds-keys-gpio.patch"
#patch -s -p1 < "${DIR}/patches/touchbook/0002-ARM-OMAP-Touchbook-upstream-board_mux.patch"
#patch -s -p1 < "${DIR}/patches/touchbook/0003-ARM-OMAP-Touchbook-upstream-revision-and-musb.patch"
#patch -s -p1 < "${DIR}/patches/touchbook/0004-ARM-OMAP-Touchbook-upstream-power-off.patch"
#patch -s -p1 < "${DIR}/patches/touchbook/0005-ARM-OMAP-Touchbook-upstream-echi.patch"

##patch -s -p1 < "${DIR}/patches/touchbook/0001-ARM-OMAP-Touchbook-upstream-power-supply.patch"
##patch -s -p1 < "${DIR}/patches/touchbook/0002-ARM-OMAP-Touchbook-upstream-backlight.patch"
}

function dspbridge {
echo "dspbridge from staging"
patch -s -p1 < "${DIR}/patches/dspbridge/0001-staging-ti-dspbridge-add-driver-documentation.patch"
patch -s -p1 < "${DIR}/patches/dspbridge/0002-staging-ti-dspbridge-add-core-driver-sources.patch"
patch -s -p1 < "${DIR}/patches/dspbridge/0003-staging-ti-dspbridge-add-platform-manager-code.patch"
patch -s -p1 < "${DIR}/patches/dspbridge/0004-staging-ti-dspbridge-add-resource-manager.patch"
patch -s -p1 < "${DIR}/patches/dspbridge/0005-staging-ti-dspbridge-add-MMU-support.patch"
patch -s -p1 < "${DIR}/patches/dspbridge/0006-staging-ti-dspbridge-add-generic-utilities.patch"
patch -s -p1 < "${DIR}/patches/dspbridge/0007-staging-ti-dspbridge-add-services.patch"
patch -s -p1 < "${DIR}/patches/dspbridge/0008-staging-ti-dspbridge-add-DOFF-binaries-loader.patch"
patch -s -p1 < "${DIR}/patches/dspbridge/0009-staging-ti-dspbridge-add-header-files.patch"
patch -s -p1 < "${DIR}/patches/dspbridge/0010-staging-ti-dspbridge-add-TODO-file.patch"
#patch -s -p1 < "${DIR}/patches/dspbridge/0011-staging-ti-dspbridge-enable-driver-building.patch"
patch -s -p1 < "${DIR}/patches/dspbridge/0011-staging-ti-dspbridge-enable-driver-building-2.6.35.patch"
patch -s -p1 < "${DIR}/patches/dspbridge/0012-staging-ti-dspbridge-remove-contributor-leftovers.patch"
patch -s -p1 < "${DIR}/patches/dspbridge/0013-staging-ti-dspbridge-deh-trivial-cleanups.patch"
patch -s -p1 < "${DIR}/patches/dspbridge/0014-staging-ti-dspbridge-mmufault-trivial-cleanups.patch"
patch -s -p1 < "${DIR}/patches/dspbridge/0015-staging-ti-dspbridge-deh-free-dummy-page-immediately.patch"
patch -s -p1 < "${DIR}/patches/dspbridge/0016-staging-ti-dspbridge-remove-unused-code.patch"
patch -s -p1 < "${DIR}/patches/dspbridge/0017-staging-ti-dspbridge-mmu-add-hw_mmu_tlb_flush_all.patch"
patch -s -p1 < "${DIR}/patches/dspbridge/0018-staging-ti-dspbridge-deh-ensure-only-tlb-0-is-enable.patch"
patch -s -p1 < "${DIR}/patches/dspbridge/0019-staging-ti-dspbridge-deh-refactor-in-mmu_fault_print.patch"
patch -s -p1 < "${DIR}/patches/dspbridge/0020-staging-ti-dspbridge-deh-remove-get_info.patch"
patch -s -p1 < "${DIR}/patches/dspbridge/0021-staging-ti-dspbridge-deh-remove-err_info.patch"
patch -s -p1 < "${DIR}/patches/dspbridge/0022-staging-ti-dspbridge-access-deh-directly.patch"
patch -s -p1 < "${DIR}/patches/dspbridge/0023-staging-ti-dspbridge-move-mmufault-to-deh.patch"
patch -s -p1 < "${DIR}/patches/dspbridge/0024-staging-ti-dspbridge-deh-tidying-up.patch"
patch -s -p1 < "${DIR}/patches/dspbridge/0025-staging-ti-dspbridge-deh-update-copyright-notice.patch"
patch -s -p1 < "${DIR}/patches/dspbridge/0026-staging-ti-dspbridge-prefix-configs-with-TIDSPBRIDGE.patch"
patch -s -p1 < "${DIR}/patches/dspbridge/0027-staging-ti-dspbridge-improve-Kconfig.patch"
patch -s -p1 < "${DIR}/patches/dspbridge/0028-staging-ti-dspbridge-use-_DEBUG-for-debug-trace.patch"
patch -s -p1 < "${DIR}/patches/dspbridge/0029-staging-ti-dspbridge-add-_BACKTRACE-config.patch"
patch -s -p1 < "${DIR}/patches/dspbridge/0030-staging-tidspbridge-gen-simplify-and-clean-up.patch"
patch -s -p1 < "${DIR}/patches/dspbridge/0031-staging-ti-dspbridge-Rename-words-with-camel-case.patch"
patch -s -p1 < "${DIR}/patches/dspbridge/0032-staging-ti-dspbridge-fix-compilation-error.patch"
patch -s -p1 < "${DIR}/patches/dspbridge/0033-staging-ti-dspbridge-Rename-words-with-camel-case.patch"
patch -s -p1 < "${DIR}/patches/dspbridge/0034-staging-ti-dspbridge-Rename-words-with-camel-case.patch"
patch -s -p1 < "${DIR}/patches/dspbridge/0035-staging-ti-dspbridge-Rename-words-with-camel-case.patch"
patch -s -p1 < "${DIR}/patches/dspbridge/0036-staging-ti-dspbridge-Rename-words-with-camel-case.patch"
patch -s -p1 < "${DIR}/patches/dspbridge/0037-staging-ti-dspbridge-Rename-words-with-camel-case.patch"
patch -s -p1 < "${DIR}/patches/dspbridge/0038-staging-ti-dspbridge-Rename-words-with-camel-case.patch"
patch -s -p1 < "${DIR}/patches/dspbridge/0039-staging-ti-dspbridge-Rename-words-with-camel-case.patch"
patch -s -p1 < "${DIR}/patches/dspbridge/0040-staging-ti-dspbridge-Rename-words-with-camel-case.patch"
patch -s -p1 < "${DIR}/patches/dspbridge/0041-staging-ti-dspbridge-Rename-words-with-camel-case.patch"
patch -s -p1 < "${DIR}/patches/dspbridge/0042-staging-ti-dspbridge-Rename-words-with-camel-case.patch"
patch -s -p1 < "${DIR}/patches/dspbridge/0043-staging-ti-dspbridge-Rename-words-with-camel-case.patch"
patch -s -p1 < "${DIR}/patches/dspbridge/0044-staging-ti-dspbridge-Rename-words-with-camel-case.patch"
patch -s -p1 < "${DIR}/patches/dspbridge/0045-staging-ti-dspbridge-Rename-words-with-camel-case.patch"
patch -s -p1 < "${DIR}/patches/dspbridge/0046-staging-ti-dspbridge-Rename-words-with-camel-case.patch"
patch -s -p1 < "${DIR}/patches/dspbridge/0047-staging-ti-dspbridge-make-variables-in-prototypes-ma.patch"
patch -s -p1 < "${DIR}/patches/dspbridge/0048-staging-tidspbridge-remove-custom-TRUE-FALSE.patch"
patch -s -p1 < "${DIR}/patches/dspbridge/0049-staging-tidspbridge-no-need-for-custom-NULL.patch"
patch -s -p1 < "${DIR}/patches/dspbridge/0050-staging-tidspbridge-remove-std.h.patch"
patch -s -p1 < "${DIR}/patches/dspbridge/0051-staging-tidspbridge-remove-custom-typedef-reg_uword3.patch"
patch -s -p1 < "${DIR}/patches/dspbridge/0052-staging-tidspbridge-remove-RET_OK-RET_FAIL.patch"
patch -s -p1 < "${DIR}/patches/dspbridge/0053-staging-tidspbridge-check-kmalloc-result.patch"
patch -s -p1 < "${DIR}/patches/dspbridge/0054-staging-tidspbridge-remove-GlobalTypes.h.patch"
patch -s -p1 < "${DIR}/patches/dspbridge/0055-staging-tidspbridge-replace-CONST-with-c-standard-co.patch"
patch -s -p1 < "${DIR}/patches/dspbridge/0056-staging-tidspbridge-remove-IN-modifier.patch"
patch -s -p1 < "${DIR}/patches/dspbridge/0057-staging-tidspbridge-remove-OPTIONAL.patch"
patch -s -p1 < "${DIR}/patches/dspbridge/0058-staging-tidspbridge-remove-OUT-define.patch"
patch -s -p1 < "${DIR}/patches/dspbridge/0059-staging-tidspbridge-remove-dbdefs.h.patch"
patch -s -p1 < "${DIR}/patches/dspbridge/0060-staging-tidspbridge-Remove-Redundant-wrappers.patch"
patch -s -p1 < "${DIR}/patches/dspbridge/0061-staging-tidspbridge-Remove-redundant-macros-in-io_sm.patch"
patch -s -p1 < "${DIR}/patches/dspbridge/0062-staging-tidspbridge-Change-macros-to-static-inline-f.patch"
patch -s -p1 < "${DIR}/patches/dspbridge/0063-staging-tidspbridge-Change-macros-to-static-inline-f.patch"
patch -s -p1 < "${DIR}/patches/dspbridge/0064-staging-tidspbridge-Remove-redundant-macro-from-cod..patch"
patch -s -p1 < "${DIR}/patches/dspbridge/0065-staging-tidspbridge-Remove-unused-magic-number.patch"
patch -s -p1 < "${DIR}/patches/dspbridge/0066-staging-tidspbridge-Remove-macros-used-as-cast.patch"
patch -s -p1 < "${DIR}/patches/dspbridge/0067-staging-tidspbridge-Change-macros-to-static-inline-f.patch"
patch -s -p1 < "${DIR}/patches/dspbridge/0068-staging-tidspbridge-Remove-unused-macros.patch"
patch -s -p1 < "${DIR}/patches/dspbridge/0069-staging-ti-dspbridge-remove-unused-typedef-REG16.patch"
patch -s -p1 < "${DIR}/patches/dspbridge/0070-staging-ti-dspbridge-remove-unnecessary-check-for-NU.patch"
patch -s -p1 < "${DIR}/patches/dspbridge/0071-staging-ti-dspbridge-remove-function-delete_strm_mgr.patch"
patch -s -p1 < "${DIR}/patches/dspbridge/0072-staging-ti-dspbridge-remove-unnecessary-volatile-var.patch"
patch -s -p1 < "${DIR}/patches/dspbridge/0073-staging-ti-dspbridge-replace-simple_strtoul-by-stric.patch"
patch -s -p1 < "${DIR}/patches/dspbridge/0074-staging-ti-dspbridge-remove-DSP_SUCCEEDED-macro-from.patch"
patch -s -p1 < "${DIR}/patches/dspbridge/0075-staging-ti-dspbridge-remove-DSP_SUCCEEDED-macro-from.patch"
patch -s -p1 < "${DIR}/patches/dspbridge/0076-staging-ti-dspbridge-remove-DSP_SUCCEEDED-macro-from.patch"
patch -s -p1 < "${DIR}/patches/dspbridge/0077-staging-ti-dspbridge-remove-DSP_SUCCEEDED-macro-from.patch"
patch -s -p1 < "${DIR}/patches/dspbridge/0078-staging-ti-dspbridge-remove-DSP_SUCCEEDED-macro-defi.patch"
patch -s -p1 < "${DIR}/patches/dspbridge/0079-staging-ti-dspbridge-remove-DSP_FAILED-macro-from-co.patch"
patch -s -p1 < "${DIR}/patches/dspbridge/0080-staging-ti-dspbridge-remove-DSP_FAILED-macro-from-pm.patch"
patch -s -p1 < "${DIR}/patches/dspbridge/0081-staging-ti-dspbridge-remove-DSP_FAILED-macro-from-rm.patch"
patch -s -p1 < "${DIR}/patches/dspbridge/0082-staging-ti-dspbridge-remove-DSP_FAILED-macro-from-se.patch"
patch -s -p1 < "${DIR}/patches/dspbridge/0083-staging-ti-dspbridge-remove-DSP_FAILED-macro-definit.patch"
patch -s -p1 < "${DIR}/patches/dspbridge/0084-staging-ti-dspbridge-fix-bridge_brd_stop-so-IVA2-is-.patch"
patch -s -p1 < "${DIR}/patches/dspbridge/0085-staging-ti-dspbridge-proc_load-start-should-set-IVA2.patch"
patch -s -p1 < "${DIR}/patches/dspbridge/0086-staging-ti-dspbridge-make-sure-IVA2-is-OFF-when-dev-.patch"
patch -s -p1 < "${DIR}/patches/dspbridge/0087-staging-ti-dspbridge-remove-bridge_brd_delete-functi.patch"
patch -s -p1 < "${DIR}/patches/dspbridge/0088-staging-ti-dspbridge-remove-find_gcf-from-nldr.c.patch"
patch -s -p1 < "${DIR}/patches/dspbridge/0089-staging-ti-dspbridge-avoid-possible-NULL-dereference.patch"
patch -s -p1 < "${DIR}/patches/dspbridge/0090-staging-ti-dspbridge-use-node-id-instead-of-kernel-a.patch"
patch -s -p1 < "${DIR}/patches/dspbridge/0091-staging-ti-dspbridge-avoid-errors-if-node-handle-is-.patch"
patch -s -p1 < "${DIR}/patches/dspbridge/0092-staging-ti-dspbridge-use-processor-handle-from-conte.patch"
patch -s -p1 < "${DIR}/patches/dspbridge/0093-staging-ti-dspbridge-use-stream-id-instead-of-kernel.patch"
patch -s -p1 < "${DIR}/patches/dspbridge/0094-staging-ti-dspbridge-avoid-errors-if-stream-id-is-ze.patch"

patch -s -p1 < "${DIR}/patches/dspbridge/0001-OUT-OF-TREE-tidspbridge-move-platform_device_registe.patch"

#2.6.37 - staging-for-next
patch -s -p1 < "${DIR}/patches/dspbridge/0095-drivers-staging-tidspbridge-gen-gb.c-Removed-duplica.patch"
patch -s -p1 < "${DIR}/patches/dspbridge/0096-staging-tidspbridge-Move-sync.c-from-services-to-cor.patch"
patch -s -p1 < "${DIR}/patches/dspbridge/0097-staging-tidspbridge-Remove-ntfy.c.patch"
patch -s -p1 < "${DIR}/patches/dspbridge/0098-staging-tidspbridge-Remove-cfg_get_auto_start.patch"
patch -s -p1 < "${DIR}/patches/dspbridge/0099-staging-tidspbridge-Remove-cfg_init-and-cfg_exit.patch"
patch -s -p1 < "${DIR}/patches/dspbridge/0100-staging-tidspbridge-Remove-cfg_get_dev_object-and-do.patch"
patch -s -p1 < "${DIR}/patches/dspbridge/0101-staging-tidspbridge-Remove-cfg_get_exec_file.patch"
patch -s -p1 < "${DIR}/patches/dspbridge/0102-staging-tidspbridge-Remove-cfg_get_object.patch"
patch -s -p1 < "${DIR}/patches/dspbridge/0103-staging-tidspbridge-Remove-cfg_set_dev_object.patch"
patch -s -p1 < "${DIR}/patches/dspbridge/0104-staging-tidspbridge-Remove-cfg_set_object.patch"
patch -s -p1 < "${DIR}/patches/dspbridge/0105-staging-tidspbridge-Remove-cfg.c-and-cfg.h-files.patch"
patch -s -p1 < "${DIR}/patches/dspbridge/0106-staging-tidspbridge-Remove-services.c-and-services.h.patch"
patch -s -p1 < "${DIR}/patches/dspbridge/0107-staging-trivial-fix-typos-concerning-address.patch"
patch -s -p1 < "${DIR}/patches/dspbridge/0108-staging-trivial-fix-typos-concerning-initiali-zs-e.patch"
patch -s -p1 < "${DIR}/patches/dspbridge/0109-staging-tidspbridge-check-return-code-of-kzalloc.patch"
patch -s -p1 < "${DIR}/patches/dspbridge/0110-staging-tidspbridge-check-return-code-of-get_user.patch"

}

sakoman
dss2
musb
micrel
zippy
xm
nand
sgx
panda
igepv2
touchbook
dspbridge

echo "patch.sh ran successful"

