#!/bin/bash

#Check for Dependices
MKIMAGE=`which mkimage 2> /dev/null`
CCACHE=`which ccache 2> /dev/null`
NCURSES=`file /usr/lib/libncurses.so | grep -v ERROR 2> /dev/null`

if test "-$MKIMAGE-" = "--" || test "-$CCACHE-" = "--" || test "-$NCURSES-" = "--"
then
  echo "Need to install uboot-mkimage, ccache, and libncurses5-dev dependicy"
  sudo aptitude install uboot-mkimage ccache libncurses5-dev
fi

KERNEL_REL=2.6.31
#Stable Kernel
STABLE_PATCH=9
KERNEL_PATCH=${KERNEL_REL}.${STABLE_PATCH}
DL_PATCH=patch-${KERNEL_PATCH}
BUILD=x${STABLE_PATCH}.0
##RC Kernel
#RC_PATCH=rc4
#KERNEL_PATCH=2.6.32-${RC_PATCH}
#DL_PATCH=testing/patch-${KERNEL_PATCH}
#BUILD=${RC_PATCH}.1

GIT=945044d

PV=1.3.13.1607

#USB patches is board specific
BOARD=beagleboard

BUILDREV=1.0
DISTRO=jaunty

export KERNEL_REL STABLE_PATCH KERNEL_PATCH DL_PATCH BUILD GIT BOARD PV BUILDREV DISTRO
