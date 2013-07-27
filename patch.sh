#!/bin/sh
#
# Copyright (c) 2009-2013 Robert Nelson <robertcnelson@gmail.com>
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

git="git am"

if [ -f ${DIR}/system.sh ] ; then
	. ${DIR}/system.sh
fi

if [ "${RUN_BISECT}" ] ; then
	git="git apply"
fi

echo "Starting patch.sh"

git_add () {
	git add .
	git commit -a -m 'testing patchset'
}

start_cleanup () {
	git="git am --whitespace=fix"
}

cleanup () {
	if [ "${number}" ] ; then
		git format-patch -${number} -o ${DIR}/patches/
	fi
	exit
}

bugs_trivial () {
	echo "bugs and trivial stuff"
	${git} "${DIR}/patches/trivial/0001-kbuild-deb-pkg-set-host-machine-after-dpkg-gencontro.patch"
	${git} "${DIR}/patches/trivial/0002-USB-ehci-use-packed-aligned-4-instead-of-removing-th.patch"
}

beagle () {
	echo "Board Patchset: Beagle"
	${git} "${DIR}/patches/beagle/0001-OMAP3-beagle-add-support-for-beagleboard-xM-revision.patch"
	${git} "${DIR}/patches/beagle/0002-omap3-Increase-limit-on-bootarg-mpurate.patch"
	${git} "${DIR}/patches/beagle/0003-meego-modedb-add-Toshiba-LTA070B220F-800x480-support.patch"
	${git} "${DIR}/patches/beagle/0004-default-to-fifo-mode-5-for-old-musb-beagles.patch"
	${git} "${DIR}/patches/beagle/0005-beagleboard-reinstate-usage-of-hi-speed-PLL-divider.patch"
}

sakoman () {
	echo "sakoman's patches"
	${git} "${DIR}/patches/sakoman/0001-OMAP-DSS2-add-bootarg-for-selecting-svideo-or-compos.patch"
	${git} "${DIR}/patches/sakoman/0002-video-add-timings-for-hd720.patch"
	${git} "${DIR}/patches/sakoman/0003-drivers-net-smsc911x-return-ENODEV-if-device-is-not-.patch"
	${git} "${DIR}/patches/sakoman/0004-drivers-input-touchscreen-ads7846-return-ENODEV-if-d.patch"
	${git} "${DIR}/patches/sakoman/0005-soc-codecs-Enable-audio-capture-by-default-for-twl40.patch"
	${git} "${DIR}/patches/sakoman/0006-soc-codecs-twl4030-Turn-on-mic-bias-by-default.patch"
	${git} "${DIR}/patches/sakoman/0007-RTC-add-support-for-backup-battery-recharge.patch"
	${git} "${DIR}/patches/sakoman/0008-ARM-OMAP2-mmc-twl4030-move-clock-input-selection-pri.patch"
	${git} "${DIR}/patches/sakoman/0009-Add-power-off-support-for-the-TWL4030-companion.patch"
	${git} "${DIR}/patches/sakoman/0010-ARM-OMAP-Add-twl4030-madc-support-to-Beagle.patch"
	${git} "${DIR}/patches/sakoman/0011-ARM-OMAP-Add-twl4030-madc-support-to-Overo.patch"
	${git} "${DIR}/patches/sakoman/0012-Enabling-Hwmon-driver-for-twl4030-madc.patch"
	${git} "${DIR}/patches/sakoman/0013-mfd-twl-core-enable-madc-clock.patch"
	${git} "${DIR}/patches/sakoman/0014-rtc-twl-Switch-to-using-threaded-irq.patch"
	${git} "${DIR}/patches/sakoman/0015-omap-mmc-Adjust-dto-to-eliminate-timeout-errors.patch"
	${git} "${DIR}/patches/sakoman/0016-OMAP-Overo-Add-support-for-spidev.patch"
	${git} "${DIR}/patches/sakoman/0017-unionfs-Add-support-for-unionfs-2.5.9.patch"
	${git} "${DIR}/patches/sakoman/0018-OMAP3-beagle-add-support-for-expansionboards.patch"
	${git} "${DIR}/patches/sakoman/0019-omap-Change-omap_device-activate-dectivate-latency-m.patch"
	${git} "${DIR}/patches/sakoman/0020-omap-overo-Add-opp-init.patch"
	${git} "${DIR}/patches/sakoman/0021-ARM-OMAP-Overo-remove-duplicate-call-to-overo_ads784.patch"
	${git} "${DIR}/patches/sakoman/0022-mtd-nand-Eliminate-noisey-uncorrectable-error-messag.patch"
	${git} "${DIR}/patches/sakoman/0023-OMAP3-SR-make-notify-independent-of-class.patch"
	${git} "${DIR}/patches/sakoman/0024-OMAP3-SR-disable-interrupt-by-default.patch"
	${git} "${DIR}/patches/sakoman/0025-OMAP3-SR-enable-disable-SR-only-on-need.patch"
	${git} "${DIR}/patches/sakoman/0026-OMAP3-SR-fix-cosmetic-indentation.patch"
	${git} "${DIR}/patches/sakoman/0027-OMAP-CPUfreq-ensure-driver-initializes-after-cpufreq.patch"
	${git} "${DIR}/patches/sakoman/0028-OMAP-CPUfreq-ensure-policy-is-fully-initialized.patch"
	${git} "${DIR}/patches/sakoman/0029-OMAP3-PM-CPUFreq-driver-for-OMAP3.patch"
	${git} "${DIR}/patches/sakoman/0030-OMAP-PM-CPUFREQ-Fix-conditional-compilation.patch"
	${git} "${DIR}/patches/sakoman/0031-cpufreq-fixup-after-new-OPP-layer-merged.patch"
	${git} "${DIR}/patches/sakoman/0032-OMAP-cpufreq-Split-OMAP1-and-OMAP2PLUS-CPUfreq-drive.patch"
	${git} "${DIR}/patches/sakoman/0033-OMAP2PLUS-cpufreq-Add-SMP-support-to-cater-OMAP4430.patch"
	${git} "${DIR}/patches/sakoman/0034-OMAP2PLUS-cpufreq-Fix-typo-when-attempting-to-set-mp.patch"
	${git} "${DIR}/patches/sakoman/0035-cpufreq-helpers-for-walking-the-frequency-table.patch"
	${git} "${DIR}/patches/sakoman/0036-OMAP2-cpufreq-free-up-table-on-exit.patch"
	${git} "${DIR}/patches/sakoman/0037-OMAP2-cpufreq-handle-invalid-cpufreq-table.patch"
	${git} "${DIR}/patches/sakoman/0038-OMAP2-cpufreq-minor-comment-cleanup.patch"
	${git} "${DIR}/patches/sakoman/0039-OMAP2-cpufreq-use-clk_init_cpufreq_table-if-OPPs-not.patch"
	${git} "${DIR}/patches/sakoman/0040-OMAP2-cpufreq-use-cpufreq_frequency_table_target.patch"
	${git} "${DIR}/patches/sakoman/0041-OMAP2-cpufreq-fix-freq_table-leak.patch"
	${git} "${DIR}/patches/sakoman/0042-OMAP2-clockdomain-Add-an-api-to-read-idle-mode.patch"
	${git} "${DIR}/patches/sakoman/0043-OMAP2-clockdomain-Add-SoC-support-for-clkdm_is_idle.patch"
	${git} "${DIR}/patches/sakoman/0044-OMAP2-PM-Initialise-sleep_switch-to-a-non-valid-valu.patch"
	${git} "${DIR}/patches/sakoman/0045-OMAP2-PM-idle-clkdms-only-if-already-in-idle.patch"
	${git} "${DIR}/patches/sakoman/0046-OMAP2-hwmod-Follow-the-recomended-PRCM-sequence.patch"
	${git} "${DIR}/patches/sakoman/0047-OMAP-Serial-Check-wk_st-only-if-present.patch"
	${git} "${DIR}/patches/sakoman/0048-omap3-Add-basic-support-for-720MHz-part.patch"
}

sgx () {
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

sakoman

#no chance of being pushed ever tree's
sgx

echo "patch.sh ran successful"

