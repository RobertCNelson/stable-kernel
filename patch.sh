#!/bin/bash
# Split out, so build_kernel.sh and build_deb.sh can share..

patch -s -p1 < ${DIR}/diffs/patch-v${KERNEL_REL}-${GIT}.diff

echo "musb fifo fix"
patch -s -p1 < ${DIR}/patches/rcn/fifo-change.patch

echo "micrel patches"
patch -s -p1 < ${DIR}/patches/micrel/0001-KS8851-Add-soft-reset-at-probe-time.patch
patch -s -p1 < ${DIR}/patches/micrel/0002-KS8851-Fix-MAC-address-write-order.patch
patch -s -p1 < ${DIR}/patches/micrel/0003-KS8851-Fix-ks8851_set_rx_mode-for-IFF_MULTICAST.patch
patch -s -p1 < ${DIR}/patches/micrel/ksz8851_snl_2.6.32-rc6.patch

#board specific usb patches
patch -s -p1 < ${DIR}/patches/angstrom/${BOARD}/ehci.patch

#generic
patch -s -p1 < ${DIR}/patches/rcn/0001-implement-TIF_RESTORE_SIGMASK-support-and-enable-the.patch
patch -s -p1 < ${DIR}/patches/angstrom/cache/l1cache-shift.patch
patch -s -p1 < ${DIR}/patches/angstrom/cache/copy-page-tweak.patch

#DSS2 Patches
patch -s -p1 < ${DIR}/patches/angstrom/dss2/0001-OMAP2-Add-funcs-for-writing-SMS_ROT_-registers.patch
patch -s -p1 < ${DIR}/patches/angstrom/dss2/0002-OMAP-OMAPFB-split-omapfb.h.patch
patch -s -p1 < ${DIR}/patches/angstrom/dss2/0003-OMAP-OMAPFB-add-omapdss-device.patch
patch -s -p1 < ${DIR}/patches/angstrom/dss2/0004-OMAP-Add-VRAM-manager.patch
patch -s -p1 < ${DIR}/patches/angstrom/dss2/0005-OMAP-Add-support-for-VRFB-rotation-engine.patch
patch -s -p1 < ${DIR}/patches/angstrom/dss2/0006-OMAP-DSS2-Documentation-for-DSS2.patch
patch -s -p1 < ${DIR}/patches/angstrom/dss2/0007-OMAP-DSS2-Display-Subsystem-Driver-core.patch
patch -s -p1 < ${DIR}/patches/angstrom/dss2/0008-OMAP-DSS2-Add-more-core-files.patch
patch -s -p1 < ${DIR}/patches/angstrom/dss2/0009-OMAP-DSS2-DISPC.patch
patch -s -p1 < ${DIR}/patches/angstrom/dss2/0010-OMAP-DSS2-DPI-driver.patch
patch -s -p1 < ${DIR}/patches/angstrom/dss2/0011-OMAP-DSS2-Video-encoder-driver.patch
patch -s -p1 < ${DIR}/patches/angstrom/dss2/0012-OMAP-DSS2-RFBI-driver.patch
patch -s -p1 < ${DIR}/patches/angstrom/dss2/0013-OMAP-DSS2-SDI-driver.patch
patch -s -p1 < ${DIR}/patches/angstrom/dss2/0014-OMAP-DSS2-DSI-driver.patch
patch -s -p1 < ${DIR}/patches/angstrom/dss2/0015-OMAP-DSS2-omapfb-driver.patch
patch -s -p1 < ${DIR}/patches/angstrom/dss2/0016-OMAP-DSS2-Add-DPI-panel-drivers.patch
patch -s -p1 < ${DIR}/patches/angstrom/dss2/0017-OMAP-DSS2-Taal-DSI-command-mode-panel-driver.patch
patch -s -p1 < ${DIR}/patches/angstrom/dss2/0001-OMAP3-Enable-DSS2-for-OMAP3EVM-board.patch
patch -s -p1 < ${DIR}/patches/angstrom/dss2/0002-V4L2-Added-New-V4L2-CIDs-for-omap-devices-V4L2-IOCT.patch
patch -s -p1 < ${DIR}/patches/angstrom/dss2/0003-V4L2-Updated-v4l2_common-for-new-V4L2-CIDs.patch
patch -s -p1 < ${DIR}/patches/angstrom/dss2/0004-OMAP2-3-V4L2-Add-support-for-OMAP2-3-V4L2-driver-on.patch

#Not safe, Breaks Rev B's
#patch -s -p1 < ${DIR}/patches/angstrom/expansion-boards/tincantools-zippy.patch

patch -s -p1 < ${DIR}/patches/angstrom/madc/madc-driver.patch
patch -s -p1 < ${DIR}/patches/angstrom/madc/madc.patch
patch -s -p1 < ${DIR}/patches/angstrom/arch-has-holes.diff

#usb
patch -s -p1 < ${DIR}/patches/angstrom/usb/0001-musb-fix-put_device-call-sequence.patch
patch -s -p1 < ${DIR}/patches/angstrom/usb/0008-omap3-Add-CHIP_GE_OMAP3430ES3-for-HSUSB.patch
patch -s -p1 < ${DIR}/patches/angstrom/usb/0011-musb-fix-musb-gadget_driver-NULL-bug.patch
patch -s -p1 < ${DIR}/patches/angstrom/usb/0012-musb-Add-back-old-musb-procfs-file.patch
patch -s -p1 < ${DIR}/patches/angstrom/usb/0013-musb-Remove-USB_SUSPEND-auto-select-with-OTG.patch
patch -s -p1 < ${DIR}/patches/angstrom/usb/0014-musb-disable-PING-on-status-phase-of-control-transf.patch
patch -s -p1 < ${DIR}/patches/angstrom/usb/0015-musb-Add-context-save-and-restore-support.patch
patch -s -p1 < ${DIR}/patches/angstrom/usb/0016-usb-update-defconfig.patch
patch -s -p1 < ${DIR}/patches/angstrom/usb/0001-ARM-OMAP-Fix-beagleboard-EHCI-setup.patch

patch -s -p1 < ${DIR}/patches/angstrom/modedb-hd720.patch

#patch -s -p1 < ${DIR}/patches/angstrom/dss2/beagle-dss2-support.patch
patch -s -p1 < ${DIR}/patches/rcn/beagle-dss2-support-fixup.diff

#Enable for zippy2 
#echo "Patching Micrel support into omap3beagle"
#cp arch/arm/mach-omap2/board-omap3beagle.c arch/arm/mach-omap2/board-omap3beagle.c.orig
#echo "meld arch/arm/mach-omap2/board-omap3beagle.c.orig arch/arm/mach-omap2/board-omap3beagle.c"
#patch -s -p1 < ${DIR}/patches/micrel/micrel-at24c01.patch
#patch -s -p1 < ${DIR}/patches/micrel/micrel-eth.patch

cp ${DIR}/patches/angstrom/${BOARD}/logo_linux_clut224.ppm ./drivers/video/logo/logo_linux_clut224.ppm

#Clean up omap tag
patch -s -p1 < ${DIR}/patches/rcn/remove-omap-string.diff

