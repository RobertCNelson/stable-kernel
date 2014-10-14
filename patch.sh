#!/bin/sh
#
# Copyright (c) 2009-2014 Robert Nelson <robertcnelson@gmail.com>
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

. ${DIR}/version.sh
if [ -f ${DIR}/system.sh ] ; then
	. ${DIR}/system.sh
fi

git="git am"
#git_patchset=""
#git_opts

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

external_git () {
	git_tag=""
	echo "pulling: ${git_tag}"
	git pull ${git_opts} ${git_patchset} ${git_tag}
}

local_patch () {
	echo "dir: dir"
	${git} "${DIR}/patches/dir/0001-patch.patch"
}

#external_git
#local_patch

edma () {
	echo "dir: edma"
#	${git} "${DIR}/patches/edma/0001-arm-davinci-fix-edma-dmaengine-induced-null-pointer-.patch"
	${git} "${DIR}/patches/edma/0002-ARM-davinci-move-private-EDMA-API-to-arm-common.patch"
	${git} "${DIR}/patches/edma/0003-ARM-edma-remove-unused-transfer-controller-handlers.patch"
	${git} "${DIR}/patches/edma/0004-ARM-edma-add-AM33XX-support-to-the-private-EDMA-API.patch"
	${git} "${DIR}/patches/edma/0005-dmaengine-edma-enable-build-for-AM33XX.patch"
	${git} "${DIR}/patches/edma/0006-dmaengine-edma-Add-TI-EDMA-device-tree-binding.patch"
	${git} "${DIR}/patches/edma/0007-ARM-dts-add-AM33XX-EDMA-support.patch"
	${git} "${DIR}/patches/edma/0008-spi-omap2-mcspi-convert-to-dma_request_slave_channel.patch"
	${git} "${DIR}/patches/edma/0009-spi-omap2-mcspi-add-generic-DMA-request-support-to-t.patch"
	${git} "${DIR}/patches/edma/0010-ARM-dts-add-AM33XX-SPI-DMA-support.patch"
	${git} "${DIR}/patches/edma/0011-mmc-omap_hsmmc-convert-to-dma_request_slave_channel_.patch"
	${git} "${DIR}/patches/edma/0012-mmc-omap_hsmmc-add-generic-DMA-request-support-to-th.patch"
	${git} "${DIR}/patches/edma/0013-dmaengine-add-dma_get_slave_sg_limits.patch"
	${git} "${DIR}/patches/edma/0014-dma-edma-add-device_slave_sg_limits-support.patch"
	${git} "${DIR}/patches/edma/0015-mmc-davinci-get-SG-segment-limits-with-dma_get_slave.patch"
	${git} "${DIR}/patches/edma/0016-mmc-omap_hsmmc-set-max_segs-based-on-dma-engine-limi.patch"
	${git} "${DIR}/patches/edma/0017-ARM-dts-add-AM33XX-MMC-support.patch"
}

arm () {
	echo "dir: arm"
	${git} "${DIR}/patches/arm/0001-deb-pkg-Simplify-architecture-matching-for-cross-bui.patch"
}

omap () {
	echo "dir: omap"
	#Fixes 800Mhz boot lockup: http://www.spinics.net/lists/linux-omap/msg83737.html
#	${git} "${DIR}/patches/omap/0001-regulator-core-if-voltage-scaling-fails-restore-orig.patch"
	${git} "${DIR}/patches/omap/0002-omap2-twl-common-Add-default-power-configuration.patch"

	echo "dir: omap/sakoman"
	${git} "${DIR}/patches/omap_sakoman/0001-OMAP-DSS2-add-bootarg-for-selecting-svideo.patch"
	${git} "${DIR}/patches/omap_sakoman/0002-video-add-timings-for-hd720.patch"

	echo "dir: omap/beagle/expansion"
	${git} "${DIR}/patches/omap_beagle_expansion/0001-Beagle-expansion-add-buddy-param-for-expansionboard-.patch"
	${git} "${DIR}/patches/omap_beagle_expansion/0002-Beagle-expansion-add-zippy.patch"
	${git} "${DIR}/patches/omap_beagle_expansion/0003-Beagle-expansion-add-zippy2.patch"
	${git} "${DIR}/patches/omap_beagle_expansion/0004-Beagle-expansion-add-trainer.patch"
	${git} "${DIR}/patches/omap_beagle_expansion/0005-Beagle-expansion-add-CircuitCo-ulcd-Support.patch"
	${git} "${DIR}/patches/omap_beagle_expansion/0006-Beagle-expansion-add-wifi.patch"
	${git} "${DIR}/patches/omap_beagle_expansion/0007-Beagle-expansion-add-beaglefpga.patch"
	${git} "${DIR}/patches/omap_beagle_expansion/0008-Beagle-expansion-add-spidev.patch"
	${git} "${DIR}/patches/omap_beagle_expansion/0009-Beagle-expansion-add-Aptina-li5m03-camera.patch"
	${git} "${DIR}/patches/omap_beagle_expansion/0010-Beagle-expansion-add-LSR-COM6L-Adapter-Board.patch"
	${git} "${DIR}/patches/omap_beagle_expansion/0011-Beagle-expansion-LSR-COM6L-Adapter-Board-also-initia.patch"

	echo "dir: omap/beagle"
	#Status: for meego guys..
	${git} "${DIR}/patches/omap_beagle/0001-meego-modedb-add-Toshiba-LTA070B220F-800x480-support.patch"
	${git} "${DIR}/patches/omap_beagle/0002-backlight-Add-TLC59108-backlight-control-driver.patch"
	${git} "${DIR}/patches/omap_beagle/0003-tlc59108-adjust-for-beagleboard-uLCD7.patch"

	#Status: not for upstream
	${git} "${DIR}/patches/omap_beagle/0004-zeroMAP-Open-your-eyes.patch"

	${git} "${DIR}/patches/omap_beagle/0005-ARM-OMAP-Beagle-use-TWL4030-generic-reset-script.patch"
	${git} "${DIR}/patches/omap_beagle/0006-DSS2-use-DSI-PLL-for-DPI-with-OMAP3.patch"

	echo "dir: omap/panda"
	#Status: not for upstream: push device tree version upstream...
	${git} "${DIR}/patches/omap_panda/0001-panda-fix-wl12xx-regulator.patch"
	#Status: unknown: cherry picked from linaro
	${git} "${DIR}/patches/omap_panda/0002-ti-st-st-kim-fixing-firmware-path.patch"
	${git} "${DIR}/patches/omap_panda/0003-Panda-expansion-add-spidev.patch"
	${git} "${DIR}/patches/omap_panda/0004-HACK-PandaES-disable-cpufreq-so-board-will-boot.patch"
	${git} "${DIR}/patches/omap_panda/0005-HACK-panda-enable-OMAP4_ERRATA_I688.patch"
	${git} "${DIR}/patches/omap_panda/0006-ARM-hw_breakpoint-Enable-debug-powerdown-only-if-sys.patch"

	#Fix wlan0 on original Panda (strangly the ES was fine...)
	#v3.7.x
	#git revert --no-edit 029dd3cefa46ecdd879f9b4e2df3bdf4371cc22c -s
	${git} "${DIR}/patches/omap_panda/0007-Revert-regulator-twl-Remove-another-unused-variable-.patch"
	#v3.6.x
	#git revert --no-edit e76ab829cc2d8b6350a3f01fffb208df4d7d8c1b -s
	#git revert --no-edit 0e8e5c34cf1a8beaaf0a6a05c053592693bf8cb4 -s
	${git} "${DIR}/patches/omap_panda/0008-Revert-regulator-twl-Remove-references-to-the-twl403.patch"
	${git} "${DIR}/patches/omap_panda/0009-Revert-regulator-twl-Remove-references-to-32kHz-cloc.patch"

	#spidev: make sure to set the pins up...
	${git} "${DIR}/patches/omap_panda/0010-panda-spidev-setup-pinmux.patch"

	#Status: not for upstream: http://www.spinics.net/lists/arm-kernel/msg214633.html
	#Fixes:
	#WARNING: "v7_dma_flush_range" *pvrsrvkm.ko] undefined!
	#WARNING: "v7_dma_map_area" *pvrsrvkm.ko] undefined!
	${git} "${DIR}/patches/omap_sgx/0001-arm-Export-cache-flush-management-symbols-when-MULTI.patch"
}

saucy () {
	echo "dir: saucy"
	${git} "${DIR}/patches/saucy/0001-saucy-disable-stack-protector.patch"
}

sprz319_erratum () {
	echo "dir: omap_sprz319-erratum-2.1"
	${git} "${DIR}/patches/omap_sprz319-erratum-2.1/0001-hack-omap-clockk-dpll5-apply-sprz319e-2.1-erratum.patch"
}

edma
arm
omap
saucy

#Disabled for testing...
#sprz319_erratum

packaging_setup () {
	cp -v "${DIR}/3rdparty/packaging/builddeb" "${DIR}/KERNEL/scripts/package"
	git commit -a -m 'packaging: sync with mainline' -s

	git format-patch -1 -o "${DIR}/patches/packaging"
}

packaging () {
	echo "dir: packaging"
	${git} "${DIR}/patches/packaging/0001-packaging-sync-with-mainline.patch"
	${git} "${DIR}/patches/packaging/0002-deb-pkg-install-dtbs-in-linux-image-package.patch"
	#${git} "${DIR}/patches/packaging/0003-deb-pkg-no-dtbs_install.patch"
}

#packaging_setup
#packaging
echo "patch.sh ran successfully"
