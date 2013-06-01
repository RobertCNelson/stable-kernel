#!/bin/sh -e
#
# Copyright (c) 2012 Robert Nelson <robertcnelson@gmail.com>
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

DIR=$PWD

if [ ! -f ${DIR}/patches/bisect_defconfig ] ; then
	cp ${DIR}/patches/defconfig ${DIR}/patches/bisect_defconfig
fi

cp -v ${DIR}/patches/bisect_defconfig ${DIR}/patches/defconfig

cd ${DIR}/KERNEL/
git bisect start
git bisect good v3.5
git bisect bad v3.6
git bisect bad b13bc8dda81c54a66a1c84e66f60b8feba659f28
git bisect bad 3c4cfadef6a1665d9cd02a543782d03d3e6740c6
git bisect good 90b90f60c4f8e3a8525dfeb4aec46a9c7a29c857
git bisect bad b85c14fb833e6da127188aa61b0a2aec8111bf59
git bisect bad 4d460fd3abf9a14e21d55ab9b67b6c58e26398eb
git bisect good a065de0d257779ed1b8ee6e0c005ad6b1d989cef
git bisect bad 4b7c948f558bf1d51aa25a6f621056c0acf45228
git bisect good 7142e2138b088da429d94859df0ed05b1b82607c
git bisect bad b5152415225ba0d489939778f3b85217b25036db
git bisect bad a133829e66d25e1ce293a30bcc3fb8eb653a1519
git bisect good 6f0b2c696ca340cc2da381fe693fda3f8fdb2149
git bisect good 74ea0e599215330e8964401508a5d7ec41ef15b0
git bisect bad 2c19ad43d1a4b0e376a0c764e3c2350afd018fac
git bisect bad 0e8e5c34cf1a8beaaf0a6a05c053592693bf8cb4

#0e8e5c34cf1a8beaaf0a6a05c053592693bf8cb4 is the first bad commit
#commit 0e8e5c34cf1a8beaaf0a6a05c053592693bf8cb4
#Author: Mark Brown <broonie@opensource.wolfsonmicro.com>
#Date:   Mon Jun 4 17:23:13 2012 +0100
#
#    regulator: twl: Remove references to 32kHz clock from DT bindings
#    
#    Due to the lack of a generic clock API we'd had the 32kHz clock in the
#    regulator driver but this is definitely a Linux-specific thing and now
#    we have a clock API hopefully the code can be moved elsewhere. Try to
#    avoid getting DTs deployed relying on the 32kHz clock by removing it
#    from the bindings, grep seems to tell me it's not currently used anyway.
#    
#    Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
#
#:040000 040000 7086331da71d1f3371db66abdc12c1b26f00b0e8 c1949cae198bd8b9f915cd7669bd59ed30e4140b M      Documentation
#:040000 040000 f2c0151f9d02fcc686b88d62b83e43b334368716 7de0b63d5795b2f88680272c9ee248b0f0d4481c M      drivers

git describe
cd ${DIR}/
