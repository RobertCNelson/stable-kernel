#!/bin/bash

ARCH=$(uname -m)

CORES=1
if [ "x${ARCH}" == "xx86_64" ] || [ "x${ARCH}" == "xi686" ] ; then
	CORES=$(cat /proc/cpuinfo | grep processor | wc -l)
	let CORES=$CORES+1
fi

unset GIT_OPTS
unset GIT_NOEDIT
echo "Debug: `LC_ALL=C git --version`"
LC_ALL=C git help pull | grep -m 1 -e "--no-edit" &>/dev/null && GIT_NOEDIT=1

if [ "${GIT_NOEDIT}" ] ; then
	echo "Debug: detected git 1.7.10 or later, this script will pull via [git pull --no-edit]"
	GIT_OPTS+="--no-edit"
fi

CCACHE=ccache

config="omap2plus_defconfig"

KERNEL_REL=3.0

#for x.x.X
STABLE_PATCH=38

#for x.x-rc
#RC_KERNEL=2.6.37
#RC_PATCH=-rc8

ABI=4

BUILD+=x${ABI}

BUILDREV=1.0
DISTRO=cross
DEBARCH=armel
