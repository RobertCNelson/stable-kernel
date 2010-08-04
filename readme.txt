To Build:
Kernel with Modules, easy to build and test:

"./build_kernel.sh"

SGX Modules:

"./build_sgx_modules.sh"

Debian Package

"./build_deb.sh"

Defconfig Requirement notes:

Ubuntu Lucid (10.04)

Enable "IS_LUCID=1" in system.sh

CONFIG_ARM_ERRATA_430973=y
https://bugs.launchpad.net/ubuntu/+source/fakeroot/+bug/495536

CONFIG_DEVTMPFS=y
CONFIG_DEVTMPFS_MOUNT=y
https://bugs.launchpad.net/ubuntu/lucid/+source/mountall/+bug/510130
https://lists.ubuntu.com/archives/kernel-team/2010-January/008518.html

CONFIG_ARM_THUMBEE=y
https://lists.ubuntu.com/archives/kernel-team/2010-January/008561.html

Breaks Lucid, kernel unbootable...
5/8/2010 (2.6.33.3-l1)
CONFIG_TOUCHSCREEN_USB_COMPOSITE=m

#To compare with Ubuntu's
#ubuntu git://kernel.ubuntu.com/ubuntu/ubuntu-maverick.git

#Requirements:
sudo apt-get install fakeroot build-essential
sudo apt-get install crash kexec-tools makedumpfile kernel-wedge
sudo apt-get build-dep linux
sudo apt-get install git-core libncurses5 libncurses5-dev
sudo apt-get install libelf-dev asciidoc binutils-dev

fakeroot debian/rules clean
debian/rules updateconfigs
debian/rules editconfigsdebian/rules editconfigs
