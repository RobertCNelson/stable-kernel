#!/bin/bash
#
# Copyright (c) 2009-2012 Robert Nelson <robertcnelson@gmail.com>
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
# THE SOFTWARE.

# Split out, so build_kernel.sh and build_deb.sh can share..

echo "Starting patch.sh"

function bugs_trivial {
	echo "bugs and trivial stuff"
	git am "${DIR}/patches/trivial/0001-kbuild-deb-pkg-set-host-machine-after-dpkg-gencontro.patch"
	git am "${DIR}/patches/trivial/0001-USB-ehci-use-packed-aligned-4-instead-of-removing-th.patch"
}

function beagle {
	echo "Board Patchset: Beagle"
#	git am "${DIR}/patches/beagle/0001-OMAP3-beagle-add-support-for-beagleboard-xM-revision.patch"
	git am "${DIR}/patches/arago-project/0001-omap3-Increase-limit-on-bootarg-mpurate.patch"
	git am "${DIR}/patches/display/0001-meego-modedb-add-Toshiba-LTA070B220F-800x480-support.patch"
	git am "${DIR}/patches/musb/0001-default-to-fifo-mode-5-for-old-musb-beagles.patch"
	git am "${DIR}/patches/beagle/0001-beagleboard-reinstate-usage-of-hi-speed-PLL-divider.patch"
}

function omap_pm {
	echo "omap_pm patchset"
	#from: http://www.sakoman.com/cgi-bin/gitweb.cgi?p=linux-omap-2.6.git;a=shortlog;h=refs/heads/omap-3.0-pm

	git am "${DIR}/patches/omap-3.0-pm/0001-OMAP-DSS2-add-bootarg-for-selecting-svideo-or-compos.patch"
	git am "${DIR}/patches/omap-3.0-pm/0002-video-add-timings-for-hd720.patch"
	git am "${DIR}/patches/omap-3.0-pm/0003-drivers-net-smsc911x-return-ENODEV-if-device-is-not-.patch"
	git am "${DIR}/patches/omap-3.0-pm/0004-drivers-input-touchscreen-ads7846-return-ENODEV-if-d.patch"
	git am "${DIR}/patches/omap-3.0-pm/0005-Revert-omap2_mcspi-Flush-posted-writes.patch"
	git am "${DIR}/patches/omap-3.0-pm/0006-rtc-twl-Switch-to-using-threaded-irq.patch"
	git am "${DIR}/patches/omap-3.0-pm/0007-rtc-twl-add-support-for-backup-battery-recharge.patch"
	git am "${DIR}/patches/omap-3.0-pm/0008-soc-codecs-Enable-audio-capture-by-default-for-twl40.patch"
	git am "${DIR}/patches/omap-3.0-pm/0009-soc-codecs-twl4030-Turn-on-mic-bias-by-default.patch"
	git am "${DIR}/patches/omap-3.0-pm/0010-omap-mmc-twl4030-move-clock-input-selection-prior-to.patch"
	git am "${DIR}/patches/omap-3.0-pm/0011-Add-power-off-support-for-the-TWL4030-companion.patch"
	git am "${DIR}/patches/omap-3.0-pm/0012-Enabling-Hwmon-driver-for-twl4030-madc.patch"
	git am "${DIR}/patches/omap-3.0-pm/0013-mfd-twl-core-enable-madc-clock.patch"
	git am "${DIR}/patches/omap-3.0-pm/0014-omap-overo-Add-twl4030-madc-support.patch"
	git am "${DIR}/patches/omap-3.0-pm/0015-omap-beagle-Add-twl4030-madc-support.patch"
	git am "${DIR}/patches/omap-3.0-pm/0016-omap-overo-automatically-set-musb-mode-in-platform-d.patch"
	git am "${DIR}/patches/omap-3.0-pm/0017-omap-beagle-automatically-set-musb-mode-in-platform-.patch"
	git am "${DIR}/patches/omap-3.0-pm/0018-omap-beagle-Add-support-for-1GHz.patch"
	git am "${DIR}/patches/omap-3.0-pm/0019-OMAP3-beagle-add-support-for-beagleboard-xM-revision.patch"
	git am "${DIR}/patches/omap-3.0-pm/0020-UNFINISHED-OMAP3-beagle-add-support-for-expansionboa.patch"
	git am "${DIR}/patches/omap-3.0-pm/0021-omap-overo-Add-support-for-spidev.patch"
	git am "${DIR}/patches/omap-3.0-pm/0022-omap-overo-Add-opp-init.patch"
	git am "${DIR}/patches/omap-3.0-pm/0023-ARM-OMAP-Overo-remove-duplicate-call-to-overo_ads784.patch"
	git am "${DIR}/patches/omap-3.0-pm/0024-omap-mmc-Adjust-dto-to-eliminate-timeout-errors.patch"
	git am "${DIR}/patches/omap-3.0-pm/0025-omap3-Add-basic-support-for-720MHz-part.patch"
	git am "${DIR}/patches/omap-3.0-pm/0026-ARM-L2-Add-and-export-outer_clean_all.patch"
	git am "${DIR}/patches/omap-3.0-pm/0027-omap-Change-omap_device-activate-dectivate-latency-m.patch"
	git am "${DIR}/patches/omap-3.0-pm/0028-mtd-nand-Eliminate-noisey-uncorrectable-error-messag.patch"

#drop
#	git am "${DIR}/patches/omap-3.0-pm/0029-unionfs-Add-support-for-unionfs-2.5.9.2.patch"

	git am "${DIR}/patches/omap-3.0-pm/0030-omap-Add-omap3_defconfig.patch"
	git am "${DIR}/patches/omap-3.0-pm/0031-cleanup-regulator-supply-definitions-in-mach-omap2.patch"
	git am "${DIR}/patches/omap-3.0-pm/0032-Remove-old-style-supply.dev-assignments-common-in-hs.patch"
	git am "${DIR}/patches/omap-3.0-pm/0033-omap-Use-separate-init_irq-functions-to-avoid-cpu_is.patch"
	git am "${DIR}/patches/omap-3.0-pm/0034-omap-Set-separate-timer-init-functions-to-avoid-cpu_.patch"
	git am "${DIR}/patches/omap-3.0-pm/0035-omap-Move-dmtimer-defines-to-dmtimer.h.patch"
	git am "${DIR}/patches/omap-3.0-pm/0036-omap-Make-a-subset-of-dmtimer-functions-into-inline-.patch"
	git am "${DIR}/patches/omap-3.0-pm/0037-omap2-Use-dmtimer-macros-for-clockevent.patch"
	git am "${DIR}/patches/omap-3.0-pm/0038-omap2-Remove-gptimer_wakeup-for-now.patch"
	git am "${DIR}/patches/omap-3.0-pm/0039-OMAP3-SR-make-notify-independent-of-class.patch"
	git am "${DIR}/patches/omap-3.0-pm/0040-OMAP3-SR-disable-interrupt-by-default.patch"
	git am "${DIR}/patches/omap-3.0-pm/0041-OMAP3-SR-enable-disable-SR-only-on-need.patch"
	git am "${DIR}/patches/omap-3.0-pm/0042-OMAP3-SR-fix-cosmetic-indentation.patch"
	git am "${DIR}/patches/omap-3.0-pm/0043-omap2-Reserve-clocksource-and-timesource-and-initial.patch"
	git am "${DIR}/patches/omap-3.0-pm/0044-omap2-Use-dmtimer-macros-for-clocksource.patch"
	git am "${DIR}/patches/omap-3.0-pm/0045-omap2-Remove-omap2_gp_clockevent_set_gptimer.patch"
	git am "${DIR}/patches/omap-3.0-pm/0046-omap2-Rename-timer-gp.c-into-timer.c-to-combine-time.patch"
	git am "${DIR}/patches/omap-3.0-pm/0047-omap-cleanup-NAND-platform-data.patch"
	git am "${DIR}/patches/omap-3.0-pm/0048-omap-board-omap3evm-Fix-compilation-error.patch"
	git am "${DIR}/patches/omap-3.0-pm/0049-omap-mcbsp-Drop-SPI-mode-support.patch"
	git am "${DIR}/patches/omap-3.0-pm/0050-omap-mcbsp-Drop-in-driver-transfer-support.patch"
	git am "${DIR}/patches/omap-3.0-pm/0051-omap2-fix-build-regression.patch"
	git am "${DIR}/patches/omap-3.0-pm/0052-OMAP-New-twl-common-for-common-TWL-configuration.patch"
	git am "${DIR}/patches/omap-3.0-pm/0053-OMAP4-Move-common-twl6030-configuration-to-twl-commo.patch"
	git am "${DIR}/patches/omap-3.0-pm/0054-OMAP3-Move-common-twl-configuration-to-twl-common.patch"
	git am "${DIR}/patches/omap-3.0-pm/0055-OMAP3-Move-common-regulator-configuration-to-twl-com.patch"
	git am "${DIR}/patches/omap-3.0-pm/0056-omap-mcbsp-Remove-rx_-tx_word_length-variables.patch"
	git am "${DIR}/patches/omap-3.0-pm/0057-omap-mcbsp-Remove-port-number-enums.patch"
	git am "${DIR}/patches/omap-3.0-pm/0058-OMAP-dmtimer-add-missing-include.patch"
	git am "${DIR}/patches/omap-3.0-pm/0059-OMAP2-hwmod-Fix-smart-standby-wakeup-support.patch"
	git am "${DIR}/patches/omap-3.0-pm/0060-OMAP4-hwmod-data-Add-MSTANDBY_SMART_WKUP-flag.patch"
	git am "${DIR}/patches/omap-3.0-pm/0061-OMAP2-hwmod-Enable-module-in-shutdown-to-access-sysc.patch"
	git am "${DIR}/patches/omap-3.0-pm/0062-OMAP2-hwmod-Do-not-write-the-enawakeup-bit-if-SYSC_H.patch"
	git am "${DIR}/patches/omap-3.0-pm/0063-OMAP2-hwmod-Remove-_populate_mpu_rt_base-warning.patch"
	git am "${DIR}/patches/omap-3.0-pm/0064-OMAP2-hwmod-Fix-the-HW-reset-management.patch"
	git am "${DIR}/patches/omap-3.0-pm/0065-OMAP-hwmod-Add-warnings-if-enable-failed.patch"
	git am "${DIR}/patches/omap-3.0-pm/0066-OMAP-hwmod-Move-pr_debug-to-improve-the-readability.patch"
	git am "${DIR}/patches/omap-3.0-pm/0067-omap_hwmod-use-a-null-structure-record-to-terminate-.patch"
	git am "${DIR}/patches/omap-3.0-pm/0068-omap_hwmod-share-identical-omap_hwmod_addr_space-arr.patch"
	git am "${DIR}/patches/omap-3.0-pm/0069-omap_hwmod-use-a-terminator-record-with-omap_hwmod_m.patch"
	git am "${DIR}/patches/omap-3.0-pm/0070-omap_hwmod-share-identical-omap_hwmod_mpu_irqs-array.patch"
	git am "${DIR}/patches/omap-3.0-pm/0071-omap_hwmod-use-a-terminator-record-with-omap_hwmod_d.patch"
	git am "${DIR}/patches/omap-3.0-pm/0072-omap_hwmod-share-identical-omap_hwmod_dma_info-array.patch"
	git am "${DIR}/patches/omap-3.0-pm/0073-omap_hwmod-share-identical-omap_hwmod_class-omap_hwm.patch"
	git am "${DIR}/patches/omap-3.0-pm/0074-OMAP4-hwmod-data-Fix-L3-interconnect-data-order-and-.patch"
	git am "${DIR}/patches/omap-3.0-pm/0075-OMAP4-hwmod-data-Remove-un-needed-parens.patch"
	git am "${DIR}/patches/omap-3.0-pm/0076-OMAP4-hwmod-data-Fix-bad-alignement.patch"
	git am "${DIR}/patches/omap-3.0-pm/0077-OMAP4-hwmod-data-Align-interconnect-format-with-regu.patch"
	git am "${DIR}/patches/omap-3.0-pm/0078-OMAP4-clock-data-Add-sddiv-to-USB-DPLL.patch"
	git am "${DIR}/patches/omap-3.0-pm/0079-OMAP4-clock-data-Remove-usb_host_fs-clkdev-with-NULL.patch"
	git am "${DIR}/patches/omap-3.0-pm/0080-OMAP4-clock-data-Re-order-some-clock-nodes-and-struc.patch"
	git am "${DIR}/patches/omap-3.0-pm/0081-OMAP4-clock-data-Fix-max-mult-and-div-for-USB-DPLL.patch"
	git am "${DIR}/patches/omap-3.0-pm/0082-OMAP4-prcm-Fix-errors-in-few-defines-name.patch"
	git am "${DIR}/patches/omap-3.0-pm/0083-OMAP4-prm-Remove-wrong-clockdomain-offsets.patch"
	git am "${DIR}/patches/omap-3.0-pm/0084-OMAP4-powerdomain-data-Fix-indentation.patch"
	git am "${DIR}/patches/omap-3.0-pm/0085-OMAP4-cm-Remove-RESTORE-macros-to-avoid-access-from-.patch"
	git am "${DIR}/patches/omap-3.0-pm/0086-OMAP4-prcm_mpu-Fix-indent-in-few-macros.patch"
	git am "${DIR}/patches/omap-3.0-pm/0087-OMAP4-clockdomain-data-Fix-data-order-and-wrong-name.patch"
	git am "${DIR}/patches/omap-3.0-pm/0088-OMAP-omap_device-replace-_find_by_pdev-with-to_omap_.patch"
	git am "${DIR}/patches/omap-3.0-pm/0089-OMAP-PM-remove-OMAP_PM_NONE-config-option.patch"
	git am "${DIR}/patches/omap-3.0-pm/0090-OMAP4-clock-data-Remove-McASP2-McASP3-and-MMC6-clock.patch"
	git am "${DIR}/patches/omap-3.0-pm/0091-OMAP4-clock-data-Remove-UNIPRO-clock-nodes.patch"
	git am "${DIR}/patches/omap-3.0-pm/0092-OMAP4-hwmod-data-Modify-DSS-opt-clocks.patch"
	git am "${DIR}/patches/omap-3.0-pm/0093-OMAP2-PM-Initialise-sleep_switch-to-a-non-valid-valu.patch"
	git am "${DIR}/patches/omap-3.0-pm/0094-OMAP4-powerdomain-data-Fix-core-mem-states-and-missi.patch"
	git am "${DIR}/patches/omap-3.0-pm/0095-OMAP4-clock-data-Keep-GPMC-clocks-always-enabled-and.patch"
	git am "${DIR}/patches/omap-3.0-pm/0096-OMAP4-powerdomain-data-Remove-unsupported-MPU-powerd.patch"
	git am "${DIR}/patches/omap-3.0-pm/0097-OMAP4-hwmod-data-Change-DSS-main_clk-scheme.patch"
	git am "${DIR}/patches/omap-3.0-pm/0098-I2C-OMAP2-Set-hwmod-flags-to-only-allow-16-bit-acces.patch"
	git am "${DIR}/patches/omap-3.0-pm/0099-I2C-OMAP2-increase-omap_i2c_dev_attr-flags-from-u8-t.patch"
	git am "${DIR}/patches/omap-3.0-pm/0100-I2C-OMAP2-Introduce-I2C-IP-versioning-constants.patch"
	git am "${DIR}/patches/omap-3.0-pm/0101-I2C-OMAP1-OMAP2-create-omap-I2C-functionality-flags-.patch"
	git am "${DIR}/patches/omap-3.0-pm/0102-I2C-OMAP2-Tag-all-OMAP2-hwmod-defintions-with-I2C-IP.patch"
	git am "${DIR}/patches/omap-3.0-pm/0103-I2C-OMAP2-add-correct-functionality-flags-to-all-oma.patch"
	git am "${DIR}/patches/omap-3.0-pm/0104-OMAP-hwmod-fix-the-i2c-reset-timeout-during-bootup.patch"
	git am "${DIR}/patches/omap-3.0-pm/0105-OMAP-omap_device-Create-clkdev-entry-for-hwmod-main_.patch"
	git am "${DIR}/patches/omap-3.0-pm/0106-OMAP4-clock-data-Add-missing-divider-selection-for-a.patch"
	git am "${DIR}/patches/omap-3.0-pm/0107-OMAP4-hwmod-data-Add-clock-domain-attribute.patch"
	git am "${DIR}/patches/omap-3.0-pm/0108-OMAP2-hwmod-Init-clkdm-field-at-boot-time.patch"
	git am "${DIR}/patches/omap-3.0-pm/0109-OMAP4-hwmod-Replace-CLKCTRL-absolute-address-with-of.patch"
	git am "${DIR}/patches/omap-3.0-pm/0110-OMAP-hwmod-Wait-the-idle-status-to-be-disabled.patch"
	git am "${DIR}/patches/omap-3.0-pm/0111-OMAP4-hwmod-Replace-RSTCTRL-absolute-address-with-of.patch"
	git am "${DIR}/patches/omap-3.0-pm/0112-OMAP4-prm-Replace-warm-reset-API-with-the-offset-bas.patch"
	git am "${DIR}/patches/omap-3.0-pm/0113-OMAP4-prm-Remove-deprecated-functions.patch"
	git am "${DIR}/patches/omap-3.0-pm/0114-OMAP4-hwmod-data-Add-PRM-context-register-offset.patch"
	git am "${DIR}/patches/omap-3.0-pm/0115-OMAP4-hwmod-data-Add-modulemode-entry-in-omap_hwmod-.patch"
	git am "${DIR}/patches/omap-3.0-pm/0116-OMAP4-cm-Add-two-new-APIs-for-modulemode-control.patch"
	git am "${DIR}/patches/omap-3.0-pm/0117-OMAP4-hwmod-Introduce-the-module-control-in-hwmod-co.patch"
	git am "${DIR}/patches/omap-3.0-pm/0118-OMAP-clockdomain-Remove-redundant-call-to-pwrdm_wait.patch"
	git am "${DIR}/patches/omap-3.0-pm/0119-OMAP2-clockdomain-Add-2-APIs-to-control-clockdomain-.patch"
	git am "${DIR}/patches/omap-3.0-pm/0120-OMAP2-clockdomain-add-clkdm_in_hwsup.patch"
	git am "${DIR}/patches/omap-3.0-pm/0121-OMAP2-PM-idle-clkdms-only-if-already-in-idle.patch"
	git am "${DIR}/patches/omap-3.0-pm/0122-OMAP2-clockdomain-Add-per-clkdm-lock-to-prevent-conc.patch"
	git am "${DIR}/patches/omap-3.0-pm/0123-OMAP2-clock-allow-per-SoC-clock-init-code-to-prevent.patch"
	git am "${DIR}/patches/omap-3.0-pm/0124-OMAP2-hwmod-Follow-the-recommended-PRCM-module-enabl.patch"
	git am "${DIR}/patches/omap-3.0-pm/0125-OMAP-Add-debugfs-node-to-show-the-summary-of-all-clo.patch"
	git am "${DIR}/patches/omap-3.0-pm/0126-OMAP2-hwmod-remove-unused-voltagedomain-pointer.patch"
	git am "${DIR}/patches/omap-3.0-pm/0127-OMAP2-voltage-move-PRCM-mod-offets-into-VC-VP-struct.patch"
	git am "${DIR}/patches/omap-3.0-pm/0128-OMAP2-voltage-move-prm_irqst_reg-from-VP-into-voltag.patch"
	git am "${DIR}/patches/omap-3.0-pm/0129-OMAP2-voltage-start-towards-a-new-voltagedomain-laye.patch"
	git am "${DIR}/patches/omap-3.0-pm/0130-OMAP3-voltage-rename-mpu-voltagedomain-to-mpu_iva.patch"
	git am "${DIR}/patches/omap-3.0-pm/0131-OMAP3-voltagedomain-data-add-wakeup-domain.patch"
	git am "${DIR}/patches/omap-3.0-pm/0132-OMAP3-voltage-add-scalable-flag-to-voltagedomain.patch"
	git am "${DIR}/patches/omap-3.0-pm/0133-OMAP2-powerdomain-add-voltagedomain-to-struct-powerd.patch"
	git am "${DIR}/patches/omap-3.0-pm/0134-OMAP2-add-voltage-domains-and-connect-to-powerdomain.patch"
	git am "${DIR}/patches/omap-3.0-pm/0135-OMAP3-powerdomain-data-add-voltage-domains.patch"
	git am "${DIR}/patches/omap-3.0-pm/0136-OMAP4-powerdomain-data-add-voltage-domains.patch"
	git am "${DIR}/patches/omap-3.0-pm/0137-OMAP2-powerdomain-add-voltage-domain-lookup-during-r.patch"
	git am "${DIR}/patches/omap-3.0-pm/0138-OMAP2-voltage-keep-track-of-powerdomains-in-each-vol.patch"
	git am "${DIR}/patches/omap-3.0-pm/0139-OMAP2-voltage-split-voltage-controller-VC-code-into-.patch"
	git am "${DIR}/patches/omap-3.0-pm/0140-OMAP2-voltage-move-VC-into-struct-voltagedomain-misc.patch"
	git am "${DIR}/patches/omap-3.0-pm/0141-OMAP2-voltage-enable-VC-bypass-scale-method-when-VC-.patch"
	git am "${DIR}/patches/omap-3.0-pm/0142-OMAP2-voltage-split-out-voltage-processor-VP-code-in.patch"
	git am "${DIR}/patches/omap-3.0-pm/0143-OMAP2-VC-support-PMICs-with-separate-voltage-and-com.patch"
	git am "${DIR}/patches/omap-3.0-pm/0144-OMAP2-add-PRM-VP-functions-for-checking-clearing-VP-.patch"
	git am "${DIR}/patches/omap-3.0-pm/0145-OMAP3-VP-replace-transaction-done-check-clear-with-V.patch"
	git am "${DIR}/patches/omap-3.0-pm/0146-OMAP2-PRM-add-register-access-functions-for-VC-VP.patch"
	git am "${DIR}/patches/omap-3.0-pm/0147-OMAP3-voltage-convert-to-PRM-register-access-functio.patch"
	git am "${DIR}/patches/omap-3.0-pm/0148-OMAP3-VC-cleanup-i2c-slave-address-configuration.patch"
	git am "${DIR}/patches/omap-3.0-pm/0149-OMAP3-VC-cleanup-PMIC-register-address-configuration.patch"
	git am "${DIR}/patches/omap-3.0-pm/0150-OMAP3-VC-bypass-use-fields-from-VC-struct-instead-of.patch"
	git am "${DIR}/patches/omap-3.0-pm/0151-OMAP3-VC-cleanup-voltage-setup-time-configuration.patch"
	git am "${DIR}/patches/omap-3.0-pm/0152-OMAP3-VC-move-on-onlp-ret-off-command-configuration-.patch"
	git am "${DIR}/patches/omap-3.0-pm/0153-OMAP3-VC-abstract-out-channel-configuration.patch"
	git am "${DIR}/patches/omap-3.0-pm/0154-OMAP3-voltage-domain-move-PMIC-struct-from-vdd_info-.patch"
	git am "${DIR}/patches/omap-3.0-pm/0155-OMAP3-VC-make-I2C-config-programmable-with-PMIC-spec.patch"
	git am "${DIR}/patches/omap-3.0-pm/0156-OMAP3-PM-VC-handle-mutant-channel-config-for-OMAP4-M.patch"
	git am "${DIR}/patches/omap-3.0-pm/0157-OMAP3-VC-use-last-nominal-voltage-setting-to-get-cur.patch"
	git am "${DIR}/patches/omap-3.0-pm/0158-OMAP3-VP-cleanup-move-VP-instance-into-voltdm-misc.-.patch"
	git am "${DIR}/patches/omap-3.0-pm/0159-OMAP3-voltage-remove-unneeded-debugfs-interface.patch"
	git am "${DIR}/patches/omap-3.0-pm/0160-OMAP3-VP-struct-omap_vp_common-replace-shift-with-__.patch"
	git am "${DIR}/patches/omap-3.0-pm/0161-OMAP3-VP-move-SoC-specific-sys-clock-rate-retreival-.patch"
	git am "${DIR}/patches/omap-3.0-pm/0162-OMAP3-VP-move-timing-calculation-config-into-VP-init.patch"
	git am "${DIR}/patches/omap-3.0-pm/0163-OMAP3-VP-create-VP-helper-function-for-updating-erro.patch"
	git am "${DIR}/patches/omap-3.0-pm/0164-OMAP3-VP-remove-omap_vp_runtime_data.patch"
	git am "${DIR}/patches/omap-3.0-pm/0165-OMAP3-VP-move-voltage-scale-function-pointer-into-st.patch"
	git am "${DIR}/patches/omap-3.0-pm/0166-OMAP-VP-Explicitly-mask-VPVOLTAGE-field.patch"
	git am "${DIR}/patches/omap-3.0-pm/0167-OMAP3-VP-update_errorgain-return-error-if-VP.patch"
	git am "${DIR}/patches/omap-3.0-pm/0168-OMAP3-VP-remove-unused-omap_vp_get_curr_volt.patch"
	git am "${DIR}/patches/omap-3.0-pm/0169-OMAP3-VP-combine-setting-init-voltage-into-common-fu.patch"
	git am "${DIR}/patches/omap-3.0-pm/0170-OMAP3-voltage-rename-scale-and-reset-functions-using.patch"
	git am "${DIR}/patches/omap-3.0-pm/0171-OMAP3-voltage-move-rename-curr_volt-from-vdd_info-in.patch"
	git am "${DIR}/patches/omap-3.0-pm/0172-OMAP3-voltdm-final-removal-of-omap_vdd_info.patch"
	git am "${DIR}/patches/omap-3.0-pm/0173-OMAP3-voltage-rename-omap_voltage_get_nom_volt-voltd.patch"
	git am "${DIR}/patches/omap-3.0-pm/0174-OMAP3-voltage-update-nominal-voltage-in-voltdm_scale.patch"
	git am "${DIR}/patches/omap-3.0-pm/0175-OMAP4-PM-TWL6030-fix-voltage-conversion-formula.patch"
	git am "${DIR}/patches/omap-3.0-pm/0176-OMAP4-PM-TWL6030-fix-uv-to-voltage-for-0x39.patch"
	git am "${DIR}/patches/omap-3.0-pm/0177-OMAP4-PM-TWL6030-address-0V-conversions.patch"
	git am "${DIR}/patches/omap-3.0-pm/0178-OMAP4-PM-TWL6030-fix-ON-RET-OFF-voltages.patch"
	git am "${DIR}/patches/omap-3.0-pm/0179-OMAP4-PM-TWL6030-add-cmd-register.patch"
	git am "${DIR}/patches/omap-3.0-pm/0180-PM-OPP-introduce-function-to-free-cpufreq-table.patch"
	git am "${DIR}/patches/omap-3.0-pm/0181-OMAP-CPUfreq-ensure-driver-initializes-after-cpufreq.patch"
	git am "${DIR}/patches/omap-3.0-pm/0182-OMAP-CPUfreq-ensure-policy-is-fully-initialized.patch"
	git am "${DIR}/patches/omap-3.0-pm/0183-OMAP3-PM-CPUFreq-driver-for-OMAP3.patch"
	git am "${DIR}/patches/omap-3.0-pm/0184-OMAP-PM-CPUFREQ-Fix-conditional-compilation.patch"
	git am "${DIR}/patches/omap-3.0-pm/0185-cpufreq-fixup-after-new-OPP-layer-merged.patch"
	git am "${DIR}/patches/omap-3.0-pm/0186-OMAP-cpufreq-Split-OMAP1-and-OMAP2PLUS-CPUfreq-drive.patch"
	git am "${DIR}/patches/omap-3.0-pm/0187-OMAP2PLUS-cpufreq-Add-SMP-support-to-cater-OMAP4430.patch"
	git am "${DIR}/patches/omap-3.0-pm/0188-OMAP2PLUS-cpufreq-Fix-typo-when-attempting-to-set-mp.patch"
	git am "${DIR}/patches/omap-3.0-pm/0189-OMAP2-cpufreq-move-clk-name-decision-to-init.patch"
	git am "${DIR}/patches/omap-3.0-pm/0190-OMAP2-cpufreq-deny-initialization-if-no-mpudev.patch"
	git am "${DIR}/patches/omap-3.0-pm/0191-OMAP2-cpufreq-dont-support-freq_table.patch"
	git am "${DIR}/patches/omap-3.0-pm/0192-OMAP2-cpufreq-only-supports-OPP-library.patch"
	git am "${DIR}/patches/omap-3.0-pm/0193-OMAP2-cpufreq-put-clk-if-cpu_init-failed.patch"
	git am "${DIR}/patches/omap-3.0-pm/0194-OMAP2-cpufreq-fix-freq_table-leak.patch"
	git am "${DIR}/patches/omap-3.0-pm/0195-OMAP2-CPUfreq-Remove-superfluous-check-in-target-for.patch"
	git am "${DIR}/patches/omap-3.0-pm/0196-OMAP2-cpufreq-notify-even-with-bad-boot-frequency.patch"
	git am "${DIR}/patches/omap-3.0-pm/0197-OMAP2-cpufreq-Enable-all-CPUs-in-shared-policy-mask.patch"
	git am "${DIR}/patches/omap-3.0-pm/0198-OMAP2-CPUfreq-update-lpj-with-reference-value-to-avo.patch"
	git am "${DIR}/patches/omap-3.0-pm/0199-usb-musb-fix-build-breakage.patch"

#in 3.0.26
#	git am "${DIR}/patches/omap-3.0-pm/0200-omap-madc-Fix-NULL-pointer-and-NULL-device-bugs.patch"

	git am "${DIR}/patches/omap-3.0-pm/0201-omap-beagle-Add-madc-support.patch"
	git am "${DIR}/patches/omap-3.0-pm/0202-omap-overo-Add-madc-support.patch"
	git am "${DIR}/patches/omap-3.0-pm/0203-plat-omap-Kconfig-Change-OMAP_IOMMU-from-tristate-to.patch"
	git am "${DIR}/patches/omap-3.0-pm/0204-omap-overo-Add-support-for-Caspa-camera-module.patch"
	git am "${DIR}/patches/omap-3.0-pm/0205-ARM-OMAP3-PM-fix-I-O-wakeup-and-I-O-chain-clock-cont.patch"
	git am "${DIR}/patches/omap-3.0-pm/0206-MMC-add-workaround-for-controllers-with-broken-multi.patch"
	git am "${DIR}/patches/omap-3.0-pm/0207-MMC-omap_hsmmc-disable-multiblock-reads-when-platfor.patch"
	git am "${DIR}/patches/omap-3.0-pm/0208-ARM-OMAP3-hwmod-data-disable-multiblock-reads-on-MMC.patch"
	git am "${DIR}/patches/omap-3.0-pm/0209-omap-hsmmc-Increase-dto-to-deal-with-timeout-errors.patch"
	git am "${DIR}/patches/omap-3.0-pm/0210-ARM-OMAP-Add-initial-support-for-Rockhopper.patch"
	git am "${DIR}/patches/omap-3.0-pm/0211-mfd-twl4030-madc-Enable-ADC-channels-3-6.patch"
	git am "${DIR}/patches/omap-3.0-pm/0212-omap-overo-test-for-iva-before-attempting-to-set-iva.patch"
	git am "${DIR}/patches/omap-3.0-pm/0213-omap-opp-test-for-iva-before-attempting-to-set-iva-o.patch"

#in 3.0.26
#	git am "${DIR}/patches/omap-3.0-pm/0214-omap-serial-Allow-IXON-and-IXOFF-to-be-disabled.patch"
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

#4.03.00.01
#Note: git am has problems with this patch...
patch -s -p1 < "${DIR}/patches/sgx/0001-OMAP3-SGX-Merge-TI-4.03.00.01-into-TI-4.00.00.01.patch"

#4.03.00.02 (main *.bin drops omap4)
patch -s -p1 < "${DIR}/patches/sgx/0001-OMAP3-SGX-Merge-TI-4.03.00.02-into-TI-4.03.00.01.patch"

#4.03.00.02
patch -s -p1 < "${DIR}/patches/sgx/0001-OMAP3-SGX-TI-4.03.00.02-2.6.32-PSP.patch"

#4.03.00.02 + 2.6.38-merge (2.6.37-git5)
patch -s -p1 < "${DIR}/patches/sgx/0001-OMAP3-SGX-TI-4.03.00.02-2.6.38-merge-AUTOCONF_INCLUD.patch"

#4.03.00.02 + 2.6.38-rc3
patch -s -p1 < "${DIR}/patches/sgx/0001-OMAP3-SGX-TI-4.03.00.02-2.6.38-rc3-_console_sem-to-c.patch"

#4.03.00.01
patch -s -p1 < "${DIR}/patches/sgx/0001-OMAP3-SGX-TI-4.03.00.01-add-outer_cache.clean_all.patch"

#4.03.00.02
#omap3 doesn't work on omap3630
patch -s -p1 < "${DIR}/patches/sgx/0001-OMAP3-SGX-TI-4.03.00.02-use-omap3630-as-TI_PLATFORM.patch"

#4.03.00.02 + 2.6.39 (2.6.38-git2)
patch -s -p1 < "${DIR}/patches/sgx/0001-OMAP3-SGX-TI-4.03.00.02-2.6.39-rc-SPIN_LOCK_UNLOCKED.patch"

#4.03.00.02 + 2.6.40 (2.6.39-git11)
patch -s -p1 < "${DIR}/patches/sgx/0001-OMAP3-SGX-TI-4.03.00.02-2.6.40-display.h-to-omapdss..patch"
}

bugs_trivial
beagle

omap_pm

#no chance of being pushed ever tree's
#sgx

echo "patch.sh ran successful"

