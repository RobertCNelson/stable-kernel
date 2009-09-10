#!/bin/bash
#2.6.29-oer45.1

KERNEL_REL=2.6.29
GIT=58cf2f1

#x86 use:
CC=~/bin/arm-2009q1-203/bin/arm-none-linux-gnueabi-

#arm use:
#CC=

#USB patches is board specific
BOARD=beagleboard

DIR=$PWD

mkdir -p ${DIR}/deploy/
mkdir -p ${DIR}/dl

wget -c --directory-prefix=${DIR}/dl/ http://www.kernel.org/pub/linux/kernel/v2.6/linux-${KERNEL_REL}.tar.bz2

function extract_kernel {
	tar xjf ${DIR}/dl/linux-${KERNEL_REL}.tar.bz2
	mv linux-${KERNEL_REL} KERNEL
}

function patch_kernel {

cd ${DIR}/KERNEL

patch -p1 < ${DIR}/diffs/patch-v${KERNEL_REL}-${GIT}.diff

#Generic omap3 Patches:
patch -p1 < ${DIR}/angstrom/no-empty-flash-warnings.patch
patch -p1 < ${DIR}/angstrom/no-cortex-deadlock.patch
patch -p1 < ${DIR}/angstrom/read_die_ids.patch
patch -p1 < ${DIR}/angstrom/fix-install.patch
patch -p1 < ${DIR}/angstrom/dss2/0001-Revert-gro-Fix-legacy-path-napi_complete-crash.patch
patch -p1 < ${DIR}/angstrom/dss2/0002-OMAPFB-move-omapfb.h-to-include-linux.patch
patch -p1 < ${DIR}/angstrom/dss2/0003-DSS2-OMAP2-3-Display-Subsystem-driver.patch
patch -p1 < ${DIR}/angstrom/dss2/0004-DSS2-OMAP-framebuffer-driver.patch
patch -p1 < ${DIR}/angstrom/dss2/0005-DSS2-Add-panel-drivers.patch
patch -p1 < ${DIR}/angstrom/dss2/0006-DSS2-HACK-Add-DSS2-support-for-N800.patch
patch -p1 < ${DIR}/angstrom/dss2/0007-DSS2-Add-DSS2-support-for-SDP-Beagle-Overo-EVM.patch
patch -p1 < ${DIR}/angstrom/dss2/0008-DSS2-Add-function-to-display-object-to-get-the-back.patch
patch -p1 < ${DIR}/angstrom/dss2/0009-DSS2-Add-acx565akm-panel.patch
patch -p1 < ${DIR}/angstrom/dss2/0010-DSS2-Small-VRFB-context-allocation-bug-fixed.patch
patch -p1 < ${DIR}/angstrom/dss2/0011-DSS2-Allocated-memory-for-Color-Look-up-table.patch
patch -p1 < ${DIR}/angstrom/dss2/0012-DSS2-Fix-DMA-rotation.patch
patch -p1 < ${DIR}/angstrom/dss2/0013-DSS2-Verify-that-overlay-paddr-0.patch
patch -p1 < ${DIR}/angstrom/dss2/0014-DSS2-Add-function-to-get-DSS-logic-clock-rate.patch
patch -p1 < ${DIR}/angstrom/dss2/0015-DSS2-DSI-calculate-VP_CLK_RATIO-properly.patch
patch -p1 < ${DIR}/angstrom/dss2/0016-DSS2-DSI-improve-packet-len-calculation.patch
patch -p1 < ${DIR}/angstrom/dss2/0017-DSS2-Disable-video-planes-on-sync-lost-error.patch
patch -p1 < ${DIR}/angstrom/dss2/0018-DSS2-check-for-ovl-paddr-only-when-enabling.patch
patch -p1 < ${DIR}/angstrom/dss2/0019-DSS2-Check-fclk-limits-when-configuring-video-plane.patch
patch -p1 < ${DIR}/angstrom/dss2/0020-DSS2-Check-scaling-limits-against-proper-values.patch
patch -p1 < ${DIR}/angstrom/dss2/0021-DSS2-Add-venc-register-dump.patch
patch -p1 < ${DIR}/angstrom/dss2/0022-DSS2-FB-remove-unused-var-warning.patch
patch -p1 < ${DIR}/angstrom/dss2/0023-DSS2-pass-the-default-FB-color-format-through-board.patch
patch -p1 < ${DIR}/angstrom/dss2/0024-DSS2-Beagle-Use-gpio_set_value.patch
patch -p1 < ${DIR}/angstrom/dss2/0025-DSS2-VRFB-Macro-for-calculating-base-address-of-th.patch
patch -p1 < ${DIR}/angstrom/dss2/0026-DSS2-DSI-sidlemode-to-noidle-while-sending-frame.patch
patch -p1 < ${DIR}/angstrom/dss2/0027-DSS2-VRFB-rotation-and-mirroring-implemented.patch
patch -p1 < ${DIR}/angstrom/dss2/0028-DSS2-OMAPFB-Added-support-for-the-YUV-VRFB-rotatio.patch
patch -p1 < ${DIR}/angstrom/dss2/0029-DSS2-OMAPFB-Set-line_length-correctly-for-YUV-with.patch
patch -p1 < ${DIR}/angstrom/dss2/0030-DSS2-dispc_get_trans_key-was-returning-wrong-key-ty.patch
patch -p1 < ${DIR}/angstrom/dss2/0031-DSS2-do-bootmem-reserve-for-exclusive-access.patch
patch -p1 < ${DIR}/angstrom/dss2/0032-DSS2-Fix-DISPC_VID_FIR-value-for-omap34xx.patch
patch -p1 < ${DIR}/angstrom/dss2/0033-DSS2-Prefer-3-tap-filter.patch
patch -p1 < ${DIR}/angstrom/dss2/0034-DSS2-VRAM-improve-omap_vram_add_region.patch
patch -p1 < ${DIR}/angstrom/dss2/0035-DSS2-Added-the-function-pointer-for-getting-default.patch
patch -p1 < ${DIR}/angstrom/dss2/0036-DSS2-Added-support-for-setting-and-querying-alpha-b.patch
patch -p1 < ${DIR}/angstrom/dss2/0037-DSS2-Added-support-for-querying-color-keying.patch
patch -p1 < ${DIR}/angstrom/dss2/0038-DSS2-OMAPFB-Some-color-keying-pointerd-renamed-in-D.patch
patch -p1 < ${DIR}/angstrom/dss2/0039-DSS2-Add-sysfs-entry-to-for-the-alpha-blending-supp.patch
patch -p1 < ${DIR}/angstrom/dss2/0040-DSS2-Provided-proper-exclusion-for-destination-colo.patch
patch -p1 < ${DIR}/angstrom/dss2/0041-DSS2-Disable-vertical-offset-with-fieldmode.patch
patch -p1 < ${DIR}/angstrom/dss2/0042-DSS2-Don-t-enable-fieldmode-automatically.patch
patch -p1 < ${DIR}/angstrom/dss2/0043-DSS2-Swap-field-0-and-field-1-registers.patch
patch -p1 < ${DIR}/angstrom/dss2/0044-DSS2-add-sysfs-entry-for-seting-the-rotate-type.patch
patch -p1 < ${DIR}/angstrom/dss2/0045-DSS2-Fixed-line-endings-from-to.patch
patch -p1 < ${DIR}/angstrom/dss2/0046-DSS2-DSI-decrease-sync-timeout-from-60s-to-2s.patch
patch -p1 < ${DIR}/angstrom/dss2/0047-DSS2-fix-return-value-for-rotate_type-sysfs-functio.patch
patch -p1 < ${DIR}/angstrom/dss2/0048-OMAP2-3-DMA-implement-trans-copy-and-const-fill.patch
patch -p1 < ${DIR}/angstrom/dss2/0049-DSS2-VRAM-clear-allocated-area-with-DMA.patch
patch -p1 < ${DIR}/angstrom/dss2/0050-DSS2-OMAPFB-remove-fb-clearing-code.patch
patch -p1 < ${DIR}/angstrom/dss2/0051-DSS2-VRAM-use-debugfs-not-procfs.patch
patch -p1 < ${DIR}/angstrom/dss2/0052-DSS2-VRAM-fix-section-mismatch-warning.patch
patch -p1 < ${DIR}/angstrom/dss2/0053-DSS2-disable-LCD-DIGIT-before-resetting-DSS.patch
patch -p1 < ${DIR}/angstrom/dss2/0054-DSS2-DSI-more-error-handling.patch
patch -p1 < ${DIR}/angstrom/dss2/0055-DSS2-Added-global-alpha-support.patch
patch -p1 < ${DIR}/angstrom/dss2/0056-DSS2-Rotation-attrs-for-YUV-need-not-to-be-reversed.patch
patch -p1 < ${DIR}/angstrom/dss2/0057-DSS2-Documentation-update-for-new-sysfs-entries-in.patch
patch -p1 < ${DIR}/angstrom/dss2/0058-DSS2-Don-t-touch-plane-coordinates-when-changing-fb.patch
patch -p1 < ${DIR}/angstrom/dss2/0059-DSS2-DSI-configure-ENTER-EXIT_HS_MODE_LATENCY.patch
patch -p1 < ${DIR}/angstrom/dss2/0060-DSS2-Avoid-div-by-zero-when-calculating-required-fc.patch
patch -p1 < ${DIR}/angstrom/dss2/0061-DSS2-VRFB-save-restore-context.patch
patch -p1 < ${DIR}/angstrom/dss2/0062-DSS2-VRAM-Fix-indentation.patch
patch -p1 < ${DIR}/angstrom/dss2/0063-DSS2-fix-the-usage-of-get_last_off_on_transaction_i.patch
patch -p1 < ${DIR}/angstrom/dss2/0064-VRFB-fix-debug-messages.patch
patch -p1 < ${DIR}/angstrom/dss2/0065-VRFB-add-suspend-resume-functionality.patch
patch -p1 < ${DIR}/angstrom/dss2/0066-DSS2-DSI-tune-the-timings-to-be-more-relaxed.patch
patch -p1 < ${DIR}/angstrom/dss2/0067-DSS2-VRFB-don-t-WARN-when-releasing-inactive-ctx.patch
patch -p1 < ${DIR}/angstrom/dss2/0068-DSS2-Swap-field-offset-values-w-VRFB-rotation.patch
patch -p1 < ${DIR}/angstrom/dss2/0069-DSS2-OMAP3EVM-Added-DSI-powerup-and-powerdown-func.patch
patch -p1 < ${DIR}/angstrom/dss2/0070-DSS2-fix-irq1.diff
patch -p1 < ${DIR}/angstrom/dss2/0071-DSS2-fix-irq2.diff
patch -p1 < ${DIR}/angstrom/0001-board-ldp-add-regulator-info-to-get-the-microSD-slo.patch
patch -p1 < ${DIR}/angstrom/fix-unaligned-access.diff
patch -p1 < ${DIR}/angstrom/make-alignment-visible.diff
patch -p1 < ${DIR}/angstrom/mmctiming.patch
patch -p1 < ${DIR}/angstrom/fix-audio-capture.patch
patch -p1 < ${DIR}/angstrom/ads7846-detection.patch
patch -p1 < ${DIR}/angstrom/musb/0001-USB-musb-only-turn-off-vbus-in-OTG-hosts.patch
patch -p1 < ${DIR}/angstrom/musb/0002-USB-composite-avoid-inconsistent-lock-state.patch
patch -p1 < ${DIR}/angstrom/musb/0003-USB-musb-NAK-timeout-scheme-on-bulk-RX-endpoint.patch
patch -p1 < ${DIR}/angstrom/musb/0004-USB-musb-rewrite-host-periodic-endpoint-allocation.patch
patch -p1 < ${DIR}/angstrom/musb/0005-USB-TWL-disable-VUSB-regulators-when-cable-unplugg.patch
patch -p1 < ${DIR}/angstrom/musb/0006-USB-gadget-composite-device-level-suspend-resume-h.patch
patch -p1 < ${DIR}/angstrom/musb/0007-usb-gadget-fix-ethernet-link-reports-to-ethtool.patch
patch -p1 < ${DIR}/angstrom/musb/0008-usb-musb_host-minor-enqueue-locking-fix-v2.patch
patch -p1 < ${DIR}/angstrom/musb/0009-usb-musb_host-fix-ep0-fifo-flushing.patch
patch -p1 < ${DIR}/angstrom/musb/0010-musb-sanitize-clearing-TXCSR-DMA-bits-take-2.patch
patch -p1 < ${DIR}/angstrom/musb/0011-musb-fix-isochronous-TXDMA-take-2.patch
patch -p1 < ${DIR}/angstrom/musb/0012-musb-fix-possible-panic-while-resuming.patch
patch -p1 < ${DIR}/angstrom/musb/0013-musb_host-refactor-musb_save_toggle-take-2.patch
patch -p1 < ${DIR}/angstrom/musb/0014-musb_gadget-suppress-parasitic-TX-interrupts-with.patch
patch -p1 < ${DIR}/angstrom/musb/0015-musb_gadget-fix-unhandled-endpoint-0-IRQs.patch
patch -p1 < ${DIR}/angstrom/musb/0016-musb_host-factor-out-musb_ep_-get-set-_qh.patch
patch -p1 < ${DIR}/angstrom/musb/0017-musb_host-refactor-URB-giveback.patch
patch -p1 < ${DIR}/angstrom/musb/0018-musb-split-out-CPPI-interrupt-handler.patch
patch -p1 < ${DIR}/angstrom/musb/0019-musb_host-simplify-check-for-active-URB.patch
patch -p1 < ${DIR}/angstrom/musb/0020-musb_host-streamline-musb_cleanup_urb-calls.patch
patch -p1 < ${DIR}/angstrom/musb/0021-twl4030-usb-fix-minor-reporting-goofage.patch
patch -p1 < ${DIR}/angstrom/musb/0022-musb-use-dma-mode-1-for-TX-if-transfer-size-equals.patch
patch -p1 < ${DIR}/angstrom/musb/0023-musb-add-high-bandwidth-ISO-support.patch
patch -p1 < ${DIR}/angstrom/musb/0024-USB-otg-adding-nop-usb-transceiver.patch
patch -p1 < ${DIR}/angstrom/musb/0025-nop-usb-xceiv-behave-when-linked-as-a-module.patch
patch -p1 < ${DIR}/angstrom/musb/0026-musb-proper-hookup-to-transceiver-drivers.patch
patch -p1 < ${DIR}/angstrom/musb/0027-musb-otg-timer-cleanup.patch
patch -p1 < ${DIR}/angstrom/musb/0028-musb-make-initial-HNP-roleswitch-work-v2.patch
patch -p1 < ${DIR}/angstrom/musb/0029-musb-support-disconnect-after-HNP-roleswitch.patch
patch -p1 < ${DIR}/angstrom/isp/v4l/0001-V4L2-Add-COLORFX-user-control.patch
patch -p1 < ${DIR}/angstrom/isp/v4l/0002-V4L-Int-if-v4l2_int_device_try_attach_all-requires.patch
patch -p1 < ${DIR}/angstrom/isp/v4l/0003-V4L-Int-if-Dummy-slave.patch
patch -p1 < ${DIR}/angstrom/isp/v4l/0004-V4L-int-device-add-support-for-VIDIOC_QUERYMENU.patch
patch -p1 < ${DIR}/angstrom/isp/v4l/0005-V4L-Int-if-Add-vidioc_int_querycap.patch
patch -p1 < ${DIR}/angstrom/isp/iommu/0001-omap-iommu-tlb-and-pagetable-primitives.patch
patch -p1 < ${DIR}/angstrom/isp/iommu/0002-omap-iommu-omap2-architecture-specific-functions.patch
patch -p1 < ${DIR}/angstrom/isp/iommu/0003-omap-iommu-omap3-iommu-device-registration.patch
patch -p1 < ${DIR}/angstrom/isp/iommu/0004-omap-iommu-simple-virtual-address-space-management.patch
patch -p1 < ${DIR}/angstrom/isp/iommu/0005-omap-iommu-entries-for-Kconfig-and-Makefile.patch
patch -p1 < ${DIR}/angstrom/isp/iommu/0006-omap-iommu-Don-t-try-BUG_ON-in_interrupt.patch
patch -p1 < ${DIR}/angstrom/isp/iommu/0007-omap-iommu-We-support-chained-scatterlists-probabl.patch
patch -p1 < ${DIR}/angstrom/isp/iommu/0008-omap2-iommu-entries-for-Kconfig-and-Makefile.patch
patch -p1 < ${DIR}/angstrom/isp/omap3camera/0001-omap3isp-Add-ISP-main-driver-and-register-definitio.patch
patch -p1 < ${DIR}/angstrom/isp/omap3camera/0002-omap3isp-Add-ISP-MMU-wrapper.patch
patch -p1 < ${DIR}/angstrom/isp/omap3camera/0003-omap3isp-Add-userspace-header.patch
patch -p1 < ${DIR}/angstrom/isp/omap3camera/0004-omap3isp-Add-ISP-frontend-CCDC.patch
patch -p1 < ${DIR}/angstrom/isp/omap3camera/0005-omap3isp-Add-ISP-backend-PRV-and-RSZ.patch
patch -p1 < ${DIR}/angstrom/isp/omap3camera/0006-omap3isp-Add-statistics-collection-modules-H3A-and.patch
patch -p1 < ${DIR}/angstrom/isp/omap3camera/0007-omap3isp-Add-CSI2-interface-support.patch
patch -p1 < ${DIR}/angstrom/isp/omap3camera/0008-omap3isp-Add-ISP-tables.patch
patch -p1 < ${DIR}/angstrom/isp/omap3camera/0009-omap34xxcam-Add-camera-driver.patch
patch -p1 < ${DIR}/angstrom/isp/resizer/0023-OMAP-Resizer-Basic-Resizer-refreshed-with-latest-gi.patch
patch -p1 < ${DIR}/angstrom/isp/resizer/0024-OMAP3-Resizer-V4L2-buf-layer-issues-fixed.patch
patch -p1 < ${DIR}/angstrom/isp/resizer/0025-OMAP3-Resizer-Build-issues-fixed.patch
patch -p1 < ${DIR}/angstrom/0124-leds-gpio-broken-with-current-git.patch
patch -p1 < ${DIR}/angstrom/modedb-hd720.patch
patch -p1 < ${DIR}/angstrom/0001-implement-TIF_RESTORE_SIGMASK-support-and-enable-the.patch
patch -p1 < ${DIR}/angstrom/vfp/02-vfp-ptrace.patch
patch -p1 < ${DIR}/angstrom/vfp/03-vfp-corruption.patch
patch -p1 < ${DIR}/angstrom/vfp/04-vfp-threads.patch
patch -p1 < ${DIR}/angstrom/vfp/05-vfp-signal-handlers.patch
patch -p1 < ${DIR}/angstrom/arch-has-holes.diff
patch -p1 < ${DIR}/angstrom/cache/l1cache-shift.patch
patch -p1 < ${DIR}/angstrom/cache/copy-page-tweak.patch

#Board specific patches
patch -p1 < ${DIR}/angstrom/${BOARD}/beagle-asoc.patch
patch -p1 < ${DIR}/angstrom/${BOARD}/ehci.patch
patch -p1 < ${DIR}/angstrom/${BOARD}/tincantools-puppy.diff
patch -p1 < ${DIR}/angstrom/${BOARD}/tincantools-zippy.diff

patch -p1 < ${DIR}/angstrom/beaglebug/beaglebug-full.patch

cp ${DIR}/angstrom/${BOARD}/logo_linux_clut224.ppm ./drivers/video/logo/logo_linux_clut224.ppm

#Clean up omap tag
patch -p1 < ${DIR}/patches/remove-omap-string.diff
cd ${DIR}/
}

function copy_defconfig {
	cd ${DIR}/KERNEL/
	make ARCH=arm CROSS_COMPILE=${CC} distclean
	cp ${DIR}/patches/defconfig .config
	cd ${DIR}/
}

function make_menuconfig {
	cd ${DIR}/KERNEL/
	make ARCH=arm CROSS_COMPILE=${CC} menuconfig
	cd ${DIR}/
}

function make_uImage {
	cd ${DIR}/KERNEL/
	make -j2 ARCH=arm CROSS_COMPILE=${CC} uImage
	cp arch/arm/boot/uImage ${DIR}/deploy/
	cd ${DIR}
}

function make_modules {
	cd ${DIR}/KERNEL/
	make -j2 ARCH=arm CROSS_COMPILE=${CC} modules
	make ARCH=arm CROSS_COMPILE=${CC} modules_install INSTALL_MOD_PATH=${DIR}/deploy
	cd ${DIR}/deploy
	tar czf modules.tar.gz *
	cd ${DIR}
}

extract_kernel
patch_kernel
copy_defconfig
make_menuconfig
make_uImage
make_modules


