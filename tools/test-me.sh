#!/bin/sh -e
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

fileserver="http://rcn-ee.homeip.net:81/dl/jenkins/beagleboard.org"

network_failure () {
	echo "Error: is network setup?"
	exit
}

dl_latest () {
	wget --directory-prefix="${tempdir}/dl/" ${fileserver}/latest
	if [ -f "${tempdir}/dl/latest" ] ; then
		. "${tempdir}/dl/latest"
		echo "ABI:${abi}"
		echo "Kernel:${kernel}"
	else
		network_failure
	fi
}

validate_abi () {
	if [ ! "x${abi}" = "xaaa" ] ; then
		echo "abi mismatch, please redownload test-me.sh from:"
		echo "http://rcn-ee.homeip.net:81/dl/jenkins/beagleboard.org/"
		echo "-----------------------------"
		echo "rm -rf ./test-me.sh"
		echo "wget http://rcn-ee.homeip.net:81/dl/jenkins/beagleboard.org/test-me.sh"
		echo "chmod +x ./test-me.sh"
		echo "-----------------------------"
		exit
	fi
}

file_download () {
	if [ -f /boot/zImage ] ; then
		echo "Downloading: zImage"
		wget --directory-prefix="${tempdir}/dl/" ${fileserver}/${kernel}/${kernel}.zImage.xz
		if [ ! -f "${tempdir}/dl/${kernel}.zImage.xz" ] ; then
			network_failure
		fi
	fi
	if [ -f /boot/uImage ] ; then
		echo "Downloading: uImage"
		wget --directory-prefix="${tempdir}/dl/" ${fileserver}/${kernel}/${kernel}.uImage.xz
		if [ ! -f "${tempdir}/dl/${kernel}.uImage.xz" ] ; then
			network_failure
		fi
	fi
	echo "Downloading: dtbs"
	wget --directory-prefix="${tempdir}/dl/" ${fileserver}/${kernel}/${kernel}-dtbs.tar.xz
	if [ ! -f "${tempdir}/dl/${kernel}-dtbs.tar.xz" ] ; then
		network_failure
	fi
	echo "Downloading: firmware"
	wget --directory-prefix="${tempdir}/dl/" ${fileserver}/${kernel}/${kernel}-firmware.tar.xz
	if [ ! -f "${tempdir}/dl/${kernel}-firmware.tar.xz" ] ; then
		network_failure
	fi
	echo "Downloading: modules"
	wget --directory-prefix="${tempdir}/dl/" ${fileserver}/${kernel}/${kernel}-modules.tar.xz
	if [ ! -f "${tempdir}/dl/${kernel}-modules.tar.xz" ] ; then
		network_failure
	fi
}

file_backup () {
	echo "Backing up files..."
	if [ -d "/boot/`uname -r`/" ] ; then
		rm -rf "/boot/`uname -r`/" || true
	fi
	mkdir -p /boot/`uname -r`.bak/firmware || true
	mkdir -p /boot/`uname -r`.bak/modules || true
	if [ -f /boot/zImage ] ; then
		cp -v /boot/zImage /boot/`uname -r`.bak/zImage
	fi
	if [ -f /boot/uImage ] ; then
		cp -v /boot/uImage /boot/`uname -r`.bak/uImage
	fi
	cp -v /boot/*.dtb /boot/`uname -r`.bak/  || true

	cp -u /lib/firmware/*dtbo /boot/`uname -r`.bak/firmware || true
	cp -u /lib/firmware/*dts /boot/`uname -r`.bak/firmware || true
	cp -ru /lib/modules/`uname -r`/* /boot/`uname -r`.bak/modules || true
}

install_files () {
	echo "Installing files.."
	if [ -f /boot/zImage ] ; then
		unxz ${tempdir}/dl/${kernel}.zImage.xz
		rm -rf /boot/zImage || true
		mv -v ${tempdir}/dl/${kernel}.zImage /boot/zImage
	fi
	if [ -f /boot/uImage ] ; then
		unxz ${tempdir}/dl/${kernel}.uImage.xz
		rm -rf /boot/uImage || true
		mv -v ${tempdir}/dl/${kernel}.zImage /boot/uImage
	fi

	tar xfv ${tempdir}/dl/${kernel}-dtbs.tar.xz -C /boot/
	tar xfv ${tempdir}/dl/${kernel}-modules.tar.xz -C /
	tar xfv ${tempdir}/dl/${kernel}-firmware.tar.xz -C ${tempdir}/dl/extract
	cp ${tempdir}/dl/extract/*.dtbo /lib/firmware/ || true
	cp ${tempdir}/dl/extract/*.dts /lib/firmware/ || true
	sync
	echo "Please reboot..."
}

workingdir="$PWD"
tempdir=$(mktemp -d)
mkdir -p ${tempdir}/dl/extract || true

dl_latest
validate_abi
file_download
file_backup
install_files

