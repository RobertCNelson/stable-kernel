#!/bin/bash
DIR=$PWD
mkdir -p ${DIR}/patches/angstrom
cd ~/git_repo/openembedded/
git pull
git checkout origin/org.openembedded.dev -b upstream-copy
cp -rv ~/git_repo/openembedded/recipes/linux/linux-omap-2.6.31/* ${DIR}/patches/angstrom
cp -rv ~/git_repo/openembedded/recipes/linux/linux-omap_2.6.31.bb ${DIR}/patches/angstrom
cp -rv ~/git_repo/openembedded/recipes/powervr-drivers/omap3-sgx-modules/* ${DIR}/sgx
git checkout origin/org.openembedded.dev -f
git branch upstream-copy -D
cd ${DIR}/
bzr add ${DIR}/patches/angstrom
bzr add ${DIR}/sgx
bzr diff > check.diff
gedit check.diff *.sh ${DIR}/patches/angstrom/linux-omap_2.6.31.bb &


