#!/bin/bash

unset BUILD

KERNEL_REL=2.6.33
#Stable Kernel
STABLE_PATCH=3
KERNEL_PATCH=${KERNEL_REL}.${STABLE_PATCH}
DL_PATCH=patch-${KERNEL_PATCH}
ABI=1

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
