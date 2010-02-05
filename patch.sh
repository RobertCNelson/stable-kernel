#!/bin/bash
# Split out, so build_kernel.sh and build_deb.sh can share..

function linux-omap {
patch -s -p1 < ${DIR}/patches/${BRANCH}-patch-from-${REL}-to-${GIT}.diff
}

function musb {
echo "musb fifo fix"
patch -s -p1 < ${DIR}/patches/musb/fifo-change.patch
patch -s -p1 < ${DIR}/patches/musb/musb-Add-new-fifo-table-for-a-OMAP3-errata.patch
patch -s -p1 < ${DIR}/patches/musb/enable-fifo_mode_5_for_OMAP34XX.diff
}

function angstrom {
echo "Angstrom Patches"
}

function micrel {
echo "micrel patches"
patch -s -p1 < ${DIR}/patches/micrel/ksz8851_snl_1_2.6.32.patch
patch -s -p1 < ${DIR}/patches/micrel/ksz8851_snl_2_2.6.32.patch
patch -s -p1 < ${DIR}/patches/micrel/ksz8851_snl_3_2.6.32.patch
patch -s -p1 < ${DIR}/patches/micrel/micrel-eth.patch
}

function rcn {
echo "rcn patches"
patch -s -p1 < ${DIR}/patches/rcn/ehci-omap-mach-to-plat-fix.diff
patch -s -p1 < ${DIR}/patches/rcn/Fix-i2c-lockup.diff
}

function dss2 {
echo "dss2 patches"
#patch -s -p1 < ${DIR}/patches/dss2/0001-OMAP2-Add-funcs-for-writing-SMS_ROT_-registers.patch
#patch -s -p1 < ${DIR}/patches/dss2/0002-OMAP-OMAPFB-split-omapfb.h.patch
#patch -s -p1 < ${DIR}/patches/dss2/0003-OMAP-OMAPFB-add-omapdss-device.patch
#patch -s -p1 < ${DIR}/patches/dss2/0004-OMAP-Add-VRAM-manager.patch
#patch -s -p1 < ${DIR}/patches/dss2/0005-OMAP-Add-support-for-VRFB-rotation-engine.patch
#patch -s -p1 < ${DIR}/patches/dss2/0006-OMAP-DSS2-Documentation-for-DSS2.patch
#patch -s -p1 < ${DIR}/patches/dss2/0007-OMAP-DSS2-Display-Subsystem-Driver-core.patch
#patch -s -p1 < ${DIR}/patches/dss2/0008-OMAP-DSS2-Add-more-core-files.patch
#patch -s -p1 < ${DIR}/patches/dss2/0009-OMAP-DSS2-DISPC.patch
#patch -s -p1 < ${DIR}/patches/dss2/0010-OMAP-DSS2-DPI-driver.patch
#patch -s -p1 < ${DIR}/patches/dss2/0011-OMAP-DSS2-Video-encoder-driver.patch
#patch -s -p1 < ${DIR}/patches/dss2/0012-OMAP-DSS2-RFBI-driver.patch
#patch -s -p1 < ${DIR}/patches/dss2/0013-OMAP-DSS2-SDI-driver.patch
#patch -s -p1 < ${DIR}/patches/dss2/0014-OMAP-DSS2-DSI-driver.patch
#patch -s -p1 < ${DIR}/patches/dss2/0015-OMAP-DSS2-omapfb-driver.patch
#patch -s -p1 < ${DIR}/patches/dss2/0016-OMAP-DSS2-Add-DPI-panel-drivers.patch
#patch -s -p1 < ${DIR}/patches/dss2/0017-OMAP-DSS2-Taal-DSI-command-mode-panel-driver.patch
#patch -s -p1 < ${DIR}/patches/dss2/0018-OMAP-SDP-Enable-DSS2-for-OMAP3-SDP-board.patch
#patch -s -p1 < ${DIR}/patches/dss2/0019-MAINTAINERS-Add-OMAP2-3-DSS-and-OMAPFB-maintainer.patch

patch -s -p1 < ${DIR}/patches/dss2/0020-DSS2-OMAPFB-fix-offset-with-YUV-modes.patch
patch -s -p1 < ${DIR}/patches/dss2/0021-OMAP2-OMAPFB-fix-compilation-when-DSS2-not-in-use.patch
patch -s -p1 < ${DIR}/patches/rcn/beagle-dss2-support.diff
patch -s -p1 < ${DIR}/patches/rcn/beagle-enable-2nd-i2c.diff
}

function vfp {
echo "Apply vfp patches, should help pixman"
patch -s -p1 < ${DIR}/patches/vfp/0001-So-far-vfp_sync_state-worked-only-for-threads-other-.patch
patch -s -p1 < ${DIR}/patches/vfp/0002-Signal-handlers-can-use-floating-point-so-prevent-th.patch
}

function memory-hole {
echo "Applying memory hole patch"
patch -s -p1 < ${DIR}/patches/omap/0001-ARCH-OMAP-enable-ARCH_HAS_HOLES_MEMORYMODEL-for-OMAP.patch
}

linux-omap
musb
rcn
dss2
vfp
memory-hole

#enable micrel for zippy2 support
#micrel

