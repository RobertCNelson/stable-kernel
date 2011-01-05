#!/bin/bash -e
#yeah, i'm getting lazy..

REPO=2.6-stable

DIR=$PWD

if [ -e ${DIR}/version.sh ]; then
	. version.sh

	if [ "${KERNEL_PATCH}" ] ; then
		bzr commit -m "${KERNEL_REL}.${STABLE_PATCH}-${BUILD} release"
		bzr tag "${KERNEL_REL}.${STABLE_PATCH}-${BUILD}"
		bzr push lp:~beagleboard-kernel/+junk/${REPO}
	else
		bzr commit -m "${KERNEL_REL}-${BUILD} release"
		bzr tag "${KERNEL_REL}-${BUILD}"
		bzr push lp:~beagleboard-kernel/+junk/${REPO}
	fi
fi

