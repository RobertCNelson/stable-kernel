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

# DIR=`pwd`

git="git am"
#git="git am --whitespace=fix"

echo "Starting patch.sh"

git_add () {
	git add .
	git commit -a -m 'testing patchset'
}

cleanup () {
	git format-patch -18 -o ${DIR}/patches/
	exit
}

distro () {
	echo "Distro Specific Patches"
	git am "${DIR}/patches/distro/0001-kbuild-deb-pkg-set-host-machine-after-dpkg-gencontro.patch"
}

omap_cpufreq () {
	echo "omap-cpufreq"
	${git} "${DIR}/patches/omap_cpufreq/0001-cpufreq-OMAP-cleanup-for-multi-SoC-support-move-into.patch"
	${git} "${DIR}/patches/omap_cpufreq/0002-cpufreq-OMAP-Add-SMP-support-for-OMAP4.patch"
	${git} "${DIR}/patches/omap_cpufreq/0003-cpufreq-OMAP-Enable-all-CPUs-in-shared-policy-mask.patch"
	${git} "${DIR}/patches/omap_cpufreq/0004-cpufreq-OMAP-notify-even-with-bad-boot-frequency.patch"
	${git} "${DIR}/patches/omap_cpufreq/0005-cpufreq-OMAP-move-clk-name-decision-to-init.patch"
	${git} "${DIR}/patches/omap_cpufreq/0006-cpufreq-OMAP-deny-initialization-if-no-mpudev.patch"
	${git} "${DIR}/patches/omap_cpufreq/0007-cpufreq-OMAP-dont-support-freq_table.patch"
	${git} "${DIR}/patches/omap_cpufreq/0008-cpufreq-OMAP-only-supports-OPP-library.patch"
	${git} "${DIR}/patches/omap_cpufreq/0009-cpufreq-OMAP-put-clk-if-cpu_init-failed.patch"
	${git} "${DIR}/patches/omap_cpufreq/0010-cpufreq-OMAP-fix-freq_table-leak.patch"
	${git} "${DIR}/patches/omap_cpufreq/0011-cpufreq-OMAP-fixup-for-omap_device-changes-include-l.patch"
}

micrel_zippy2 () {
	echo "Micrel KZ8851 patches for: zippy2"
	#originaly from:
	#ftp://www.micrel.com/ethernet/8851/beagle_zippy_patches.tar.gz 137 KB 04/10/2010 12:26:00 AM

	${git} "${DIR}/patches/micrel_zippy2/0001-ksz8851-eeprom-93cx6-add-drive_data.patch"
	${git} "${DIR}/patches/micrel_zippy2/0002-ksz8851-eeprom-93cx6-add-eeprom_93cx6_write.patch"
	${git} "${DIR}/patches/micrel_zippy2/0003-ksz8851-read_mac_addr.patch"
	${git} "${DIR}/patches/micrel_zippy2/0004-ksz8851-93cx6-eeprom-access.patch"
	${git} "${DIR}/patches/micrel_zippy2/0005-ks8851.h-it-helps-to-include-the-include-file.patch"
	${git} "${DIR}/patches/micrel_zippy2/0006-ksz8851-move-to-header.patch"
	${git} "${DIR}/patches/micrel_zippy2/0007-ksz8851-move-more-to-header.patch"
	${git} "${DIR}/patches/micrel_zippy2/0008-ksz8851-share-ks8851_tx_hdr-union.patch"
	${git} "${DIR}/patches/micrel_zippy2/0009-ksz8851-add-is_level_irq.patch"
	${git} "${DIR}/patches/micrel_zippy2/0010-ksz8851-turn-off-hardware-interrupt-druing-receive-p.patch"
	${git} "${DIR}/patches/micrel_zippy2/0011-ksz8851-make-sure-is-awake-before-writing-mac.patch"
	${git} "${DIR}/patches/micrel_zippy2/0012-ksz8851-add-mutex-lock-unlock-to-ks.patch"
	${git} "${DIR}/patches/micrel_zippy2/0013-ksz8851-add-ks8851_tx_check.patch"
	${git} "${DIR}/patches/micrel_zippy2/0014-ksz8851-move-ks8851_set_powermode.patch"
}

sakoman () {
	echo "Patches from: Sakoman git tree"
	${git} "${DIR}/patches/sakoman/0001-OMAP-DSS2-add-bootarg-for-selecting-svideo.patch"
	${git} "${DIR}/patches/sakoman/0002-video-add-timings-for-hd720.patch"
	${git} "${DIR}/patches/sakoman/0003-omap-mmc-Adjust-dto-to-eliminate-timeout-errors.patch"
}

beagle () {
	echo "Board Patches for: BeagleBoard"
	${git} "${DIR}/patches/beagle/0001-expansion-add-buddy-param-for-expansionboard-names.patch"
	${git} "${DIR}/patches/beagle/0002-expansion-add-mmc-regulator-and-ds1307-rtc.patch"
	${git} "${DIR}/patches/beagle/0003-expansion-add-zippy.patch"
	${git} "${DIR}/patches/beagle/0004-expansion-add-zippy2.patch"
	${git} "${DIR}/patches/beagle/0005-expansion-add-trainer.patch"
	${git} "${DIR}/patches/beagle/0006-expansion-add-ulcd.patch"
	${git} "${DIR}/patches/beagle/0007-beagleboard-reinstate-usage-of-hi-speed-PLL-divider.patch"
	${git} "${DIR}/patches/beagle/0008-Turn-on-the-USB-regulator-on-Beagle-xM-explicitly.patch"
	${git} "${DIR}/patches/beagle/0009-meego-modedb-add-Toshiba-LTA070B220F-800x480-support.patch"
	${git} "${DIR}/patches/beagle/0010-beagleboard-fix-uLCD7-support.patch"
	${git} "${DIR}/patches/beagle/0011-default-to-fifo-mode-5-for-old-musb-beagles.patch"
	${git} "${DIR}/patches/beagle/0012-backlight-Add-TLC59108-backlight-control-driver.patch"
	${git} "${DIR}/patches/beagle/0013-tlc59108-adjust-for-beagleboard-uLCD7.patch"
	${git} "${DIR}/patches/beagle/0014-expansion-add-wifi.patch"
	${git} "${DIR}/patches/beagle/0015-ASoC-omap-add-MODULE_ALIAS-to-mcbsp-and-pcm-drivers.patch"
	${git} "${DIR}/patches/beagle/0016-ASoC-omap-convert-per-board-modules-to-platform-driv.patch"
	${git} "${DIR}/patches/beagle/0017-Beagle-expansion-zippy1-2-rework-mmc-i2c-handling.patch"
	${git} "${DIR}/patches/beagle/0018-Beagle-expansion-add-beaglefpga.patch"
	${git} "${DIR}/patches/beagle/0019-Enable-buddy-spidev.patch"
	${git} "${DIR}/patches/beagle/0020-zeroMAP-Open-your-eyes.patch"
}

devkit8000 () {
	echo "Board Patches for: devkit8000"
	${git} "${DIR}/patches/devkit8000/0001-arm-omap-devkit8000-for-lcd-use-samsung_lte_panel.patch"
}

igep0020 () {
	echo "Board Patches for: igep0020"
	${git} "${DIR}/patches/igep0020/0001-ARM-OMAP2-nand-Make-board_onenand_init-visible-to-bo.patch"
	${git} "${DIR}/patches/igep0020/0002-OMAP3-igep0020-Add-support-for-Micron-NAND-Flash-sto.patch"
}

touchbook () {
	echo "Board Patches for: Touchbook"
	${git} "${DIR}/patches/touchbook/0001-omap3-touchbook-remove-mmc-gpio_wp.patch"
	${git} "${DIR}/patches/touchbook/0002-omap3-touchbook-drop-u-boot-readonly.patch"
}

panda () {
	echo "Board Patches for: PandaBoard"
	${git} "${DIR}/patches/panda/0001-panda-fix-wl12xx-regulator.patch"
	${git} "${DIR}/patches/panda/0002-panda-enable-bluetooth.patch"
	${git} "${DIR}/patches/panda/0003-ti-st-st-kim-fixing-firmware-path.patch"
	${git} "${DIR}/patches/panda/0004-panda-enable-asoc.patch"
}

omap_fixes () {
	echo "omap cherry pick fixes"
	${git} "${DIR}/patches/omap_fixes/0001-omap3-Increase-limit-on-bootarg-mpurate.patch"
#	${git} "${DIR}/patches/omap_fixes/0002-Fix-sprz319-erratum-2.1.patch"
	${git} "${DIR}/patches/omap_fixes/0003-ARM-OMAP-AM3517-3505-fix-crash-on-boot-due-to-incorr.patch"
	${git} "${DIR}/patches/omap_fixes/0004-ARM-OMAP4-hwmod-Don-t-wait-for-the-idle-status-if-mo.patch"
	${git} "${DIR}/patches/omap_fixes/0005-ARM-OMAP4-clock-Add-CPU-local-timer-clock-node.patch"
	${git} "${DIR}/patches/omap_fixes/0006-ARM-OMAP3-hwmod-data-disable-multiblock-reads-on-MMC.patch"
	${git} "${DIR}/patches/omap_fixes/0007-OMAP-HWMOD-add-es3plus-to-am36xx-am35xx.patch"
}

led () {
	echo "led fixes"
	${git} "${DIR}/patches/led/0001-leds-heartbeat-stop-on-shutdown-reboot-or-panic.patch"
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

#with v3.0-git16
#drivers/staging/omap3-sgx/services4/3rdparty/dc_omapfb3_linux/omaplfb_linux.c:324:15: error: ‘OMAP_DSS_UPDATE_AUTO’ undeclared (first use in this function)
#drivers/staging/omap3-sgx/services4/3rdparty/dc_omapfb3_linux/omaplfb_linux.c:327:15: error: ‘OMAP_DSS_UPDATE_MANUAL’ undeclared (first use in this function)
#drivers/staging/omap3-sgx/services4/3rdparty/dc_omapfb3_linux/omaplfb_linux.c:330:15: error: ‘OMAP_DSS_UPDATE_DISABLED’ undeclared (first use in this function)
#drivers/staging/omap3-sgx/services4/3rdparty/dc_omapfb3_linux/omaplfb_linux.c:337:16: error: ‘struct omap_dss_driver’ has no member named ‘set_update_mode’
#drivers/staging/omap3-sgx/services4/3rdparty/dc_omapfb3_linux/omaplfb_linux.c:312:28: warning: unused variable ‘eDSSMode’
#make[4]: *** [drivers/staging/omap3-sgx/services4/3rdparty/dc_omapfb3_linux/omaplfb_linux.o] Error 1
#make[3]: *** [drivers/staging/omap3-sgx/services4/3rdparty/dc_omapfb3_linux] Error 2
#make[2]: *** [drivers/staging/omap3-sgx] Error 2
#for <3.2
#patch -s -p1 < "${DIR}/patches/sgx/0001-Revert-OMAP-DSS2-remove-update_mode-from-omapdss.patch"
#for >3.2
patch -s -p1 < "${DIR}/patches/sgx/0001-Revert-OMAP-DSS2-remove-update_mode-from-omapdss-v3.2.patch"

}

distro
omap_cpufreq
micrel_zippy2
sakoman
beagle
devkit8000
igep0020
touchbook
panda
omap_fixes
led

#dont push
sgx

echo "patch.sh ran successful"

