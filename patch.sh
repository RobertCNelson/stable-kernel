#!/bin/bash
# Split out, so build_kernel.sh and build_deb.sh can share..

echo "Starting patch.sh"

function dss2 {
echo "dss2 patches"

patch -s -p1 < ${DIR}/patches/dss2/tomba/0001-OMAP-Enable-DSS2-in-OMAP3EVM-defconfig.patch
patch -s -p1 < ${DIR}/patches/dss2/tomba/0002-OMAP-AM3517-Enable-DSS2-in-AM3517EVM-defconfig.patch
patch -s -p1 < ${DIR}/patches/dss2/tomba/0003-OMAP-DSS2-Add-Kconfig-option-for-DPI-display-type.patch
patch -s -p1 < ${DIR}/patches/dss2/tomba/0004-OMAP-DSS2-Remove-redundant-enable-disable-calls-from.patch
patch -s -p1 < ${DIR}/patches/dss2/tomba/0005-OMAP-DSS2-Use-vdds_sdi-regulator-supply-in-SDI.patch
patch -s -p1 < ${DIR}/patches/dss2/tomba/0006-OMAP-DSS2-fix-lock_fb_info-and-omapfb_lock-locking-o.patch
patch -s -p1 < ${DIR}/patches/dss2/tomba/0007-OMAP-DSS2-check-lock_fb_info-return-value.patch
patch -s -p1 < ${DIR}/patches/dss2/tomba/0008-OMAP-DSS2-VENC-don-t-call-platform_enable-disable-tw.patch
patch -s -p1 < ${DIR}/patches/dss2/tomba/0009-OMAP-DSS2-Fix-device-disable-when-driver-is-not-load.patch
patch -s -p1 < ${DIR}/patches/dss2/tomba/0010-OMAP-DSS2-Make-partial-update-width-even.patch
patch -s -p1 < ${DIR}/patches/dss2/tomba/0011-OMAP-DSS2-Taal-add-mutex-to-protect-panel-data.patch
patch -s -p1 < ${DIR}/patches/dss2/tomba/0012-OMAP-DSS2-Taal-Fix-DSI-bus-locking-problem.patch
patch -s -p1 < ${DIR}/patches/dss2/tomba/0013-OMAP-LCD-LS037V7DW01-Add-Backlight-driver-support.patch
patch -s -p1 < ${DIR}/patches/dss2/tomba/0014-OMAP-DSS2-TPO-TD03MTEA1-fix-Kconfig-dependency.patch
patch -s -p1 < ${DIR}/patches/dss2/tomba/0015-OMAP-RX51-Add-LCD-Panel-support.patch
patch -s -p1 < ${DIR}/patches/dss2/tomba/0016-OMAP-RX51-Add-Touch-Controller-in-SPI-board-info.patch
patch -s -p1 < ${DIR}/patches/dss2/tomba/0017-OMAP-DSS2-Add-ACX565AKM-Panel-Driver.patch
patch -s -p1 < ${DIR}/patches/dss2/tomba/0018-OMAP-RX51-Update-board-defconfig.patch
patch -s -p1 < ${DIR}/patches/dss2/tomba/0019-OMAP3630-DSS2-Updating-MAX-divider-value.patch
patch -s -p1 < ${DIR}/patches/dss2/tomba/0020-OMAP2-DSS-Add-missing-line-for-update-bg-color.patch
patch -s -p1 < ${DIR}/patches/dss2/tomba/0021-board-omap3-beagle-add-DSS2-support.patch
patch -s -p1 < ${DIR}/patches/dss2/tomba/0022-OMAP-DSS2-omap_dss_probe-conditional-compilation-cle.patch
patch -s -p1 < ${DIR}/patches/dss2/tomba/0023-OMAP-DSS2-Fix-omap_dss_probe-error-path.patch

patch -s -p1 < ${DIR}/patches/dss2/DSS2-overo-fixup.patch
patch -s -p1 < ${DIR}/patches/dss2/reboot-fix.diff
}

function musb {
echo "musb patches"
patch -s -p1 < ${DIR}/patches/musb/force-fifo_mode-5.diff
}

function vfp {
echo "vfp patches"
#git am ${DIR}/patches/vfp/0002-Signal-handlers-can-use-floating-point-so-prevent-th.patch
}

function micrel {
echo "micrel patches"
patch -s -p1 < ${DIR}/patches/micrel/linux-2.6.34/01_eeprom_93cx6_2.6.34.patch
patch -s -p1 < ${DIR}/patches/micrel/linux-2.6.34/02_eeprom_93cx6_2.6.34.patch

patch -s -p1 < ${DIR}/patches/micrel/linux-2.6.34/03_ksz8851_2.6.34-fixup.patch
#patch -s -p1 < ${DIR}/patches/micrel/linux-2.6.34/03_ksz8851_2.6.34.patch

patch -s -p1 < ${DIR}/patches/micrel/linux-2.6.34/04_ksz8851_2.6.34.patch
patch -s -p1 < ${DIR}/patches/micrel/linux-2.6.34/05_ksz8851_2.6.34.patch
patch -s -p1 < ${DIR}/patches/micrel/linux-2.6.34/06_ksz8851_2.6.34.patch
patch -s -p1 < ${DIR}/patches/micrel/linux-2.6.34/07_ksz8851_2.6.34.patch
patch -s -p1 < ${DIR}/patches/micrel/linux-2.6.34/08_ksz8851_2.6.34.patch
patch -s -p1 < ${DIR}/patches/micrel/linux-2.6.34/09_ksz8851_2.6.34.patch
patch -s -p1 < ${DIR}/patches/micrel/linux-2.6.34/10_ksz8851_2.6.34.patch

patch -s -p1 < ${DIR}/patches/micrel/linux-2.6.34/11_ksz8851_2.6.34-fixup.patch
#patch -s -p1 < ${DIR}/patches/micrel/linux-2.6.34/11_ksz8851_2.6.34.patch

patch -s -p1 < ${DIR}/patches/micrel/linux-2.6.34/12_ksz8851_2.6.34.patch

patch -s -p1 < ${DIR}/patches/micrel/linux-2.6.34/15_ksz8851_2.6.34-fixup.patch
#patch -s -p1 < ${DIR}/patches/micrel/linux-2.6.34/15_ksz8851_2.6.34.patch

#patch -s -p1 < ${DIR}/patches/micrel/linux-2.6.34/16_compressed_2.6.33.patch

patch -s -p1 < ${DIR}/patches/micrel/linux-2.6.34/18_ksz8851_2.6.34-rc7.patch
}

function zippy {
echo "zippy support"
patch -s -p1 < ${DIR}/patches/angstrom/0003-ARM-OMAP-add-support-for-TCT-Zippy-to-Beagle-board-fixup.patch
patch -s -p1 < ${DIR}/patches/angstrom/0043-ARM-OMAP-beagleboard-Add-infrastructure-to-do-fixups-fixup.patch
patch -s -p1 < ${DIR}/patches/rcn/beagle-zippy-dont-load-i2c-on-boards-with-nozippy.diff
}

function xm {
echo "early xm support"
patch -s -p1 < ${DIR}/patches/xm/xm-dvi-ehci-support.diff
patch -s -p1 < ${DIR}/patches/xm/sakoman/0001-ARM-OMAP-Add-macros-for-comparing-silicon-revision.patch
patch -s -p1 < ${DIR}/patches/xm/sakoman/0001-OMAP-DSS2-check-for-both-cpu-type-and-revision-rathe.patch
patch -s -p1 < ${DIR}/patches/xm/sakoman/0001-OMAP-DSS2-enable-hsclk-in-dsi_pll_init-for-OMAP36XX.patch
}

function nand {
echo "new nand interface"
patch -s -p1 < ${DIR}/patches/nand/0001-ARM-OMAP-Beagle-use-new-gpmc-nand-infrastructure-fixup.patch
patch -s -p1 < ${DIR}/patches/nand/0001-ARM-OMAP-Overo-use-new-gpmc-nand-infrastructure.patch
}

function sgx {
echo "merge in ti sgx modules"
patch -s -p1 < ${DIR}/patches/sgx/0001-OMAP3-SGX-Merge-TI-3.01.00.02-Kernel-Modules.patch
patch -s -p1 < ${DIR}/patches/sgx/0001-OMAP3-SGX-setup-staging-makefile.patch
patch -s -p1 < ${DIR}/patches/sgx/0001-OMAP3-SGX-TI-3.01.00.02-mach-to-plat.diff
patch -s -p1 < ${DIR}/patches/sgx/0001-OMAP3-SGX-Kconfig-updates.diff
patch -s -p1 < ${DIR}/patches/sgx/0001-OMAP3-SGX-TI-3.01.00.02-update-bufferclass_ti-Kbuild.diff
patch -s -p1 < ${DIR}/patches/sgx/0001-OMAP3-SGX-TI-3.01.00.02-update-bufferclass_ti-kfree-kmalloc.diff
patch -s -p1 < ${DIR}/patches/sgx/0001-OMAP3-SGX-TI-3.01.00.02-update-dc_omap3430_linux-Kbuild.diff
#Not Ready...
patch -s -p1 < ${DIR}/patches/sgx/0001-OMAP3-SGX-Merge-TI-3.01.00.06-into-TI-3.01.00.02.patch
patch -s -p1 < ${DIR}/patches/sgx/0001-OMAP3-SGX-TI-3.01.00.06-update-bufferclass_ti-kfree-kmalloc.diff
patch -s -p1 < ${DIR}/patches/sgx/0001-OMAP3-SGX-TI-3.01.00.06-2.6.32-PSP.diff
patch -s -p1 < ${DIR}/patches/sgx/0001-OMAP3-SGX-TI-3.01.00.06-use-omap3630.diff
}

function dsp {
echo "merge in dsp bridge"
patch -s -p1 < ${DIR}/patches/dsp/0001-dspbridge-baseline-dspbridge-0.2.patch
patch -s -p1 < ${DIR}/patches/dsp/0-makefile.diff
patch -s -p1 < ${DIR}/patches/dsp/0-kconfig.diff
patch -s -p1 < ${DIR}/patches/dsp/0-drivers-makefile.diff
patch -s -p1 < ${DIR}/patches/dsp/0-devices-dspbridge-phys-mem.diff
patch -s -p1 < ${DIR}/patches/dsp/0-add-bootmem.diff
patch -s -p1 < ${DIR}/patches/dsp/0002-DSPBRIDGE-camel-case-removal.patch
patch -s -p1 < ${DIR}/patches/dsp/0003-DSPBRIDGE-Remove-autoconf.h-dependency-from-host_os-.patch
patch -s -p1 < ${DIR}/patches/dsp/0004-DSPBRIDGE-Fix-header-locations-mach-to-plat.patch
patch -s -p1 < ${DIR}/patches/dsp/0005-DSPBRIDGE-Change-dspbridge-for-open-source-mailbox-i.patch
patch -s -p1 < ${DIR}/patches/dsp/0006-DSPBRIDGE-Remove-custom-mailbox-related-files.patch
patch -s -p1 < ${DIR}/patches/dsp/0007-DSPBRIDGE-Remove-chnl_sm.h-and-tiomap_sm.c.patch

#patch -s -p1 < ${DIR}/patches/dsp/0008-Mailbox-free-mailbox-interrupt-before-freeing-blk-qu.patch
#patch -s -p1 < ${DIR}/patches/dsp/0009-Mailbox-flush-pending-deferred-works-before-freeing-.patch
patch -s -p1 < ${DIR}/patches/dsp/0009-Mailbox-flush-pending-deferred-works-before-freeing-fixup.patch

patch -s -p1 < ${DIR}/patches/dsp/0010-DSPBRIDGE-fix-checkpatch-error-introduced-with-mailb.patch
patch -s -p1 < ${DIR}/patches/dsp/0011-DSPBRIDGE-Fix-obvious-wrong-comment-formats-in-mbox-.patch
patch -s -p1 < ${DIR}/patches/dsp/0012-DSPBRIDGE-auto-select-mailbox-when-compiling-bridge.patch
patch -s -p1 < ${DIR}/patches/dsp/0013-DSPBRIDGE-DSP-recovery-feature.patch
patch -s -p1 < ${DIR}/patches/dsp/0014-DSPBRIDGE-replace-sync_enter-leave_cs-with-mutexts-o.patch
patch -s -p1 < ${DIR}/patches/dsp/0015-DSPBRIDGE-replace-sync_enter-leave_cs-for-tasklets-w.patch
patch -s -p1 < ${DIR}/patches/dsp/0016-DSPBRIDGE-modify-sync-event-functions-to-use-complet.patch
patch -s -p1 < ${DIR}/patches/dsp/0017-DSPBRIDGE-cleanup-to-sync-module.patch
patch -s -p1 < ${DIR}/patches/dsp/0018-DSPBRIDGE-remove-ntfy_init-exit-functions.patch
patch -s -p1 < ${DIR}/patches/dsp/0019-DSPBRIDGE-allocation-of-ntfy-object-take-out-of-ntfy.patch
patch -s -p1 < ${DIR}/patches/dsp/0020-DSPBRIDGE-simplify-and-make-more-use-of-kernel-funct.patch
patch -s -p1 < ${DIR}/patches/dsp/0021-DSPBRIDGE-add-checking-128-byte-alignment-for-dsp-ca.patch
patch -s -p1 < ${DIR}/patches/dsp/0022-DSPBRIDGE-Distinguish-between-read-or-write-buffers.patch
patch -s -p1 < ${DIR}/patches/dsp/0023-DSPBRIDGE-change-to-cpufreq_register_notifier-for-OP.patch
patch -s -p1 < ${DIR}/patches/dsp/0024-dsp-bridge-deh-remove-obvious-comments.patch
patch -s -p1 < ${DIR}/patches/dsp/0025-dsp-bridge-deh-remove-unnecessary-casts.patch
patch -s -p1 < ${DIR}/patches/dsp/0026-dsp-bridge-deh-improve-logging-stuff.patch
patch -s -p1 < ${DIR}/patches/dsp/0027-dsp-bridge-deh-report-mmu-faults-as-errors.patch
patch -s -p1 < ${DIR}/patches/dsp/0028-dsp-bridge-deh-decrease-nesting-levels.patch
patch -s -p1 < ${DIR}/patches/dsp/0029-dsp-bridge-deh-fix-obvious-return-codes.patch
patch -s -p1 < ${DIR}/patches/dsp/0030-dsp-bridge-deh-reorganize-create.patch
patch -s -p1 < ${DIR}/patches/dsp/0031-dsp-bridge-deh-fix-hdeh_mgr-silliness.patch
patch -s -p1 < ${DIR}/patches/dsp/0032-dsp-bridge-deh-fix-dummy_va_addr.patch
patch -s -p1 < ${DIR}/patches/dsp/0033-DSPBRIDGE-Fix-declaration-and-initialization-of-sync.patch
patch -s -p1 < ${DIR}/patches/dsp/0034-DSPBRIDGE-replace-error-code-DSP_EFAIL-for-EPERM.patch
patch -s -p1 < ${DIR}/patches/dsp/0035-DSPBRIDGE-replace-error-code-REG_E_NOMOREITEMS-for-E.patch
patch -s -p1 < ${DIR}/patches/dsp/0036-DSPBRIDGE-replace-error-code-REG_E_INVALIDSUBKEY-for.patch
patch -s -p1 < ${DIR}/patches/dsp/0037-DSPBRIDGE-replace-error-code-COD_E_OPENFAILED-for-EB.patch
patch -s -p1 < ${DIR}/patches/dsp/0038-DSPBRIDGE-replace-error-code-CFG_E_RESOURCENOTAVAIL-.patch
patch -s -p1 < ${DIR}/patches/dsp/0039-DSPBRIDGE-replace-error-code-CFG_E_INVALIDHDEVNODE-f.patch
patch -s -p1 < ${DIR}/patches/dsp/0040-DSPBRIDGE-replace-error-code-CFG_E_INVALIDPOINTER-fo.patch
patch -s -p1 < ${DIR}/patches/dsp/0041-DSPBRIDGE-replace-error-code-DSP_ESTRMMODE-for-EPERM.patch
patch -s -p1 < ${DIR}/patches/dsp/0042-DSPBRIDGE-replace-error-code-DSP_EALIGNMENT-for-EPER.patch
patch -s -p1 < ${DIR}/patches/dsp/0043-DSPBRIDGE-replace-error-code-DSP_EFREAD-for-EBADF.patch
patch -s -p1 < ${DIR}/patches/dsp/0044-DSPBRIDGE-replace-error-code-DSP_ENOMORECONNECTIONS-.patch
patch -s -p1 < ${DIR}/patches/dsp/0045-DSPBRIDGE-replace-error-code-DSP_ESTREAMFULL-for-ENO.patch
patch -s -p1 < ${DIR}/patches/dsp/0046-DSPBRIDGE-replace-error-code-DSP_EDIRECTION-for-EPER.patch
patch -s -p1 < ${DIR}/patches/dsp/0047-DSPBRIDGE-replace-error-code-WMD_E_TIMEOUT-for-ETIME.patch
patch -s -p1 < ${DIR}/patches/dsp/0048-DSPBRIDGE-replace-error-code-CHNL_E_CANCELLED-for-EC.patch
patch -s -p1 < ${DIR}/patches/dsp/0049-DSPBRIDGE-replace-error-code-CHNL_E_CHANBUSY-for-EAL.patch
patch -s -p1 < ${DIR}/patches/dsp/0050-DSPBRIDGE-replace-error-code-DSP_ENOTCONNECTED-for-E.patch
patch -s -p1 < ${DIR}/patches/dsp/0051-DSPBRIDGE-replace-error-code-DSP_EUUID-for-ENOKEY.patch
patch -s -p1 < ${DIR}/patches/dsp/0052-DSPBRIDGE-replace-error-code-DSP_EVALUE-for-EINVAL.patch
patch -s -p1 < ${DIR}/patches/dsp/0053-DSPBRIDGE-replace-error-code-DSP_ETIMEOUT-for-ETIME.patch
patch -s -p1 < ${DIR}/patches/dsp/0054-DSPBRIDGE-replace-error-code-DSP_ESIZE-for-EINVAL.patch
patch -s -p1 < ${DIR}/patches/dsp/0055-DSPBRIDGE-replace-error-code-DSP_ERANGE-for-EDOM.patch
patch -s -p1 < ${DIR}/patches/dsp/0056-DSPBRIDGE-replace-error-code-DSP_EPOINTER-for-EFAULT.patch
patch -s -p1 < ${DIR}/patches/dsp/0057-DSPBRIDGE-replace-error-code-DSP_EFOPEN-for-EBADF.patch
patch -s -p1 < ${DIR}/patches/dsp/0058-DSPBRIDGE-replace-error-code-DSP_ENOTIMPL-for-ENOSYS.patch
patch -s -p1 < ${DIR}/patches/dsp/0059-DSPBRIDGE-replace-error-code-DSP_ENODETYPE-for-EPERM.patch
patch -s -p1 < ${DIR}/patches/dsp/0060-DSPBRIDGE-replace-error-code-DSP_EMEMORY-for-ENOMEM.patch
patch -s -p1 < ${DIR}/patches/dsp/0061-DSPBRIDGE-replace-error-code-DSP_EINVALIDARG-for-EIN.patch
patch -s -p1 < ${DIR}/patches/dsp/0062-DSPBRIDGE-replace-error-code-DSP_EHANDLE-for-EFAULT.patch
patch -s -p1 < ${DIR}/patches/dsp/0063-DSPBRIDGE-replace-error-code-DSP_EFILE-for-ENOENT.patch
patch -s -p1 < ${DIR}/patches/dsp/0064-DSPBRIDGE-replace-error-code-DSP_ECORRUPTFILE-for-EB.patch
patch -s -p1 < ${DIR}/patches/dsp/0065-DSPBRIDGE-replace-error-code-DSP_EALREADYCONNECTED-f.patch
patch -s -p1 < ${DIR}/patches/dsp/0066-DSPBRIDGE-Cleanup-unused-custom-error-codes.patch
patch -s -p1 < ${DIR}/patches/dsp/0067-DSPBRIDGE-Remove-unused-success-codes.patch

#patch -s -p1 < ${DIR}/patches/dsp/0068-DSPBRIDGE-Implement-WDT3-to-notify-DSP-hangs.patch
patch -s -p1 < ${DIR}/patches/dsp/0068-DSPBRIDGE-Implement-WDT3-to-notify-DSP-hangs-fixup.patch

patch -s -p1 < ${DIR}/patches/dsp/0069-DSPBRIDGE-Change-dev_type-to-u8.patch
patch -s -p1 < ${DIR}/patches/dsp/0070-DSPBRIDGE-Change-dw_state-type-to-u8.patch
patch -s -p1 < ${DIR}/patches/dsp/0071-DSPBRIDGE-Change-channel-mode-type-to-s8.patch
patch -s -p1 < ${DIR}/patches/dsp/0072-DSPBRIDGE-Change-dw_type-to-u8.patch
patch -s -p1 < ${DIR}/patches/dsp/0073-DSPBRIDGE-Change-max-channels-open-channels-type-to-.patch
patch -s -p1 < ${DIR}/patches/dsp/0074-DSPBRIDGE-Change-num_proc-type-to-u8.patch
patch -s -p1 < ${DIR}/patches/dsp/0075-DSPBRIDGE-Change-imode-type-to-u8.patch
patch -s -p1 < ${DIR}/patches/dsp/0076-DSPBRIDGE-remove-unused-module-parameters.patch
patch -s -p1 < ${DIR}/patches/dsp/0077-DSPBRIDGE-remove-HW_DSPSS_BootModeSet-function.patch
patch -s -p1 < ${DIR}/patches/dsp/0078-DSPBRIDGE-remove-hw_prcm-module-and-related-function.patch
patch -s -p1 < ${DIR}/patches/dsp/0079-DSPBRIDGE-MMU-Fault-debugging-enhancements.patch
patch -s -p1 < ${DIR}/patches/dsp/0080-DSPBRIDGE-Remove-DSP-resources-from-registry.patch
patch -s -p1 < ${DIR}/patches/dsp/0081-DSPBRIDGE-Remove-host-resource-from-registry.patch
patch -s -p1 < ${DIR}/patches/dsp/0082-DSPBRIDGE-Remove-initial-configuration-data-from-reg.patch
patch -s -p1 < ${DIR}/patches/dsp/0083-DSPBRIDGE-Remove-handles-from-registry.patch
patch -s -p1 < ${DIR}/patches/dsp/0084-DSPBRIDGE-Remove-Reg-module-from-services.patch
patch -s -p1 < ${DIR}/patches/dsp/0085-DSPBRIDGE-Replace-mem_calloc-by-kzalloc-or-__vmalloc.patch
patch -s -p1 < ${DIR}/patches/dsp/0086-DSPBRIDGE-Replace-mem_alloc-by-kmalloc.patch
patch -s -p1 < ${DIR}/patches/dsp/0087-DSPBRIDGE-Moving-functions-from-mem.c-to-drv.c.patch
patch -s -p1 < ${DIR}/patches/dsp/0088-DSPBRIDGE-Moving-macros-from-mem.h-to-drv.h.patch
patch -s -p1 < ${DIR}/patches/dsp/0089-DSPBRIDGE-Remove-mem_init-and-mem_exit-functions.patch
patch -s -p1 < ${DIR}/patches/dsp/0090-DSPBRIDGE-Replace-MEM_ALLOC_OBJECT-macro-by-kzalloc-.patch
patch -s -p1 < ${DIR}/patches/dsp/0091-DSPBRIDGE-Replace-MEM_FREE_OBJECT-macro-by-kfree-fun.patch
patch -s -p1 < ${DIR}/patches/dsp/0092-DSPBRIDGE-Check-pointer-instead-of-using-MEM_IS_VALI.patch
patch -s -p1 < ${DIR}/patches/dsp/0093-DSPBRIDGE-Remove-mem.c-and-mem.h-files.patch
patch -s -p1 < ${DIR}/patches/dsp/0094-DSPBRIDGE-Remove-CHNL_IS_VALID_MGR-and-CHNL_IS_VALID.patch
patch -s -p1 < ${DIR}/patches/dsp/0095-DSPBRIDGE-Remove-IS_VALID_HANDLE-function-and-macro.patch
patch -s -p1 < ${DIR}/patches/dsp/0096-DSPBRIDGE-Remove-dw_signature-field-from-structures.patch
patch -s -p1 < ${DIR}/patches/dsp/0097-DSPBRIDGE-Remove-signature-definitions-used-for-obje.patch
patch -s -p1 < ${DIR}/patches/dsp/0098-DSPBRIDGE-remove-clk_handle-from-drv-interface.patch
patch -s -p1 < ${DIR}/patches/dsp/0099-DSPBRIDGE-fail-if-clk-handle-is-NULL.patch
patch -s -p1 < ${DIR}/patches/dsp/0100-DSPBRIDGE-Now-actually-fail-if-a-clk-handle-is-wrong.patch
patch -s -p1 < ${DIR}/patches/dsp/0101-DSPBRIDGE-Rename-services_clk_-to-dsp_clk_.patch
patch -s -p1 < ${DIR}/patches/dsp/0102-DSPBRIDGE-remove-unused-clock-sys_ck.patch
patch -s -p1 < ${DIR}/patches/dsp/0103-DSPBRIDGE-remove-function-clk_set32k_hz.patch
patch -s -p1 < ${DIR}/patches/dsp/0104-DSPBRIDGE-remove-clk_get_use_cnt.patch
patch -s -p1 < ${DIR}/patches/dsp/0105-DSPBRIDGE-trivial-clock-cleanup-for-unused-code.patch
patch -s -p1 < ${DIR}/patches/dsp/0106-DSPBRIDGE-function-to-get-the-type-of-clock-requeste.patch
patch -s -p1 < ${DIR}/patches/dsp/0107-DSPBRIDGE-iva2-clock-handling.patch
patch -s -p1 < ${DIR}/patches/dsp/0108-DSPBRIDGE-use-dm-timer-framework-for-gpt-timers.patch
patch -s -p1 < ${DIR}/patches/dsp/0109-DSPBRIDGE-use-omap-mcbsp-to-enable-mcbsp-clocks.patch
patch -s -p1 < ${DIR}/patches/dsp/0110-DSPBRIDGE-remove-wdt3-from-dsp-control.patch
patch -s -p1 < ${DIR}/patches/dsp/0111-DSPBRIDGE-dsp-interface-to-enable-ssi-clocks.patch
patch -s -p1 < ${DIR}/patches/dsp/0112-DSPBRIDGE-use-one-call-for-both-ick-and-fck-clocks.patch
patch -s -p1 < ${DIR}/patches/dsp/0113-DSPBRIDGE-Move-MCBSP_CLOCKS-code-to-a-common-place.patch
patch -s -p1 < ${DIR}/patches/dsp/0114-DSPBRIDGE-Balance-the-number-of-enable-disable.patch
patch -s -p1 < ${DIR}/patches/dsp/0115-DSPBRIDGE-move-clk-to-dsp-clock.patch
patch -s -p1 < ${DIR}/patches/dsp/0116-DSPBRIDGE-reorganize-the-code-to-handle-peripheral-c.patch
patch -s -p1 < ${DIR}/patches/dsp/0117-DSPBRIDGE-Remove-checkpatch-errors-regarding-braces.patch
patch -s -p1 < ${DIR}/patches/dsp/0118-DSPBRIDGE-Remove-checkpatch-warnings-80-char-lines.patch
patch -s -p1 < ${DIR}/patches/dsp/0119-DSPBRIDGE-Remove-checkpatch-errors-externs.patch
patch -s -p1 < ${DIR}/patches/dsp/0120-DSPBRIDGE-Remove-checkpatch-errors-regarding-typedef.patch
patch -s -p1 < ${DIR}/patches/dsp/0121-DSPBRIDGE-Removes-checkpatch-error-with-file_operati.patch
patch -s -p1 < ${DIR}/patches/dsp/0122-DSPBRIDGE-Rename-wmd_dev_context-structure-by-bridge.patch
patch -s -p1 < ${DIR}/patches/dsp/0123-DSPBRIDGE-Rename-the-device-context-handle-variables.patch
patch -s -p1 < ${DIR}/patches/dsp/0124-DSPBRIDGE-Rename-variables-and-structures-which-cont.patch
patch -s -p1 < ${DIR}/patches/dsp/0125-DSPBRIDGE-Rename-functions-which-contain-wmd-and-rem.patch
patch -s -p1 < ${DIR}/patches/dsp/0126-DSPBRIDGE-Replace-code-containing-WMD.patch
patch -s -p1 < ${DIR}/patches/dsp/0127-DSPBRIDGE-Replace-code-containing-wcd.patch
patch -s -p1 < ${DIR}/patches/dsp/0128-DSPBRIDGE-Rename-wmd-directory-by-core.patch
patch -s -p1 < ${DIR}/patches/dsp/0129-DSPBRIDGE-Rename-files-that-refer-to-Windows-OS.patch
patch -s -p1 < ${DIR}/patches/dsp/0130-DSPBRIDGE-Append-the-content-of-_dcd.h-into-dspapi.h.patch
patch -s -p1 < ${DIR}/patches/dsp/0131-DSPBRIDGE-Remove-OS-specific-comments.patch
patch -s -p1 < ${DIR}/patches/dsp/0132-DSPBRIDGE-Rename-header-file-guard-macros-that-coint.patch
patch -s -p1 < ${DIR}/patches/dsp/0133-DSPBRIDGE-fix-a-wrong-clk-index-for-gpt8.patch
patch -s -p1 < ${DIR}/patches/dsp/0134-DSPBRIDGE-reorganize-gpt8-overflow-handling.patch
patch -s -p1 < ${DIR}/patches/dsp/0135-DSPBRIDGE-move-gpt-request-free-to-dsp_clk-init-exit.patch

#2.6.34
patch -s -p1 < ${DIR}/patches/dsp/0x-PM_PWSTST-to-OMAP2_PM_PWSTST.diff
patch -s -p1 < ${DIR}/patches/dsp/1x-PM_PWSTST-to-OMAP2_PM_PWSTST.diff
patch -s -p1 < ${DIR}/patches/dsp/0x-PM_PWSTCTRL-to-OMAP2_PM_PWSTCTRL.diff
patch -s -p1 < ${DIR}/patches/dsp/0x-CM_CLKSTCTRL-to-OMAP2_CM_CLKSTCTRL.diff
patch -s -p1 < ${DIR}/patches/dsp/0x-RM_RSTCTRL-to-OMAP2_RM_RSTCTRL.diff

#2.6.34 - https://patchwork.kernel.org/patch/101894/
patch -s -p1 < ${DIR}/patches/dsp/v2-1-7-DSPBRIDGE-enhance-dmm_map_object.patch
patch -s -p1 < ${DIR}/patches/dsp/v2-2-7-DSPBRIDGE-maintain-mapping-and-page-info.patch
patch -s -p1 < ${DIR}/patches/dsp/v2-3-7-DSPBRIDGE-do-not-call-follow_page.patch
patch -s -p1 < ${DIR}/patches/dsp/v2-4-7-DSPBRIDGE-do-not-use-low-level-cache-manipulation-API.patch
patch -s -p1 < ${DIR}/patches/dsp/v2-5-7-DSPBRIDGE-remove-mem_flush_cache.patch
patch -s -p1 < ${DIR}/patches/dsp/v2-6-7-DSPBRIDGE-add-dspbridge-API-to-mark-end-of-DMA.patch
patch -s -p1 < ${DIR}/patches/dsp/v2-7-7-DSPBRIDGE-add-new-PROC_BEGINDMA-and-PROC_ENDDMA-ioctls.patch

}

dss2
musb
#vfp
micrel
zippy
xm
nand
sgx
dsp

echo "patch.sh ran successful"

