#!/bin/bash
# Split out, so build_kernel.sh and build_deb.sh can share..

echo "Starting patch.sh"

function bugs_trivial {
echo "bugs and trivial stuff"

#Bisected from 2.6.35 -> 2.6.36 to find this..
#This commit breaks some lcd monitors..
#rcn-ee Feb 26, 2011...
#Still needs more work for 2.6.38, causes:
#[   14.962829] omapdss DISPC error: GFX_FIFO_UNDERFLOW, disabling GFX
patch -s -p1 < "${DIR}/patches/trivial/0001-Revert-OMAP-DSS2-OMAPFB-swap-front-and-back-porches-.patch"

patch -s -p1 < "${DIR}/patches/trivial/0001-kbuild-deb-pkg-set-host-machine-after-dpkg-gencontro.patch"

#should fix gcc-4.6 ehci problems..
patch -s -p1 < "${DIR}/patches/trivial/0001-USB-ehci-use-packed-aligned-4-instead-of-removing-th.patch"

}

function cpufreq {
echo "[git] omap-cpufreq"
#git pull git://github.com/RobertCNelson/linux.git omap_cpufreq_v3.1-rc8

patch -s -p1 < "${DIR}/patches/git-rcn/0035-cpufreq-OMAP-cleanup-for-multi-SoC-support-move-into.patch"
patch -s -p1 < "${DIR}/patches/git-rcn/0036-cpufreq-OMAP-Add-SMP-support-for-OMAP4.patch"
patch -s -p1 < "${DIR}/patches/git-rcn/0037-cpufreq-OMAP-Enable-all-CPUs-in-shared-policy-mask.patch"
patch -s -p1 < "${DIR}/patches/git-rcn/0038-cpufreq-OMAP-notify-even-with-bad-boot-frequency.patch"
patch -s -p1 < "${DIR}/patches/git-rcn/0039-cpufreq-OMAP-move-clk-name-decision-to-init.patch"
patch -s -p1 < "${DIR}/patches/git-rcn/0040-cpufreq-OMAP-deny-initialization-if-no-mpudev.patch"
patch -s -p1 < "${DIR}/patches/git-rcn/0041-cpufreq-OMAP-dont-support-freq_table.patch"
patch -s -p1 < "${DIR}/patches/git-rcn/0042-cpufreq-OMAP-only-supports-OPP-library.patch"
patch -s -p1 < "${DIR}/patches/git-rcn/0043-cpufreq-OMAP-put-clk-if-cpu_init-failed.patch"
patch -s -p1 < "${DIR}/patches/git-rcn/0044-cpufreq-OMAP-fix-freq_table-leak.patch"

}

function dss2_next {
echo "dss2 from for-next"

}

function dspbridge_next {
echo "dspbridge from for-next"

}

function omap_fixes {
echo "omap fixes"

}

function for_next {
echo "for_next from tmlind's tree.."

}

function sakoman {
echo "sakoman's patches"

patch -s -p1 < "${DIR}/patches/sakoman/2.6.39/0006-OMAP-DSS2-add-bootarg-for-selecting-svideo-or-compos.patch"
patch -s -p1 < "${DIR}/patches/sakoman/2.6.39/0007-video-add-timings-for-hd720.patch"

patch -s -p1 < "${DIR}/patches/sakoman/2.6.39/0025-omap-mmc-Adjust-dto-to-eliminate-timeout-errors.patch"
patch -s -p1 < "${DIR}/patches/sakoman/2.6.39/0026-OMAP-Overo-Add-support-for-spidev.patch"

}

function musb {
echo "musb patches"
patch -s -p1 < "${DIR}/patches/musb/0001-default-to-fifo-mode-5-for-old-musb-beagles.patch"
}

function micrel {
echo "[git] Micrel KZ8851 patches for: zippy2"
#original from:
#ftp://www.micrel.com/ethernet/8851/beagle_zippy_patches.tar.gz 137 KB 04/10/2010 12:26:00 AM

#git pull git://github.com/RobertCNelson/linux.git micrel_ks8851_v3.1-rc8

patch -s -p1 < "${DIR}/patches/git-rcn/0016-ksz8851-eeprom-93cx6-add-drive_data.patch"
patch -s -p1 < "${DIR}/patches/git-rcn/0017-ksz8851-eeprom-93cx6-add-eeprom_93cx6_write.patch"
patch -s -p1 < "${DIR}/patches/git-rcn/0018-ksz8851-read_mac_addr.patch"
patch -s -p1 < "${DIR}/patches/git-rcn/0019-ksz8851-93cx6-eeprom-access.patch"
patch -s -p1 < "${DIR}/patches/git-rcn/0020-ksz8851-move-to-header.patch"
patch -s -p1 < "${DIR}/patches/git-rcn/0021-ksz8851-move-more-to-header.patch"
patch -s -p1 < "${DIR}/patches/git-rcn/0022-ksz8851-share-ks8851_tx_hdr-union.patch"
patch -s -p1 < "${DIR}/patches/git-rcn/0023-ksz8851-add-is_level_irq.patch"
patch -s -p1 < "${DIR}/patches/git-rcn/0024-ksz8851-turn-off-hardware-interrupt-druing-receive-p.patch"
patch -s -p1 < "${DIR}/patches/git-rcn/0025-ksz8851-make-sure-is-awake-before-writing-mac.patch"
patch -s -p1 < "${DIR}/patches/git-rcn/0026-ksz8851-add-mutex-lock-unlock-to-ks.patch"
patch -s -p1 < "${DIR}/patches/git-rcn/0027-ksz8851-add-ks8851_tx_check.patch"
patch -s -p1 < "${DIR}/patches/git-rcn/0028-ksz8851-move-ks8851_set_powermode.patch"
patch -s -p1 < "${DIR}/patches/git-rcn/0029-ks8851.h-it-helps-to-include-the-include-file.patch"

}

function beagle {
echo "[git] Board Patches for: BeagleBoard"

#git pull git://github.com/RobertCNelson/linux.git omap_beagle_expansion_v3.1-rc9

patch -s -p1 < "${DIR}/patches/git-rcn/0030-expansion-add-buddy-param-for-expansionboard-names.patch"
patch -s -p1 < "${DIR}/patches/git-rcn/0031-expansion-add-mmc-regulator-and-ds1307-rtc.patch"
patch -s -p1 < "${DIR}/patches/git-rcn/0032-expansion-add-zippy.patch"
patch -s -p1 < "${DIR}/patches/git-rcn/0033-expansion-add-zippy2.patch"
patch -s -p1 < "${DIR}/patches/git-rcn/0034-expansion-add-trainer.patch"

patch -s -p1 < "${DIR}/patches/arago-project/0001-omap3-Increase-limit-on-bootarg-mpurate.patch"
patch -s -p1 < "${DIR}/patches/display/0001-meego-modedb-add-Toshiba-LTA070B220F-800x480-support.patch"

}

function igepv2 {
echo "[git] Board Patches for: igepv2"
#pulled from: http://git.igep.es/?p=pub/scm/linux-omap-2.6.git;a=summary
#git pull git://git.igep.es/pub/scm/linux-omap-2.6.git master

#git pull git://github.com/RobertCNelson/linux.git omap_igepv_v3.1-rc7

patch -s -p1 < "${DIR}/patches/git-rcn/0001-OMAP3-igep00x0-Introduce-common-functions-for-IGEP-b.patch"
patch -s -p1 < "${DIR}/patches/git-rcn/0002-OMAP3-igep0020-Remove-IGEP0030-support-from-board-ig.patch"
patch -s -p1 < "${DIR}/patches/git-rcn/0003-OMAP3-igep0020-Update-get-hardware-revision-function.patch"
patch -s -p1 < "${DIR}/patches/git-rcn/0004-OMAP3-igep0020-Use-common-flash-initialitzation-func.patch"
patch -s -p1 < "${DIR}/patches/git-rcn/0005-OMAP3-igep0020-Use-common-smsc911x-initialitzation-f.patch"
patch -s -p1 < "${DIR}/patches/git-rcn/0006-OMAP3-igep0020-Reduce-the-amount-of-code-for-gpio-le.patch"
patch -s -p1 < "${DIR}/patches/git-rcn/0007-OMAP3-igep0020-Use-common-wifi_bt-initialitzation-fu.patch"
patch -s -p1 < "${DIR}/patches/git-rcn/0008-OMAP3-igep0020-Use-common-twl4030-initialitzation-fu.patch"
patch -s -p1 < "${DIR}/patches/git-rcn/0009-OMAP3-igep0020-Use-common-display-initialitzation-fu.patch"
patch -s -p1 < "${DIR}/patches/git-rcn/0010-OMAP3-igep0020-Ensure-pins-are-mux-d.patch"
patch -s -p1 < "${DIR}/patches/git-rcn/0011-OMAP3-igep0020-Add-board.ei485-early-parameter.patch"
patch -s -p1 < "${DIR}/patches/git-rcn/0012-OMAP3-igep0020-Add-IGEP0022-expansion-board-support.patch"
patch -s -p1 < "${DIR}/patches/git-rcn/0013-OMAP3-igep0020-Fix-double-registration-of-omapdss-de.patch"
patch -s -p1 < "${DIR}/patches/git-rcn/0014-OMAP3-igep0020-Fix-mux-when-using-board.ei485-kernel.patch"
patch -s -p1 < "${DIR}/patches/git-rcn/0015-board-igeo00x0-fix-igep00x0_tsc2046_init.patch"

#Misha Manulis reply+i-2124203-89b49457cbc2980b8763661d...@reply.github.com
#
#When I'm compiling, I get the following error:
#  arch/arm/mach-omap2/board-igep00x0.c:488:13: error: conflicting types for ‘igep00x0_wifi_bt_init’
#The fix is to patch __KERNEL/arch/arm/mach-omap2/board-igep00x0.c:488__ to replace that line with the following:
#   void igep00x0_wifi_bt_init(int npd, int wifi_nreset, int bt_nreset, int bt_enable) { }

patch -s -p1 < "${DIR}/patches/trivial/0001-ARM-OMAP-igep00x0-fix-build-of-igep00x0_wifi_bt_init.patch"

}

function devkit8000 {
echo "devkit8000"
patch -s -p1 < "${DIR}/patches/devkit8000/0001-arm-omap-devkit8000-for-lcd-use-samsung_lte_panel-2.6.37-git10.patch"
}

function touchbook {
echo "touchbook patches"
patch -s -p1 < "${DIR}/patches/touchbook/0001-omap3-touchbook-remove-mmc-gpio_wp.patch"
patch -s -p1 < "${DIR}/patches/touchbook/0002-omap3-touchbook-drop-u-boot-readonly.patch"
#patch -s -p1 < "${DIR}/patches/touchbook/0001-touchbook-add-madc.patch"
#patch -s -p1 < "${DIR}/patches/touchbook/0002-touchbook-add-twl4030-bci-battery.patch"
}

function dspbridge {
echo "dspbridge fixes"

}

function omap4 {
echo "omap4 related patches"
#drop with 3.0-git16
#patch -s -p1 < "${DIR}/patches/panda/0001-OMAP4-DSS2-add-dss_dss_clk.patch"
patch -s -p1 < "${DIR}/patches/panda/0001-panda-fix-wl12xx-regulator.patch"
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

#with v3.0-git16
#drivers/staging/omap3-sgx/services4/3rdparty/dc_omapfb3_linux/omaplfb_linux.c:324:15: error: ‘OMAP_DSS_UPDATE_AUTO’ undeclared (first use in this function)
#drivers/staging/omap3-sgx/services4/3rdparty/dc_omapfb3_linux/omaplfb_linux.c:327:15: error: ‘OMAP_DSS_UPDATE_MANUAL’ undeclared (first use in this function)
#drivers/staging/omap3-sgx/services4/3rdparty/dc_omapfb3_linux/omaplfb_linux.c:330:15: error: ‘OMAP_DSS_UPDATE_DISABLED’ undeclared (first use in this function)
#drivers/staging/omap3-sgx/services4/3rdparty/dc_omapfb3_linux/omaplfb_linux.c:337:16: error: ‘struct omap_dss_driver’ has no member named ‘set_update_mode’
#drivers/staging/omap3-sgx/services4/3rdparty/dc_omapfb3_linux/omaplfb_linux.c:312:28: warning: unused variable ‘eDSSMode’
#make[4]: *** [drivers/staging/omap3-sgx/services4/3rdparty/dc_omapfb3_linux/omaplfb_linux.o] Error 1
#make[3]: *** [drivers/staging/omap3-sgx/services4/3rdparty/dc_omapfb3_linux] Error 2
#make[2]: *** [drivers/staging/omap3-sgx] Error 2
patch -s -p1 < "${DIR}/patches/sgx/0001-Revert-OMAP-DSS2-remove-update_mode-from-omapdss.patch"

}

bugs_trivial

#patches in git
cpufreq
igepv2
micrel
beagle

#for_next tree's
dss2_next
omap_fixes
#dspbridge_next
for_next

#work in progress
#

#external tree's
sakoman
musb

#random board patches
devkit8000
touchbook

#omap4/dvfs still needs more testing..
omap4

#no chance of being pushed ever tree's
sgx

echo "patch.sh ran successful"

