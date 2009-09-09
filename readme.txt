angstrom: External Patches from Angstrom Tree: r44
diffs: diffs from upstream kernels to make it easier for people to build these
sgx: 1.3.13.1607
patches: Tweaks not sent upstream.

001-enable_IS08859_1.diff: 
Needed for access to fat filesystem, when booted with no modules. 
This can be removed when uboot's ext2load is supported again.

002-Disable_CONFIG_Gadget.diff:
Needed for Rev Bx boards that have the root parition on a usb harddrive
(Such as my builders)



