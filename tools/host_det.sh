#!/bin/bash -e

unset REDHAT
unset SUSE
unset DEBIAN


function detect_host {

if [ -f /etc/redhat-release ] ; then
	DIST='RedHat'
	PSUEDONAME=$(cat /etc/redhat-release | sed s/.*\(// | sed s/\)//)
	REV=$(cat /etc/redhat-release | sed s/.*release\ // | sed s/\ .*//)
	REDHAT=1
elif [ -f /etc/SuSE-release ] ; then
	DIST=$(cat /etc/SuSE-release | tr "\n" ' '| sed s/VERSION.*//)
	REV=$(cat /etc/SuSE-release | tr "\n" ' ' | sed s/.*=\ //)
	SUSE=1
elif [ -f /etc/debian_version ] ; then
	DIST="Debian Based"
	REV=""
	DEBIAN=1
fi

}

function redhat_reqs
{
	echo "Not implemented yet"
}

function suse_regs
{
	echo "Not implemented yet"
}

function debian_regs
{
unset PACKAGE
unset APT

if [ ! $(which mkimage) ];then
 echo "Missing uboot-mkimage"
 PACKAGE="uboot-mkimage "
 APT=1
fi

if [ ! $(which ccache) ];then
 echo "Missing ccache"
 PACKAGE+="ccache "
 APT=1
fi

if [ ! $(which git) ];then
 echo "Missing git"
 PACKAGE+="git-core "
 APT=1
fi

if [ ! $(file /usr/lib/libncurses.so | grep -v ERROR | awk '{print $1}') ];then
 echo "Missing ncurses"
 PACKAGE+="libncurses5-dev "
 APT=1
fi

if [ "${APT}" ];then
 echo "Installing Dependicies"
 sudo aptitude install $PACKAGE
fi
}

detect_host

if [ "${REDHAT}" ] ; then
	redhat_software
fi

if [ "${SUSE}" ] ; then
	suse_regs
fi

if [ "${DEBIAN}" ] ; then
	debian_regs
fi

