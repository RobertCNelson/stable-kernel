#!/bin/bash
#Expects: 
#git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap-2.6 in ~/git_repo/linux-omap-2.6

. version.sh

DIR=$PWD

mkdir -p ${DIR}/diffs
mkdir -p ${DIR}/dl

cd ~/git_repo/linux-omap-2.6

git pull
git checkout v${KERNEL_REL} -b ${KERNEL_REL}-omap
git archive --format=tar --prefix=${KERNEL_REL}/ ${KERNEL_REL} | gzip > ${DIR}/dl/${KERNEL_REL}.tar.gz
git checkout master
git branch ${KERNEL_REL}-omap -D

git checkout ${GIT} -b ${GIT}-omap
git archive --format=tar --prefix=${GIT}/ ${GIT} | gzip > ${DIR}/dl/${GIT}.tar.gz
git checkout master
git branch ${GIT}-omap -D

mkdir -p ${DIR}/tmp
cd ${DIR}/tmp

tar -xf ${DIR}/dl/${KERNEL_REL}.tar.gz
tar -xf ${DIR}/dl/${GIT}.tar.gz

diff -urN ${KERNEL_REL}/ ${GIT}/ > ${DIR}/diffs/patch-v${KERNEL_REL}-${GIT}.diff

cd ${DIR}

rm -rfd ${DIR}/tmp

rm ${DIR}/dl/${KERNEL_REL}.tar.gz ${DIR}/dl/${GIT}.tar.gz

#bzr add ${DIR}/diffs/

gedit ${DIR}/diffs/patch-v${KERNEL_REL}-${GIT}.diff &


