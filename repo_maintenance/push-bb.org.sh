#!/bin/sh -e
#
# Copyright (c) 2009-2017 Robert Nelson <robertcnelson@gmail.com>
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

#yeah, i'm getting lazy..

DIR=$PWD
git_bin=$(which git)

repo="git@github.com:beagleboard/linux.git"
example="bb.org"
compare="https://github.com/RobertCNelson/ti-linux-kernel/compare"

if [ -e ${DIR}/version.sh ]; then
	unset BRANCH
	. ${DIR}/version.sh

	cd ${DIR}/KERNEL/
	make ARCH=${KERNEL_ARCH} distclean

	cp ${DIR}/patches/defconfig ${DIR}/KERNEL/.config
	make ARCH=${KERNEL_ARCH} savedefconfig
	cp ${DIR}/KERNEL/defconfig ${DIR}/KERNEL/arch/${KERNEL_ARCH}/configs/${example}_defconfig
	${git_bin} add arch/${KERNEL_ARCH}/configs/${example}_defconfig

	if [ "x${ti_git_old_release}" = "x${ti_git_post}" ] ; then
		${git_bin} commit -a -m "${KERNEL_TAG}${BUILD} ${example}_defconfig" -s
	else
		${git_bin} commit -a -m "${KERNEL_TAG}${BUILD} ${example}_defconfig" -m "${KERNEL_REL} TI Delta: ${compare}/${ti_git_old_release}...${ti_git_post}" -s
	fi

	${git_bin} tag -a "${KERNEL_TAG}${BUILD}" -m "${KERNEL_TAG}${BUILD}" -f

	#push tag
	${git_bin} push -f ${repo} "${KERNEL_TAG}${BUILD}"

	echo "debug: pushing ${bborg_branch}"

	${git_bin} branch -D ${bborg_branch} || true

	${git_bin} branch -m v${KERNEL_TAG}${BUILD} ${bborg_branch}

	#push branch
	echo "log: git push -f ${repo} ${bborg_branch}"
	${git_bin} push -f ${repo} ${bborg_branch}

	cd ${DIR}/
fi

