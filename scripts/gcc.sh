#!/bin/bash -e
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

ARCH=$(uname -m)
DIR=$PWD

source ${DIR}/system.sh

ubuntu_arm_gcc_installed () {
	unset armel_pkg
	unset armhf_pkg
	if [ $(which lsb_release) ] ; then
		distro=$(lsb_release -is)
		if [ "x${distro}" == "xUbuntu" ] ; then
			distro_release=$(lsb_release -cs)

			case "${distro_release}" in
			maverick|natty|oneiric|precise|quantal|raring)
				#http://packages.ubuntu.com/raring/gcc-arm-linux-gnueabi
				armel_pkg="gcc-arm-linux-gnueabi"
				;;
			esac

			case "${distro_release}" in
			oneiric|precise|quantal|raring)
				#http://packages.ubuntu.com/raring/gcc-arm-linux-gnueabihf
				armhf_pkg="gcc-arm-linux-gnueabihf"
				;;
			esac

			if [ "${armel_pkg}" ] || [ "${armhf_pkg}" ] ; then
				echo "fyi: ${distro} ${distro_release} has these ARM gcc cross compilers available in their repo:"
				if [ "${armel_pkg}" ] ; then
					echo "sudo apt-get install ${armel_pkg}"
				fi
				if [ "${armhf_pkg}" ] ; then
					echo "sudo apt-get install ${armhf_pkg}"
				fi
				echo "-----------------------------"
			fi
		fi
	fi

	if [ "${armel_pkg}" ] || [ "${armhf_pkg}" ] ; then
		if [ $(which arm-linux-gnueabi-gcc) ] ; then
			armel_gcc_test=$(LC_ALL=C arm-linux-gnueabi-gcc -v 2>&1 | grep "Target:" | grep arm || true)
		fi
		if [ $(which arm-linux-gnueabihf-gcc) ] ; then
			armhf_gcc_test=$(LC_ALL=C arm-linux-gnueabihf-gcc -v 2>&1 | grep "Target:" | grep arm || true)
		fi

		if [ "x${armel_gcc_test}" != "x" ] ; then
			export CC="arm-linux-gnueabi-"
		fi
		if [ "x${armhf_gcc_test}" != "x" ] ; then
			export CC="arm-linux-gnueabihf-"
		fi
	fi
}

if [ "x${CC}" == "x" ] && [ "x${ARCH}" != "xarmv7l" ] ; then
	ubuntu_arm_gcc_installed

	if [ "x${CC}" == "x" ] ; then
		echo "-----------------------------"
		echo "Error: You haven't setup the Cross Compiler (CC variable) in system.sh"
		echo ""
		echo "with a (sane editor) open system.sh and modify the commented:"
		echo "Line 18: #CC=arm-linux-gnueabi-"
		echo ""
		echo "If you need hints on installing an ARM GCC Cross ToolChain, view README file"
		echo "-----------------------------"
		exit 1
	fi
fi

GCC="gcc"
if [ "x${GCC_OVERRIDE}" != "x" ] ; then
	GCC="${GCC_OVERRIDE}"
fi

GCC_TEST=$(LC_ALL=C ${CC}${GCC} -v 2>&1 | grep "Target:" | grep arm || true)
GCC_REPORT=$(LC_ALL=C ${CC}${GCC} -v 2>&1 || true)

if [ "x${GCC_TEST}" == "x" ] ; then
	echo "-----------------------------"
	echo "scripts/gcc: Error: The GCC ARM Cross Compiler you setup in system.sh (CC variable)."
	echo "Doesn't seem to be valid for ARM, double check it's location, or that"
	echo "you chose the correct GCC Cross Compiler."
	echo ""
	echo "Output of: LC_ALL=C ${CC}${GCC} --version"
	echo "-----------------------------"
	echo "${GCC_REPORT}"
	echo "-----------------------------"
	exit 1
else
	echo "-----------------------------"
	echo "scripts/gcc: Debug Using: `LC_ALL=C ${CC}${GCC} --version`"
	echo "-----------------------------"
fi
