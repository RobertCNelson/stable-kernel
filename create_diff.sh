#!/bin/bash
#Expects: 
#git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap-2.6 in ~/git_repo/linux-omap-2.6

. version.sh

DIR=$PWD

mkdir -p ${DIR}/patches/
mkdir -p ${DIR}/dl

cd ~/git_repo/linux-omap-2.6

git fetch
git checkout origin/${BRANCH} -b TEMP123
git diff ${REL} ${GIT} > ${DIR}/patches/${BRANCH}-patch-from-${REL}-to-${GIT}.diff
git checkout master -f
git branch TEMP123 -D

cd ${DIR}

bzr add ${DIR}/patches/${BRANCH}-patch-from-${REL}-to-${GIT}.diff

gedit ${DIR}/patches/${BRANCH}-patch-from-${REL}-to-${GIT}.diff &


