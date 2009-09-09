#!/bin/bash
#Expects: 
#git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap-2.6 in ~/git_repo/linux-omap-2.6

START=v2.6.29
END=58cf2f1

NAME=${START}-${END}

DIR=$PWD

cd ~/git_repo/linux-omap-2.6

git pull
git checkout ${START} -b ${START}-omap
git archive --format=tar --prefix=${START}/ ${START} | gzip > ${DIR}/dl/${START}.tar.gz
git checkout master
git branch ${START}-omap -D

git checkout ${END} -b ${END}-omap
git archive --format=tar --prefix=${END}/ ${END} | gzip > ${DIR}/dl/${END}.tar.gz
git checkout master
git branch ${END}-omap -D

mkdir -p ${DIR}/tmp
cd ${DIR}/tmp

tar -xf ${DIR}/dl/${START}.tar.gz
tar -xf ${DIR}/dl/${END}.tar.gz

diff -urN ${START}/ ${END}/ > ${DIR}/diffs/patch-${NAME}.diff

cd ${DIR}

rm -rfd ${DIR}/tmp

rm ${DIR}/dl/${START}.tar.gz ${DIR}/dl/${END}.tar.gz


