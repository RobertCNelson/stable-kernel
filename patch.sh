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

bugs_trivial () {
	echo "bugs and trivial stuff"
	${git} "${DIR}/patches/trivial/0001-kbuild-deb-pkg-set-host-machine-after-dpkg-gencontro.patch"
}

beagle () {
	echo "Board Patches for: BeagleBoard"

	${git} "${DIR}/patches/beagle/expansion/0001-expansion-add-buddy-param-for-expansionboard-names.patch"
	${git} "${DIR}/patches/beagle/expansion/0002-expansion-add-mmc-regulator-and-ds1307-rtc.patch"
	${git} "${DIR}/patches/beagle/expansion/0003-expansion-add-zippy.patch"
	${git} "${DIR}/patches/beagle/expansion/0004-expansion-add-zippy2.patch"
	${git} "${DIR}/patches/beagle/expansion/0005-expansion-add-trainer.patch"
	${git} "${DIR}/patches/beagle/expansion/0006-expansion-add-ulcd.patch"

	${git} "${DIR}/patches/beagle/0001-beagleboard-reinstate-usage-of-hi-speed-PLL-divider.patch"
	${git} "${DIR}/patches/beagle/0001-Turn-on-the-USB-regulator-on-Beagle-xM-explicitly-wh.patch"
	${git} "${DIR}/patches/beagle/0001-ARM-OMAP3-clock-data-fill-in-some-missing-clockdomai.patch"
	${git} "${DIR}/patches/beagle/0001-ARM-OMAP3-USB-Fix-the-EHCI-ULPI-PHY-reset-issue.patch"

	${git} "${DIR}/patches/beagle/expansion/0001-beagle-resync-all-board-changes.patch"

	${git} "${DIR}/patches/beagle/0001-omap3_beagle-init-uart2-for-beagle-rev-AX-BX-only.patch"

	${git} "${DIR}/patches/beagle/0001-meego-modedb-add-Toshiba-LTA070B220F-800x480-support.patch"
	${git} "${DIR}/patches/beagle/0001-default-to-fifo-mode-5-for-old-musb-beagles.patch"

	${git} "${DIR}/patches/omap/0001-omap3-Increase-limit-on-bootarg-mpurate.patch"

	${git} "${DIR}/patches/beagle/0001-ASoC-omap-add-MODULE_ALIAS-to-mcbsp-and-pcm-drivers.patch"
	${git} "${DIR}/patches/beagle/0001-ASoC-omap-convert-per-board-modules-to-platform-driv.patch"

	${git} "${DIR}/patches/sakoman/2.6.39/0006-OMAP-DSS2-add-bootarg-for-selecting-svideo-or-compos.patch"
	${git} "${DIR}/patches/sakoman/2.6.39/0007-video-add-timings-for-hd720.patch"
	${git} "${DIR}/patches/sakoman/2.6.39/0025-omap-mmc-Adjust-dto-to-eliminate-timeout-errors.patch"

	${git} "${DIR}/patches/beagle/expansion/0007-Beagle-Camera-add-MT9P031-Aptina-image-sensor.patch"

#	${git} "${DIR}/patches/omap/0001-Fix-sprz319-erratum-2.1.patch"
}

pandaboard () {
	echo "Board Patches for: PandaBoard"
	${git} "${DIR}/patches/panda/0001-panda-fix-wl12xx-regulator.patch"
	${git} "${DIR}/patches/panda/0001-panda-enable-bluetooth.patch"
	${git} "${DIR}/patches/panda/0001-ti-st-st-kim-fixing-firmware-path.patch"
}

fixes () {
	echo "omap cherry pick fixes"
	#3/22/2012: replaces: 0001-OMAP-UART-Enable-tx-wakeup-bit-in-wer.patch
	${git} "${DIR}/patches/omap/0001-OMAP2-UART-Remove-cpu-checks-for-populating-errata-f.patch"
	${git} "${DIR}/patches/omap/0002-OMAP2-UART-enable-tx-wakeup-bit-for-wer-reg.patch"
	${git} "${DIR}/patches/omap/0003-OMAP2-UART-replace-omap34xx-omap4xx-cpu-checks-with-.patch"

	#3/22/2012: suspend testing:
	#http://www.spinics.net/lists/linux-omap/msg67070.html
	${git} "${DIR}/patches/omap/0001-mmc-omap_hsmmc-Pass-on-the-suspend-failure-to-the-PM.patch"

	#merged in 3.4-rc0
	#http://git.kernel.org/?p=linux/kernel/git/khilman/linux-omap-pm.git;a=shortlog;h=refs/heads/for_3.4/cpufreq
	${git} "${DIR}/patches/omap-3.4/0001-cpufreq-OMAP-driver-depends-CPUfreq-tables.patch"
	${git} "${DIR}/patches/omap-3.4/0002-cpufreq-OMAP-scale-voltage-along-with-frequency.patch"
	${git} "${DIR}/patches/omap-3.4/0003-cpufreq-OMAP-specify-range-for-voltage-scaling.patch"

	#http://git.kernel.org/?p=linux/kernel/git/khilman/linux-omap-pm.git;a=shortlog;h=refs/heads/for_3.4/fixes/pm
	${git} "${DIR}/patches/omap-3.4/0001-ARM-OMAP4-Workaround-the-OCP-synchronisation-issue-w.patch"
	${git} "${DIR}/patches/omap-3.4/0002-arm-omap3-pm34xx.c-Fix-omap3_pm_init-error-out-paths.patch"
	${git} "${DIR}/patches/omap-3.4/0003-arm-omap3-pm34xx.c-Replace-printk-with-appropriate-p.patch"
	${git} "${DIR}/patches/omap-3.4/0004-ARM-OMAP2-OPP-allow-OPP-enumeration-to-continue-if-d.patch"
	${git} "${DIR}/patches/omap-3.4/0005-ARM-OMAP3-fix-oops-triggered-in-omap_prcm_register_c.patch"

}

bugs_trivial

beagle
pandaboard

fixes

echo "patch.sh ran successful"

