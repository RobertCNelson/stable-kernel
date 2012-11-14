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

git="git am"
#git="git am --whitespace=fix"

if [ -f ${DIR}/system.sh ] ; then
	source ${DIR}/system.sh
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

	#note: had to revert a few omap3isp patches to make this work...
	${git} "${DIR}/patches/beagle/expansion/0009-Beagle-Camera-add-MT9P031-Aptina-image-sensor-driver.patch"

	#v3.5: looks to be removed: (might want to revert it back in...)
	#http://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=commit;h=b6e695abe710ee1ae248463d325169efac487e17
	#git am "${DIR}/patches/beagle/0001-beagleboard-reinstate-usage-of-hi-speed-PLL-divider.patch"

	#Status: for meego guys..
	${git} "${DIR}/patches/beagle/0001-meego-modedb-add-Toshiba-LTA070B220F-800x480-support.patch"

	${git} "${DIR}/patches/beagle/0002-backlight-Add-TLC59108-backlight-control-driver.patch"
	${git} "${DIR}/patches/beagle/0003-tlc59108-adjust-for-beagleboard-uLCD7.patch"

	#Status: not for upstream
	${git} "${DIR}/patches/beagle/0004-zeroMAP-Open-your-eyes.patch"

	${git} "${DIR}/patches/beagle/0005-OMAP3-USB-EHCI-fix.patch"

	#cpufreq: only 800Mhz seems to cause hard lock... disable for now..
	${git} "${DIR}/patches/beagle/0006-TEMP-Beagle-xM-cpufreq-disable-800Mhz-opp.patch"
}

sprz319_erratum () {
	echo "sprz319 erratum 2.1"
	#Breaks: Beagle C4, hardlocks on bootup...
	#Status: no response from users:
	#https://groups.google.com/forum/#!topic/beagleboard/m7DLkYMKNkg
	${git} "${DIR}/patches/sprz319-erratum-2.1/0001-Fix-sprz319-erratum-2.1.patch"
}

panda () {
	echo "Board Patches for: PandaBoard"
	#Status: not for upstream: push device tree version upstream...
	${git} "${DIR}/patches/panda/0001-panda-fix-wl12xx-regulator.patch"
	#Status: unknown: cherry picked from linaro
	${git} "${DIR}/patches/panda/0002-ti-st-st-kim-fixing-firmware-path.patch"
	#Status: from v3.6-rc
	${git} "${DIR}/patches/panda/0003-staging-OMAP4-thermal-introduce-bandgap-temperature-.patch"
	${git} "${DIR}/patches/panda/0004-staging-omap-thermal-common-code-to-expose-driver-to.patch"
	${git} "${DIR}/patches/panda/0005-staging-omap-thermal-add-OMAP4-data-structures.patch"

	#Status: https://lkml.org/lkml/2012/9/11/303
	${git} "${DIR}/patches/panda/0006-staging-omap-thermal-Correct-checkpatch.pl-warnings.patch"
	${git} "${DIR}/patches/panda/0007-staging-omap-thermal-remove-checkpatch.pl-warnings-o.patch"
	${git} "${DIR}/patches/panda/0008-staging-omap-thermal-fix-polling-period-settings.patch"
	${git} "${DIR}/patches/panda/0009-staging-omap-thermal-improve-conf-data-handling-and-.patch"
}

omap_fixes () {
	echo "omap cherry pick fixes"
	#Status: unknown: only needed when forcing mpurate over 999 using bootargs...
	${git} "${DIR}/patches/omap_fixes/0001-omap3-Increase-limit-on-bootarg-mpurate.patch"
	#Status: unknown: seem to be dropped after v3.4-rc-fixes request
	${git} "${DIR}/patches/omap_fixes/0002-OMAP2-UART-enable-tx-wakeup-bit-for-wer-reg.patch"
	${git} "${DIR}/patches/omap_fixes/0003-OMAP2-UART-replace-omap34xx-omap4xx-cpu-checks-with-.patch"
}

drm () {
	echo "omap testing omapdrm/kms"
	#posted: 13 Mar 2012 for 3.4
	${git} "${DIR}/patches/drm/0001-omap2-add-drm-device.patch"
}

sgx () {
	echo "patches needed for external sgx bins"
	#Status: TI 4.06.00.xx needs this
	${git} "${DIR}/patches/sgx/0001-Revert-drm-kill-drm_sman.patch"
}

mainline_fixes () {
	echo "mainline patches"
	#Status: v2 Review:
	#http://lists.infradead.org/pipermail/linux-arm-kernel/2012-August/112440.html
	${git} "${DIR}/patches/mainline-fixes/0001-arm-add-definition-of-strstr-to-decompress.c.patch"
	#Status:
	#http://git.kernel.org/?p=linux/kernel/git/tmlind/linux-omap.git;a=shortlog;h=refs/heads/devel-dt
	${git} "${DIR}/patches/mainline-fixes/0002-ARM-omap-add-dtb-targets.patch"
}

cpuidle () {
	echo "cpuidle"
	${git} "${DIR}/patches/cpuidle/0001-cpuidle-remove-unused-hrtimer_peek_ahead_timers-call.patch"
	${git} "${DIR}/patches/cpuidle/0002-cpuidle-add-checks-to-avoid-NULL-pointer-dereference.patch"
	${git} "${DIR}/patches/cpuidle/0003-cpuidle-refactor-out-cpuidle_enter_state.patch"
	${git} "${DIR}/patches/cpuidle/0004-cpuidle-fix-error-handling-in-__cpuidle_register_dev.patch"
	${git} "${DIR}/patches/cpuidle/0005-cpuidle-add-support-for-states-that-affect-multiple-.patch"
	${git} "${DIR}/patches/cpuidle/0006-cpuidle-coupled-add-parallel-barrier-function.patch"
	${git} "${DIR}/patches/cpuidle/0007-cpuidle-move-field-disable-from-per-driver-to-per-cp.patch"
	${git} "${DIR}/patches/cpuidle/0008-PM-cpuidle-Add-driver-reference-counter.patch"
	${git} "${DIR}/patches/cpuidle/0009-PM-Domains-Add-preliminary-support-for-cpuidle-v2.patch"
	${git} "${DIR}/patches/cpuidle/0010-PM-cpuidle-System-resume-hang-fix-with-cpuidle.patch"
	${git} "${DIR}/patches/cpuidle/0011-cpuidle-coupled-fix-sleeping-while-atomic-in-cpu-not.patch"
	${git} "${DIR}/patches/cpuidle/0012-cpuidle-Prevent-null-pointer-dereference-in-cpuidle_.patch"
}

cpuidle_omap () {
	echo "cpuidle_omap"
	${git} "${DIR}/patches/cpuidle_omap/0001-ARM-OMAP-timer-allow-gp-timer-clock-event-to-be-used.patch"
	${git} "${DIR}/patches/cpuidle_omap/0002-ARM-OMAP4-CPUidle-Use-coupled-cpuidle-states-to-impl.patch"
	${git} "${DIR}/patches/cpuidle_omap/0003-ARM-OMAP4-CPUidle-add-synchronization-for-coupled-id.patch"
	${git} "${DIR}/patches/cpuidle_omap/0004-ARM-OMAP4-CPUidle-Open-broadcast-clock-event-device.patch"
	${git} "${DIR}/patches/cpuidle_omap/0005-ARM-OMAP4-sleep-Save-the-complete-used-register-stac.patch"
	${git} "${DIR}/patches/cpuidle_omap/0006-cpufreq-OMAP-Handle-missing-frequency-table-on-SMP-s.patch"
	${git} "${DIR}/patches/cpuidle_omap/0007-ARM-OMAP4-Register-the-OPP-table-only-for-4430-devic.patch"
}

omap3isp () {
	#omap3isp: Revert to v3.4.x, till we figure out, how to actually set the 'pixel rate control'
	#"no pixel rate control in subdev %s\n","
	${git} "${DIR}/patches/omap3isp/0001-Revert-media-omap3isp-Move-CCDC-link-validation-to-c.patch"
	${git} "${DIR}/patches/omap3isp/0002-Revert-media-omap3isp-Default-link-validation-for-cc.patch"
	${git} "${DIR}/patches/omap3isp/0003-Revert-media-omap3isp-Use-external-rate-instead-of-v.patch"
	${git} "${DIR}/patches/omap3isp/0004-Revert-media-omap3isp-Introduce-isp_video_check_exte.patch"
}

distro
sakoman
beagle

#disabled as it breaks beagle c4...
#sprz319_erratum

panda
omap_fixes
drm
sgx
mainline_fixes

cpuidle
cpuidle_omap

omap3isp

echo "patch.sh ran successful"

