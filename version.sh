#!/bin/bash

unset BUILD

#Check for dependencies
MKIMAGE=`which mkimage 2> /dev/null`
CCACHE=`which ccache 2> /dev/null`
NCURSES=`file /usr/lib/libncurses.so | grep -v ERROR 2> /dev/null`
GIT=`which git 2> /dev/null`

if test "-$MKIMAGE-" = "--" || test "-$CCACHE-" = "--" || test "-$NCURSES-" = "--" || test "-$GIT-" = "--"
then
  echo "Need to install uboot-mkimage, ccache, and libncurses5-dev dependencies"
  sudo aptitude install uboot-mkimage ccache libncurses5-dev git-core
fi

KERNEL_REL=2.6.33
#Stable Kernel
STABLE_PATCH=2
KERNEL_PATCH=${KERNEL_REL}.${STABLE_PATCH}
DL_PATCH=patch-${KERNEL_PATCH}
ABI=0

if [ "${IS_ZIPPY_TWO}" ] ; then
BUILD=zippy2.
fi

if [ "${IS_LUCID}" ] ; then
BUILD+=l${ABI}
else
BUILD+=x${ABI}
fi

BRANCH=master
REL=v2.6.32
GIT=v2.6.32-omap1

#USB patches is board specific
BOARD=beagleboard

BUILDREV=1.0
DISTRO=cross

export KERNEL_REL BUILD RC_PATCH KERNEL_PATCH
export BRANCH REL GIT
export BOARD BUILDREV DISTRO
