#!/bin/bash -e
#yeah, i'm getting lazy..

unset IS_LUCID

DIR=$PWD

if [ -e ${DIR}/version.sh ]; then
	. version.sh

	if [ "${KERNEL_PATCH}" ] ; then
		bzr commit -m "${KERNEL_REL}.${STABLE_PATCH}-${BUILD} release"
		bzr tag "${KERNEL_REL}.${STABLE_PATCH}-${BUILD}"
		bzr push lp:~beagleboard-kernel/+junk/2.6-stable
	else
		bzr commit -m "${KERNEL_REL}-${BUILD} release"
		bzr tag "${KERNEL_REL}.${STABLE_PATCH}"
		bzr push lp:~beagleboard-kernel/+junk/2.6-stable
	fi
fi

