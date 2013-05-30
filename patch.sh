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
#git="git am --whitespace=fix"

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

cleanup () {
	git format-patch -${number} -o ${DIR}/patches/
	exit
}

distro () {
	echo "Distro Specific Patches"
	${git} "${DIR}/patches/distro/0001-kbuild-deb-pkg-set-host-machine-after-dpkg-gencontro.patch"
}

sakoman () {
	echo "Patches from: Sakoman git tree"
	${git} "${DIR}/patches/sakoman/0001-OMAP-DSS2-add-bootarg-for-selecting-svideo.patch"
	${git} "${DIR}/patches/sakoman/0002-video-add-timings-for-hd720.patch"
	${git} "${DIR}/patches/sakoman/0003-omap-mmc-Adjust-dto-to-eliminate-timeout-errors.patch"
}

beagle () {
	echo "Board Patches for: BeagleBoard"

	${git} "${DIR}/patches/beagle/expansion/0001-Beagle-expansion-add-buddy-param-for-expansionboard-.patch"
	${git} "${DIR}/patches/beagle/expansion/0002-Beagle-expansion-add-zippy.patch"
	${git} "${DIR}/patches/beagle/expansion/0003-Beagle-expansion-add-zippy2.patch"
	${git} "${DIR}/patches/beagle/expansion/0004-Beagle-expansion-add-trainer.patch"
	${git} "${DIR}/patches/beagle/expansion/0005-Beagle-expansion-add-CircuitCo-ulcd-Support.patch"
	${git} "${DIR}/patches/beagle/expansion/0006-Beagle-expansion-add-wifi.patch"
	${git} "${DIR}/patches/beagle/expansion/0007-Beagle-expansion-add-beaglefpga.patch"
	${git} "${DIR}/patches/beagle/expansion/0008-Enable-buddy-spidev.patch"

	${git} "${DIR}/patches/beagle/0001-beagleboard-reinstate-usage-of-hi-speed-PLL-divider.patch"
	${git} "${DIR}/patches/beagle/0002-Turn-on-the-USB-regulator-on-Beagle-xM-explicitly.patch"
	${git} "${DIR}/patches/beagle/0003-meego-modedb-add-Toshiba-LTA070B220F-800x480-support.patch"
	${git} "${DIR}/patches/beagle/0004-default-to-fifo-mode-5-for-old-musb-beagles.patch"
	${git} "${DIR}/patches/beagle/0005-omap3_beagle-init-uart2-for-beagle-rev-AX-BX-only.patch"

	${git} "${DIR}/patches/beagle/0006-backlight-Add-TLC59108-backlight-control-driver.patch"
	${git} "${DIR}/patches/beagle/0007-tlc59108-adjust-for-beagleboard-uLCD7.patch"
	${git} "${DIR}/patches/beagle/0008-zeroMAP-Open-your-eyes.patch"
}

devkit8000 () {
	echo "Board Patches for: devkit8000"
	${git} "${DIR}/patches/devkit8000/0001-arm-omap-devkit8000-for-lcd-use-samsung_lte_panel-2.6.37-git10.patch"
}

panda () {
	echo "Board Patches for: PandaBoard"
	${git} "${DIR}/patches/panda/0001-panda-fix-wl12xx-regulator.patch"
	${git} "${DIR}/patches/panda/0002-panda-enable-bluetooth.patch"
	${git} "${DIR}/patches/panda/0003-ti-st-st-kim-fixing-firmware-path.patch"
}

omap_fixes () {
	echo "omap cherry pick fixes"
	${git} "${DIR}/patches/omap_fixes/0001-omap3-Increase-limit-on-bootarg-mpurate.patch"
	${git} "${DIR}/patches/omap_fixes/0002-OMAP2-UART-Remove-cpu-checks-for-populating-errata-f.patch"
	${git} "${DIR}/patches/omap_fixes/0003-OMAP2-UART-enable-tx-wakeup-bit-for-wer-reg.patch"
	${git} "${DIR}/patches/omap_fixes/0004-OMAP2-UART-replace-omap34xx-omap4xx-cpu-checks-with-.patch"
	#in 3.4.9
	#git am "${DIR}/patches/omap_fixes/0005-Unconditional-call-to-smp_cross_call-on-UP-crashes.patch"
}

omapdrm () {
	echo "omap testing omapdrm/kms"

	echo "Patches for 3.4-rc1-cma-v24"
	#git://git.linaro.org/people/mszyprowski/linux-dma-mapping.git 3.4-rc1-cma-v24
	${git} "${DIR}/patches/drm/cma/0001-mm-page_alloc-remove-trailing-whitespace.patch"
	${git} "${DIR}/patches/drm/cma/0002-mm-compaction-introduce-isolate_migratepages_range.patch"
	${git} "${DIR}/patches/drm/cma/0003-mm-compaction-introduce-map_pages.patch"
	${git} "${DIR}/patches/drm/cma/0004-mm-compaction-introduce-isolate_freepages_range.patch"
	${git} "${DIR}/patches/drm/cma/0005-mm-compaction-export-some-of-the-functions.patch"
	${git} "${DIR}/patches/drm/cma/0006-mm-page_alloc-introduce-alloc_contig_range.patch"
	${git} "${DIR}/patches/drm/cma/0007-mm-page_alloc-change-fallbacks-array-handling.patch"
	${git} "${DIR}/patches/drm/cma/0008-mm-mmzone-MIGRATE_CMA-migration-type-added.patch"
	${git} "${DIR}/patches/drm/cma/0009-mm-page_isolation-MIGRATE_CMA-isolation-functions-ad.patch"
	${git} "${DIR}/patches/drm/cma/0010-mm-Serialize-access-to-min_free_kbytes.patch"
	${git} "${DIR}/patches/drm/cma/0011-mm-extract-reclaim-code-from-__alloc_pages_direct_re.patch"
	${git} "${DIR}/patches/drm/cma/0012-mm-trigger-page-reclaim-in-alloc_contig_range-to-sta.patch"
	${git} "${DIR}/patches/drm/cma/0013-drivers-add-Contiguous-Memory-Allocator.patch"
	${git} "${DIR}/patches/drm/cma/0014-X86-integrate-CMA-with-DMA-mapping-subsystem.patch"
	${git} "${DIR}/patches/drm/cma/0015-ARM-integrate-CMA-with-DMA-mapping-subsystem.patch"

	#posted: 13 Mar 2012 for 3.4
	${git} "${DIR}/patches/drm/0001-omap2-add-drm-device.patch"

	#might be merged in 3.4
	${git} "${DIR}/patches/drm/0002-ARM-OMAP2-3-HWMOD-Add-missing-flags-for-dispc-class.patch"
	${git} "${DIR}/patches/drm/0003-ARM-OMAP2-3-HWMOD-Add-missing-flag-for-rfbi-class.patch"
	${git} "${DIR}/patches/drm/0004-ARM-OMAP3-HWMOD-Add-omap_hwmod_class_sysconfig-for-d.patch"
}

dsp () {
	echo "dsp patches"
	${git} "${DIR}/patches/dsp/0001-OMAP2-control-new-APIs-to-configure-boot-address-and.patch"
	${git} "${DIR}/patches/dsp/0002-OMAP-dsp-interface-to-control-module-functions.patch"
	${git} "${DIR}/patches/dsp/0003-staging-tidspbridge-use-scm-functions-to-set-boot-ad.patch"
}

sgx_mainline () {
	echo "patches needed for external sgx bins"
	${git} "${DIR}/patches/sgx/0001-Revert-drm-kill-drm_sman.patch"
}

led () {
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
sakoman
beagle
devkit8000
panda
omap_fixes
omapdrm
dsp
sgx_mainline
led
#sgx

echo "patch.sh ran successful"

