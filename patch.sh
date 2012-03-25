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

function git_add {
git add .
git commit -a -m 'testing patchset'
}

function bugs_trivial {
	echo "bugs and trivial stuff"
	git am "${DIR}/patches/trivial/0001-staging-add-airlink-awll7025-id-for-rt2860.patch"
	git am "${DIR}/patches/trivial/0001-kbuild-deb-pkg-set-host-machine-after-dpkg-gencontro.patch"
	#should fix gcc-4.6 ehci problems..
	git am "${DIR}/patches/trivial/0001-USB-ehci-remove-structure-packing-from-ehci_def.patch"
	git am "${DIR}/patches/trivial/0001-USB-ehci-use-packed-aligned-4-instead-of-removing-th.patch"

#	git am "${DIR}/patches/dss2_next/0001-OMAP4-DSS2-Register-configuration-changes-for-DSI.patch"
	git am "${DIR}/patches/musb/0001-default-to-fifo-mode-5-for-old-musb-beagles.patch"
	git am "${DIR}/patches/arago-project/0001-omap3-Increase-limit-on-bootarg-mpurate.patch"
	git am "${DIR}/patches/beagle/0001-omap3-alsa-soc-Remove-restrictive-checks-for-cpu-typ.patch"
	git am "${DIR}/patches/display/0001-meego-modedb-add-Toshiba-LTA070B220F-800x480-support.patch"
}

function omap_pm {
	echo "omap pm"
	git am "${DIR}/patches/omap-2.6.39-pm/0001-OMAP-DSS2-DSI-fix-use_sys_clk-highfreq.patch"
	git am "${DIR}/patches/omap-2.6.39-pm/0002-OMAP-DSS2-DSI-fix-dsi_dump_clocks.patch"
	git am "${DIR}/patches/omap-2.6.39-pm/0003-OMAP2PLUS-DSS2-Fix-Return-correct-lcd-clock-source-f.patch"
	git am "${DIR}/patches/omap-2.6.39-pm/0004-OMAP-DSS-DSI-Fix-DSI-PLL-power-bug.patch"
	git am "${DIR}/patches/omap-2.6.39-pm/0005-OMAP-DSS2-fix-panel-Kconfig-dependencies.patch"
	git am "${DIR}/patches/omap-2.6.39-pm/0006-OMAP-DSS2-add-bootarg-for-selecting-svideo-or-compos.patch"
	git am "${DIR}/patches/omap-2.6.39-pm/0007-video-add-timings-for-hd720.patch"
	git am "${DIR}/patches/omap-2.6.39-pm/0008-drivers-net-smsc911x-return-ENODEV-if-device-is-not-.patch"
	git am "${DIR}/patches/omap-2.6.39-pm/0009-drivers-input-touchscreen-ads7846-return-ENODEV-if-d.patch"
	git am "${DIR}/patches/omap-2.6.39-pm/0010-Revert-omap2_mcspi-Flush-posted-writes.patch"
	git am "${DIR}/patches/omap-2.6.39-pm/0011-Revert-omap_hsmmc-improve-interrupt-synchronisation.patch"
	git am "${DIR}/patches/omap-2.6.39-pm/0012-Don-t-turn-SDIO-cards-off-to-save-power.-Doing-so-wi.patch"
	git am "${DIR}/patches/omap-2.6.39-pm/0013-Enable-the-use-of-SDIO-card-interrupts.patch"
	git am "${DIR}/patches/omap-2.6.39-pm/0014-soc-codecs-Enable-audio-capture-by-default-for-twl40.patch"
	git am "${DIR}/patches/omap-2.6.39-pm/0015-soc-codecs-twl4030-Turn-on-mic-bias-by-default.patch"
	git am "${DIR}/patches/omap-2.6.39-pm/0016-RTC-add-support-for-backup-battery-recharge.patch"
	git am "${DIR}/patches/omap-2.6.39-pm/0017-ARM-OMAP2-mmc-twl4030-move-clock-input-selection-pri.patch"
	git am "${DIR}/patches/omap-2.6.39-pm/0018-Add-power-off-support-for-the-TWL4030-companion.patch"
	git am "${DIR}/patches/omap-2.6.39-pm/0019-ARM-OMAP-Add-twl4030-madc-support-to-Beagle.patch"
	git am "${DIR}/patches/omap-2.6.39-pm/0020-ARM-OMAP-Add-twl4030-madc-support-to-Overo.patch"
	git am "${DIR}/patches/omap-2.6.39-pm/0021-Enabling-Hwmon-driver-for-twl4030-madc.patch"
	git am "${DIR}/patches/omap-2.6.39-pm/0022-mfd-twl-core-enable-madc-clock.patch"
	git am "${DIR}/patches/omap-2.6.39-pm/0023-rtc-twl-Switch-to-using-threaded-irq.patch"
	git am "${DIR}/patches/omap-2.6.39-pm/0024-ARM-OMAP-automatically-set-musb-mode-in-platform-dat.patch"
	git am "${DIR}/patches/omap-2.6.39-pm/0025-omap-mmc-Adjust-dto-to-eliminate-timeout-errors.patch"
	git am "${DIR}/patches/omap-2.6.39-pm/0026-OMAP-Overo-Add-support-for-spidev.patch"
	git am "${DIR}/patches/omap-2.6.39-pm/0027-unionfs-Add-support-for-unionfs-2.5.9.patch"
	git am "${DIR}/patches/omap-2.6.39-pm/0028-OMAP3-beagle-add-support-for-beagleboard-xM-revision.patch"
	git am "${DIR}/patches/omap-2.6.39-pm/0029-OMAP3-beagle-add-support-for-expansionboards.patch"
	git am "${DIR}/patches/omap-2.6.39-pm/0030-omap-beagle-Add-support-for-1GHz.patch"
	git am "${DIR}/patches/omap-2.6.39-pm/0031-omap-Change-omap_device-activate-dectivate-latency-m.patch"
	git am "${DIR}/patches/omap-2.6.39-pm/0032-omap-overo-Add-opp-init.patch"
	git am "${DIR}/patches/omap-2.6.39-pm/0033-ARM-OMAP-Overo-remove-duplicate-call-to-overo_ads784.patch"

#in 2.6.39.4
#	git am "${DIR}/patches/omap-2.6.39-pm/0034-omap-nand-fix-subpage-ecc-issue-with-prefetch.patch"

	git am "${DIR}/patches/omap-2.6.39-pm/0035-mtd-nand-Eliminate-noisey-uncorrectable-error-messag.patch"

#in 2.6.39.4
#	git am "${DIR}/patches/omap-2.6.39-pm/0036-mtd-return-badblockbits-back.patch"

	git am "${DIR}/patches/omap-2.6.39-pm/0037-omap-Add-omap3_defconfig.patch"
	git am "${DIR}/patches/omap-2.6.39-pm/0038-OMAP3-voltage-remove-spurious-pr_notice-for-debugfs.patch"
	git am "${DIR}/patches/omap-2.6.39-pm/0039-OMAP4-PM-remove-redundant-ifdef-CONFIG_PM.patch"
	git am "${DIR}/patches/omap-2.6.39-pm/0040-OMAP3-smartreflex-fix-sr_late_init-error-path-in-pro.patch"
	git am "${DIR}/patches/omap-2.6.39-pm/0041-OMAP3-smartreflex-request-the-memory-region.patch"
	git am "${DIR}/patches/omap-2.6.39-pm/0042-OMAP3-smartreflex-fix-ioremap-leak-on-probe-error.patch"
	git am "${DIR}/patches/omap-2.6.39-pm/0043-OMAP3-smartreflex-delete-instance-from-sr_list-on-pr.patch"
	git am "${DIR}/patches/omap-2.6.39-pm/0044-OMAP3-smartreflex-delete-debugfs-entries-on-probe-er.patch"
	git am "${DIR}/patches/omap-2.6.39-pm/0045-OMAP3-cpuidle-remove-useless-SDP-specific-timings.patch"
	git am "${DIR}/patches/omap-2.6.39-pm/0046-OMAP3-SR-make-notify-independent-of-class.patch"
	git am "${DIR}/patches/omap-2.6.39-pm/0047-OMAP3-SR-disable-interrupt-by-default.patch"
	git am "${DIR}/patches/omap-2.6.39-pm/0048-OMAP3-SR-enable-disable-SR-only-on-need.patch"
	git am "${DIR}/patches/omap-2.6.39-pm/0049-OMAP3-SR-fix-cosmetic-indentation.patch"
	git am "${DIR}/patches/omap-2.6.39-pm/0050-OMAP-CPUfreq-ensure-driver-initializes-after-cpufreq.patch"
	git am "${DIR}/patches/omap-2.6.39-pm/0051-OMAP-CPUfreq-ensure-policy-is-fully-initialized.patch"
	git am "${DIR}/patches/omap-2.6.39-pm/0052-OMAP3-PM-CPUFreq-driver-for-OMAP3.patch"
	git am "${DIR}/patches/omap-2.6.39-pm/0053-OMAP-PM-CPUFREQ-Fix-conditional-compilation.patch"
	git am "${DIR}/patches/omap-2.6.39-pm/0054-cpufreq-fixup-after-new-OPP-layer-merged.patch"
	git am "${DIR}/patches/omap-2.6.39-pm/0055-OMAP-cpufreq-Split-OMAP1-and-OMAP2PLUS-CPUfreq-drive.patch"
	git am "${DIR}/patches/omap-2.6.39-pm/0056-OMAP2PLUS-cpufreq-Add-SMP-support-to-cater-OMAP4430.patch"
	git am "${DIR}/patches/omap-2.6.39-pm/0057-OMAP2PLUS-cpufreq-Fix-typo-when-attempting-to-set-mp.patch"
	git am "${DIR}/patches/omap-2.6.39-pm/0058-cpufreq-helpers-for-walking-the-frequency-table.patch"
	git am "${DIR}/patches/omap-2.6.39-pm/0059-cpufreq-introduce-hotplug-governor.patch"
	git am "${DIR}/patches/omap-2.6.39-pm/0060-OMAP2-cpufreq-free-up-table-on-exit.patch"
	git am "${DIR}/patches/omap-2.6.39-pm/0061-OMAP2-cpufreq-handle-invalid-cpufreq-table.patch"
	git am "${DIR}/patches/omap-2.6.39-pm/0062-OMAP2-cpufreq-minor-comment-cleanup.patch"
	git am "${DIR}/patches/omap-2.6.39-pm/0063-OMAP2-cpufreq-use-clk_init_cpufreq_table-if-OPPs-not.patch"
	git am "${DIR}/patches/omap-2.6.39-pm/0064-OMAP2-cpufreq-use-cpufreq_frequency_table_target.patch"
	git am "${DIR}/patches/omap-2.6.39-pm/0065-OMAP2-cpufreq-fix-freq_table-leak.patch"
	git am "${DIR}/patches/omap-2.6.39-pm/0066-OMAP2-clockdomain-Add-an-api-to-read-idle-mode.patch"
	git am "${DIR}/patches/omap-2.6.39-pm/0067-OMAP2-clockdomain-Add-SoC-support-for-clkdm_is_idle.patch"
	git am "${DIR}/patches/omap-2.6.39-pm/0068-OMAP2-PM-Initialise-sleep_switch-to-a-non-valid-valu.patch"
	git am "${DIR}/patches/omap-2.6.39-pm/0069-OMAP2-PM-idle-clkdms-only-if-already-in-idle.patch"
	git am "${DIR}/patches/omap-2.6.39-pm/0070-OMAP2-hwmod-Follow-the-recomended-PRCM-sequence.patch"
	git am "${DIR}/patches/omap-2.6.39-pm/0071-OMAP-Serial-Check-wk_st-only-if-present.patch"
	git am "${DIR}/patches/omap-2.6.39-pm/0072-omap3-Add-basic-support-for-720MHz-part.patch"
	git am "${DIR}/patches/omap-2.6.39-pm/0073-Revert-Enable-the-use-of-SDIO-card-interrupts.patch"

#in 2.6.39.4
#	git am "${DIR}/patches/omap-2.6.39-pm/0074-mfd-Fix-omap-usbhs-crash-when-rmmoding-ehci-or-ohci.patch"

	git am "${DIR}/patches/omap-2.6.39-pm/0075-mfd-Fix-omap_usbhs_alloc_children-error-handling.patch"
	git am "${DIR}/patches/omap-2.6.39-pm/0076-mfd-Add-omap-usbhs-runtime-PM-support.patch"
	git am "${DIR}/patches/omap-2.6.39-pm/0077-arm-omap-usb-ehci-and-ohci-hwmod-structures-for-omap.patch"
	git am "${DIR}/patches/omap-2.6.39-pm/0078-arm-omap-usb-register-hwmods-of-usbhs.patch"
	git am "${DIR}/patches/omap-2.6.39-pm/0079-arm-omap-usb-device-name-change-for-the-clk-names-of.patch"
	git am "${DIR}/patches/omap-2.6.39-pm/0080-mfd-global-Suspend-and-resume-support-of-ehci-and-oh.patch"
	git am "${DIR}/patches/omap-2.6.39-pm/0081-MFD-TWL4030-Correct-the-warning-print-during-script-.patch"
	git am "${DIR}/patches/omap-2.6.39-pm/0082-MFD-TWL4030-Modifying-the-macro-name-Main_Ref-to-all.patch"
	git am "${DIR}/patches/omap-2.6.39-pm/0083-MFD-TWL4030-power-scripts-for-OMAP3-boards.patch"
	git am "${DIR}/patches/omap-2.6.39-pm/0084-MFD-TWL4030-TWL-version-checking.patch"
	git am "${DIR}/patches/omap-2.6.39-pm/0085-MFD-TWL4030-workaround-changes-for-Erratum-27.patch"
	git am "${DIR}/patches/omap-2.6.39-pm/0086-MFD-TWL4030-optimizing-resource-configuration.patch"
	git am "${DIR}/patches/omap-2.6.39-pm/0087-omap-pm-related-changes-to-omap3_defconfig.patch"
	git am "${DIR}/patches/omap-2.6.39-pm/0088-omap-overo-Make-mmc2-non-removable.patch"
	git am "${DIR}/patches/omap-2.6.39-pm/0089-mac80211-frag-ack-patch-for-aircrack-ng.patch"
	git am "${DIR}/patches/omap-2.6.39-pm/0090-wireless-allow-to-retrieve-the-channel-set-on-monito.patch"
	git am "${DIR}/patches/omap-2.6.39-pm/0091-UBIFS-fix-memory-leak-on-error-path.patch"

}

function for_next_40 {
echo "for_next from tmlind's tree.."
#patch -s -p1 < "${DIR}/patches/for_next_40/0003-OMAP3-voltage-remove-spurious-pr_notice-for-debugfs.patch"
#patch -s -p1 < "${DIR}/patches/for_next_40/0004-OMAP4-PM-remove-redundant-ifdef-CONFIG_PM.patch"
#patch -s -p1 < "${DIR}/patches/for_next_40/0005-OMAP3-smartreflex-fix-sr_late_init-error-path-in-pro.patch"
#patch -s -p1 < "${DIR}/patches/for_next_40/0006-OMAP3-smartreflex-request-the-memory-region.patch"
#patch -s -p1 < "${DIR}/patches/for_next_40/0007-OMAP3-smartreflex-fix-ioremap-leak-on-probe-error.patch"
#patch -s -p1 < "${DIR}/patches/for_next_40/0008-OMAP3-smartreflex-delete-instance-from-sr_list-on-pr.patch"
#patch -s -p1 < "${DIR}/patches/for_next_40/0009-OMAP3-smartreflex-delete-debugfs-entries-on-probe-er.patch"
patch -s -p1 < "${DIR}/patches/for_next_40/0013-omap-gpmc-smsc911x-always-set-irq-flags-to-IORESOURC.patch"
patch -s -p1 < "${DIR}/patches/for_next_40/0014-omap-convert-boards-that-use-SMSC911x-to-use-gpmc-sm.patch"
patch -s -p1 < "${DIR}/patches/for_next_40/0015-OMAP3-4-l3-fix-omap3_l3_probe-error-path.patch"
patch -s -p1 < "${DIR}/patches/for_next_40/0016-OMAP3-4-l3-minor-cleanup-for-parenthesis-and-extra-s.patch"
}


function wip_to_be_pushed_git  {
echo "wip patches for mainline"

git_add
git am "${DIR}/patches/wip_to_be_pushed/0001-omap3-beagle-convert-printk-KERN_INFO-to-pr_info.patch"
git am "${DIR}/patches/wip_to_be_pushed/0002-omap3-beagle-convert-printk-KERN_ERR-to-pr_err.patch"
git am "${DIR}/patches/wip_to_be_pushed/0003-omap3-beagle-detect-new-xM-revision-B.patch"
git am "${DIR}/patches/wip_to_be_pushed/0004-omap3-beagle-detect-new-xM-revision-C.patch"
git am "${DIR}/patches/wip_to_be_pushed/0005-omap3-beagle-if-rev-unknown-assume-xM-revision-C.patch"
git am "${DIR}/patches/wip_to_be_pushed/0006-omap3-beagle-add-i2c-bus2.patch"
git am "${DIR}/patches/wip_to_be_pushed/0007-omap3-beagle-add-initial-expansionboard-infrastructu.patch"
git am "${DIR}/patches/wip_to_be_pushed/0008-omap3-beagle-expansionboard-zippy.patch"
git am "${DIR}/patches/wip_to_be_pushed/0009-omap3-beagle-expansionboard-zippy2.patch"

}

function wip_to_be_pushed  {
echo "wip patches for mainline"

patch -s -p1 < "${DIR}/patches/wip_to_be_pushed/0001-omap3-beagle-convert-printk-KERN_INFO-to-pr_info.patch"
patch -s -p1 < "${DIR}/patches/wip_to_be_pushed/0002-omap3-beagle-convert-printk-KERN_ERR-to-pr_err.patch"
patch -s -p1 < "${DIR}/patches/wip_to_be_pushed/0003-omap3-beagle-detect-new-xM-revision-B.patch"
patch -s -p1 < "${DIR}/patches/wip_to_be_pushed/0004-omap3-beagle-detect-new-xM-revision-C.patch"
patch -s -p1 < "${DIR}/patches/wip_to_be_pushed/0005-omap3-beagle-if-rev-unknown-assume-xM-revision-C.patch"
patch -s -p1 < "${DIR}/patches/wip_to_be_pushed/0006-omap3-beagle-add-i2c-bus2.patch"
patch -s -p1 < "${DIR}/patches/wip_to_be_pushed/0007-omap3-beagle-add-initial-expansionboard-infrastructu.patch"
patch -s -p1 < "${DIR}/patches/wip_to_be_pushed/0008-omap3-beagle-expansionboard-zippy.patch"
patch -s -p1 < "${DIR}/patches/wip_to_be_pushed/0009-omap3-beagle-expansionboard-zippy2.patch"

}

function sakoman {
echo "sakoman's patches"

patch -s -p1 < "${DIR}/patches/sakoman/2.6.39/0001-OMAP-DSS2-DSI-fix-use_sys_clk-highfreq.patch"
patch -s -p1 < "${DIR}/patches/sakoman/2.6.39/0002-OMAP-DSS2-DSI-fix-dsi_dump_clocks.patch"
patch -s -p1 < "${DIR}/patches/sakoman/2.6.39/0003-OMAP2PLUS-DSS2-Fix-Return-correct-lcd-clock-source-f.patch"

patch -s -p1 < "${DIR}/patches/sakoman/2.6.40/0004-OMAP-DSS-DSI-Fix-DSI-PLL-power-bug.patch"

patch -s -p1 < "${DIR}/patches/sakoman/2.6.39/0005-OMAP-DSS2-fix-panel-Kconfig-dependencies.patch"
patch -s -p1 < "${DIR}/patches/sakoman/2.6.39/0006-OMAP-DSS2-add-bootarg-for-selecting-svideo-or-compos.patch"
patch -s -p1 < "${DIR}/patches/sakoman/2.6.39/0007-video-add-timings-for-hd720.patch"
patch -s -p1 < "${DIR}/patches/sakoman/2.6.39/0008-drivers-net-smsc911x-return-ENODEV-if-device-is-not-.patch"
patch -s -p1 < "${DIR}/patches/sakoman/2.6.39/0009-drivers-input-touchscreen-ads7846-return-ENODEV-if-d.patch"
patch -s -p1 < "${DIR}/patches/sakoman/2.6.39/0010-Revert-omap2_mcspi-Flush-posted-writes.patch"
patch -s -p1 < "${DIR}/patches/sakoman/2.6.39/0011-Revert-omap_hsmmc-improve-interrupt-synchronisation.patch"
patch -s -p1 < "${DIR}/patches/sakoman/2.6.39/0012-Don-t-turn-SDIO-cards-off-to-save-power.-Doing-so-wi.patch"
patch -s -p1 < "${DIR}/patches/sakoman/2.6.39/0013-Enable-the-use-of-SDIO-card-interrupts.patch"
patch -s -p1 < "${DIR}/patches/sakoman/2.6.39/0014-soc-codecs-Enable-audio-capture-by-default-for-twl40.patch"
patch -s -p1 < "${DIR}/patches/sakoman/2.6.39/0015-soc-codecs-twl4030-Turn-on-mic-bias-by-default.patch"
patch -s -p1 < "${DIR}/patches/sakoman/2.6.39/0016-RTC-add-support-for-backup-battery-recharge.patch"
patch -s -p1 < "${DIR}/patches/sakoman/2.6.39/0017-ARM-OMAP2-mmc-twl4030-move-clock-input-selection-pri.patch"
patch -s -p1 < "${DIR}/patches/sakoman/2.6.39/0018-Add-power-off-support-for-the-TWL4030-companion.patch"
patch -s -p1 < "${DIR}/patches/sakoman/2.6.39/0019-ARM-OMAP-Add-twl4030-madc-support-to-Beagle.patch"
patch -s -p1 < "${DIR}/patches/sakoman/2.6.39/0020-ARM-OMAP-Add-twl4030-madc-support-to-Overo.patch"
patch -s -p1 < "${DIR}/patches/sakoman/2.6.39/0021-Enabling-Hwmon-driver-for-twl4030-madc.patch"
patch -s -p1 < "${DIR}/patches/sakoman/2.6.39/0022-mfd-twl-core-enable-madc-clock.patch"
patch -s -p1 < "${DIR}/patches/sakoman/2.6.39/0023-rtc-twl-Switch-to-using-threaded-irq.patch"
patch -s -p1 < "${DIR}/patches/sakoman/2.6.39/0024-ARM-OMAP-automatically-set-musb-mode-in-platform-dat.patch"
patch -s -p1 < "${DIR}/patches/sakoman/2.6.39/0025-omap-mmc-Adjust-dto-to-eliminate-timeout-errors.patch"
patch -s -p1 < "${DIR}/patches/sakoman/2.6.39/0026-omap-Fix-mtd-subpage-read-alignment.patch"
patch -s -p1 < "${DIR}/patches/sakoman/2.6.39/0027-mtd-nand-omap2-Force-all-buffer-reads-to-u32-alignme.patch"

#fixed in 2.6.39.1
#patch -s -p1 < "${DIR}/patches/sakoman/2.6.39/0028-omap-nand-fix-subpage-ecc-issue-with-prefetch.patch"

patch -s -p1 < "${DIR}/patches/sakoman/2.6.39/0029-OMAP-Overo-Add-support-for-spidev.patch"
patch -s -p1 < "${DIR}/patches/sakoman/2.6.39/0030-unionfs-Add-support-for-unionfs-2.5.9.patch"
patch -s -p1 < "${DIR}/patches/sakoman/2.6.39/0031-OMAP3-beagle-add-support-for-beagleboard-xM-revision.patch"
patch -s -p1 < "${DIR}/patches/sakoman/2.6.39/0032-OMAP3-beagle-add-support-for-expansionboards.patch"
patch -s -p1 < "${DIR}/patches/sakoman/2.6.39/0033-omap-Change-omap_device-activate-dectivate-latency-m.patch"
patch -s -p1 < "${DIR}/patches/sakoman/2.6.39/0034-omap-Add-omap3_defconfig.patch"
patch -s -p1 < "${DIR}/patches/sakoman/2.6.39/0035-omap-overo-Add-opp-init.patch"
patch -s -p1 < "${DIR}/patches/sakoman/2.6.39/0036-OMAP3-voltage-remove-spurious-pr_notice-for-debugfs.patch"
patch -s -p1 < "${DIR}/patches/sakoman/2.6.39/0037-OMAP4-PM-remove-redundant-ifdef-CONFIG_PM.patch"
patch -s -p1 < "${DIR}/patches/sakoman/2.6.39/0038-OMAP3-smartreflex-fix-sr_late_init-error-path-in-pro.patch"
patch -s -p1 < "${DIR}/patches/sakoman/2.6.39/0039-OMAP3-smartreflex-request-the-memory-region.patch"
patch -s -p1 < "${DIR}/patches/sakoman/2.6.39/0040-OMAP3-smartreflex-fix-ioremap-leak-on-probe-error.patch"
patch -s -p1 < "${DIR}/patches/sakoman/2.6.39/0041-OMAP3-smartreflex-delete-instance-from-sr_list-on-pr.patch"
patch -s -p1 < "${DIR}/patches/sakoman/2.6.39/0042-OMAP3-smartreflex-delete-debugfs-entries-on-probe-er.patch"
patch -s -p1 < "${DIR}/patches/sakoman/2.6.39/0043-OMAP3-cpuidle-remove-useless-SDP-specific-timings.patch"
patch -s -p1 < "${DIR}/patches/sakoman/2.6.39/0044-OMAP3-SR-make-notify-independent-of-class.patch"
patch -s -p1 < "${DIR}/patches/sakoman/2.6.39/0045-OMAP3-SR-disable-interrupt-by-default.patch"
patch -s -p1 < "${DIR}/patches/sakoman/2.6.39/0046-OMAP3-SR-enable-disable-SR-only-on-need.patch"
patch -s -p1 < "${DIR}/patches/sakoman/2.6.39/0047-OMAP3-SR-fix-cosmetic-indentation.patch"
patch -s -p1 < "${DIR}/patches/sakoman/2.6.39/0048-OMAP-CPUfreq-ensure-driver-initializes-after-cpufreq.patch"
patch -s -p1 < "${DIR}/patches/sakoman/2.6.39/0049-OMAP-CPUfreq-ensure-policy-is-fully-initialized.patch"
patch -s -p1 < "${DIR}/patches/sakoman/2.6.39/0050-OMAP3-PM-CPUFreq-driver-for-OMAP3.patch"
patch -s -p1 < "${DIR}/patches/sakoman/2.6.39/0051-OMAP-PM-CPUFREQ-Fix-conditional-compilation.patch"
patch -s -p1 < "${DIR}/patches/sakoman/2.6.39/0052-cpufreq-fixup-after-new-OPP-layer-merged.patch"
patch -s -p1 < "${DIR}/patches/sakoman/2.6.39/0053-OMAP-cpufreq-Split-OMAP1-and-OMAP2PLUS-CPUfreq-drive.patch"
patch -s -p1 < "${DIR}/patches/sakoman/2.6.39/0054-OMAP2PLUS-cpufreq-Add-SMP-support-to-cater-OMAP4430.patch"
patch -s -p1 < "${DIR}/patches/sakoman/2.6.39/0055-OMAP2PLUS-cpufreq-Fix-typo-when-attempting-to-set-mp.patch"
patch -s -p1 < "${DIR}/patches/sakoman/2.6.39/0056-cpufreq-helpers-for-walking-the-frequency-table.patch"
patch -s -p1 < "${DIR}/patches/sakoman/2.6.39/0057-cpufreq-introduce-hotplug-governor.patch"
patch -s -p1 < "${DIR}/patches/sakoman/2.6.39/0058-OMAP2-cpufreq-free-up-table-on-exit.patch"
patch -s -p1 < "${DIR}/patches/sakoman/2.6.39/0059-OMAP2-cpufreq-handle-invalid-cpufreq-table.patch"
patch -s -p1 < "${DIR}/patches/sakoman/2.6.39/0060-OMAP2-cpufreq-minor-comment-cleanup.patch"
patch -s -p1 < "${DIR}/patches/sakoman/2.6.39/0061-OMAP2-cpufreq-use-clk_init_cpufreq_table-if-OPPs-not.patch"
patch -s -p1 < "${DIR}/patches/sakoman/2.6.39/0062-OMAP2-cpufreq-use-cpufreq_frequency_table_target.patch"
patch -s -p1 < "${DIR}/patches/sakoman/2.6.39/0063-OMAP2-cpufreq-fix-freq_table-leak.patch"

}

bugs_trivial
omap_pm

echo "patch.sh ran successful"

