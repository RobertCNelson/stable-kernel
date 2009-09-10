#!/bin/bash
DIR=$PWD
cd ~/git_repo/openembedded/
git pull
cp -rv ~/git_repo/openembedded/recipes/linux/linux-omap-2.6.29/* ${DIR}/angstrom
cd ${DIR}/
bzr add angstrom/
bzr diff > check.diff
gedit check.diff build_kernel.sh &


