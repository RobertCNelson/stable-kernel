#!/bin/sh -e

#opensuse support added by: Antonio Cavallo
#https://launchpad.net/~a.cavallo

warning () { echo "! $@" >&2; }
error () { echo "* $@" >&2; exit 1; }
info () { echo "+ $@" >&2; }
ltrim () { echo "$1" | awk '{ gsub(/^[ \t]+/,"", $0); print $0}'; }
rtrim () { echo "$1" | awk '{ gsub(/[ \t]+$/,"", $0); print $0}'; }
trim () { local x="$( ltrim "$1")"; x="$( rtrim "$x")"; echo "$x"; }

detect_host () {
	local REV DIST PSEUDONAME

	if [ -f /etc/redhat-release ] ; then
		DIST='RedHat'
		PSEUDONAME=$(cat /etc/redhat-release | sed s/.*\(// | sed s/\)//)
		REV=$(cat /etc/redhat-release | sed s/.*release\ // | sed s/\ .*//)
		echo "redhat-$REV"
	elif [ -f /etc/SuSE-release ] ; then
		DIST=$(cat /etc/SuSE-release | tr "\n" ' '| sed s/VERSION.*//)
		REV=$(cat /etc/SuSE-release | tr "\n" ' ' | sed s/.*=\ //)
		trim "suse-$REV"
	elif [ -f /etc/debian_version ] ; then
		DIST="Debian Based"
		debian="debian"
		echo "${debian}"
	fi
}

check_rpm () {
	pkg_test=$(LC_ALL=C rpm -q ${pkg})
	if [ "x${pkg_test}" = "xpackage ${pkg} is not installed" ] ; then
		rpm_pkgs="${rpm_pkgs}${pkg} "
	fi
}

redhat_reqs () {
	unset rpm_pkgs
	pkg="redhat-lsb-core"
	check_rpm
	pkg="gcc"
	check_rpm
	pkg="ncurses-devel"
	check_rpm
	pkg="wget"
	check_rpm

	arch=$(uname -m)
	if [ "x${arch}" = "xx86_64" ] ; then
		pkg="ncurses-devel.i686"
		check_rpm
		pkg="libstdc++.i686"
		check_rpm
		pkg="zlib.i686"
		check_rpm
	fi

	if [ "${rpm_pkgs}" ] ; then
		echo "Fedora: missing dependicies, please install:"
		echo "-----------------------------"
		echo "yum install ${rpm_pkgs}"
		echo "-----------------------------"
		return 1
	fi
}

suse_regs () {
    local BUILD_HOST="$1"   
# --- SuSE-release ---
    if [ ! -f /etc/SuSE-release ]
    then
        cat >&2 <<@@
Missing /etc/SuSE-release file
 this file is part of the efault suse system. If this is a
 suse system for real, please install the package with:
    
    zypper install openSUSE-release   
@@
        return 1
    fi


# --- patch ---
    if [ ! $( which patch ) ]
    then
        cat >&2 <<@@
Missing patch command,
 it is part of the opensuse $BUILD_HOST distribution so it can be 
 installed simply using:

    zypper install patch

@@
        return 1
    fi

# --- mkimage ---
    if [ ! $( which mkimage ) ]
    then
        cat >&2 <<@@
Missing mkimage command.
 This command is part of a package not provided directly from
 opensuse. It can be found under several places for suse.
 There are two ways to install the package: either using a rpm
 or using a repo.
 In the second case these are the command to issue in order to 
 install it:

    zypper addrepo -f http://download.opensuse.org/repositories/home:/jblunck:/beagleboard/openSUSE_11.2
    zypper install uboot-mkimage

@@
        return 1
    fi
    
}

check_dpkg () {
	LC_ALL=C dpkg --list | awk '{print $2}' | grep "^${pkg}" >/dev/null || deb_pkgs="${deb_pkgs}${pkg} "
}

debian_regs () {
	unset deb_pkgs
	pkg="bc"
	check_dpkg
	pkg="build-essential"
	check_dpkg
	pkg="device-tree-compiler"
	check_dpkg
	pkg="fakeroot"
	check_dpkg
	pkg="libncurses5-dev"
	check_dpkg
	pkg="lsb-release"
	check_dpkg
	pkg="lzma"
	check_dpkg
	pkg="lzop"
	check_dpkg
	pkg="man-db"
	check_dpkg

	unset warn_dpkg_ia32
	unset stop_pkg_search
	#lsb_release might not be installed...
	if [ $(which lsb_release) ] ; then
		deb_distro=$(lsb_release -cs)
		deb_lsb_rs=$(lsb_release -rs | awk '{print $1}')

		#lsb_release -a
		#No LSB modules are available.
		#Distributor ID:    Debian
		#Description:    Debian GNU/Linux Kali Linux 1.0
		#Release:    Kali Linux 1.0
		#Codename:    n/a
		#http://docs.kali.org/kali-policy/kali-linux-relationship-with-debian
		if [ "x${deb_lsb_rs}" = "xKali" ] ; then
			deb_distro="wheezy"
		fi

		#Linux Mint: Compatibility Matrix
		#http://www.linuxmint.com/oldreleases.php
		case "${deb_distro}" in
		debian)
			deb_distro="jessie"
			;;
		isadora)
			deb_distro="lucid"
			;;
		julia)
			deb_distro="maverick"
			;;
		katya)
			deb_distro="natty"
			;;
		lisa)
			deb_distro="oneiric"
			;;
		maya)
			deb_distro="precise"
			;;
		nadia)
			deb_distro="quantal"
			;;
		olivia)
			deb_distro="raring"
			;;
		esac

		case "${deb_distro}" in
		squeeze|wheezy|jessie|sid)
			unset error_unknown_deb_distro
			unset warn_eol_distro
			;;
		lucid|precise|quantal|raring|saucy)
			unset error_unknown_deb_distro
			unset warn_eol_distro
			;;
		maverick|natty|oneiric)
			#lucid -> precise
			#http://us.archive.ubuntu.com/ubuntu/dists/
			#list: dists between LTS's...
			unset error_unknown_deb_distro
			warn_eol_distro=1
			stop_pkg_search=1
			;;
		hardy)
			#Just old, but still on:
			#http://us.archive.ubuntu.com/ubuntu/dists/
			unset error_unknown_deb_distro
			warn_eol_distro=1
			stop_pkg_search=1
			;;
		*)
			error_unknown_deb_distro=1
			unset warn_eol_distro
			stop_pkg_search=1
			;;
		esac
	fi

	if [ $(which lsb_release) ] && [ ! "${stop_pkg_search}" ] ; then
		deb_distro=$(lsb_release -cs)

		#pkg: mkimage
		case "${deb_distro}" in
		squeeze|lucid)
			pkg="uboot-mkimage"
			check_dpkg
			;;
		*)
			pkg="u-boot-tools"
			check_dpkg
			;;
		esac

		#pkg: ia32-libs
		deb_arch=$(LC_ALL=C dpkg --print-architecture)
		if [ "x${deb_arch}" = "xamd64" ] ; then
			unset dpkg_multiarch
			case "${deb_distro}" in
			squeeze|lucid|precise)
				pkg="ia32-libs"
				check_dpkg
				;;
			wheezy|jessie|sid|quantal|raring|saucy)
				pkg="libc6:i386"
				check_dpkg
				pkg="libncurses5:i386"
				check_dpkg
				pkg="libstdc++6:i386"
				check_dpkg
				pkg="zlib1g:i386"
				check_dpkg
				dpkg_multiarch=1
				;;
			esac

			if [ "${dpkg_multiarch}" ] ; then
				unset check_foreign
				check_foreign=$(LC_ALL=C dpkg --print-foreign-architectures)
				if [ "x${check_foreign}" = "x" ] ; then
					warn_dpkg_ia32=1
				fi
			fi
		fi
	fi

	if [ "${warn_eol_distro}" ] ; then
		echo "End Of Life (EOL) deb based distro detected."
		echo "Dependency check skipped, you are on your own."
		echo "-----------------------------"
		unset deb_pkgs
	fi

	if [ "${error_unknown_deb_distro}" ] ; then
		echo "Unrecognized deb based system:"
		echo "-----------------------------"
		echo "Please cut, paste and email to: bugs@rcn-ee.com"
		echo "-----------------------------"
		echo "git: `git rev-parse HEAD`"
		echo "uname -m"
		uname -m
		echo "lsb_release -a"
		lsb_release -a
		echo "-----------------------------"
		return 1
	fi

	if [ "${deb_pkgs}" ] ; then
		echo "Debian/Ubuntu/Mint: missing dependicies, please install:"
		echo "-----------------------------"
		if [ "${warn_dpkg_ia32}" ] ; then
			echo "sudo dpkg --add-architecture i386"
		fi
		echo "sudo apt-get update"
		echo "sudo apt-get install ${deb_pkgs}"
		echo "-----------------------------"
		return 1
	fi
}

BUILD_HOST=${BUILD_HOST:="$( detect_host )"}
if [ $(which lsb_release) ] ; then
	info "Detected build host [`lsb_release -sd`]"
	info "host: [`uname -m`]"
	info "git HEAD commit: [`git rev-parse HEAD`]"
else
	info "Detected build host [$BUILD_HOST]"
	info "host: [`uname -m`]"
	info "git HEAD commit: [`git rev-parse HEAD`]"
fi
case "$BUILD_HOST" in
    redhat*)
	    redhat_reqs || error "Failed dependency check"
        ;;
    debian*)
	    debian_regs || error "Failed dependency check"
        ;;
    suse*)
	    suse_regs "$BUILD_HOST" || error "Failed dependency check"
        ;;
esac

