#!/bin/bash -e
#
# Copyright (c) 2012 Robert Nelson <robertcnelson@gmail.com>
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
# THE SOFTWARE.

VERSION="v2012.06-0"

unset DIR

DIR=$PWD

SDK="4.06.00.02"
SDK_DIR="4_06_00_02"
SGX_SHA="origin/${SDK}"

set_sgx_make_vars () {
	GRAPHICS_PATH="GRAPHICS_INSTALL_DIR="${DIR}/ti-sdk-pvr/Graphics_SDK/""
	KERNEL_PATH="KERNEL_INSTALL_DIR="${DIR}/KERNEL""
	USER_VAR="HOME=/home/${USER}"
	CSTOOL_PREFIX=${CC##*/}

	#Will probally have to revist this one later...
	CSTOOL_DIR=$(echo ${CC} | awk -F "/bin/${CSTOOL_PREFIX}" '{print $1}')

	if [ "x${CSTOOL_PREFIX}" == "x${CSTOOL_DIR}" ] ; then
		CSTOOL_DIR="/usr"
	fi

	CROSS="CSTOOL_PREFIX=${CSTOOL_PREFIX} CSTOOL_DIR=${CSTOOL_DIR}"
}

git_sgx_modules () {
	if [ ! -f "${DIR}/ti-sdk-pvr/.git/config" ] ; then
		git clone git://github.com/RobertCNelson/ti-sdk-pvr.git
		cd "${DIR}/ti-sdk-pvr/"
		git checkout ${SGX_SHA} -b tmp-build
		cd ${DIR}/
	else
		cd "${DIR}/ti-sdk-pvr/"
		git add .
		git commit --allow-empty -a -m 'empty cleanup commit'
		git checkout origin/master -b tmp-scratch
		git branch -D tmp-build &>/dev/null || true
		git fetch
		git checkout ${SGX_SHA} -b tmp-build
		git branch -D tmp-scratch &>/dev/null || true
		cd ${DIR}/
	fi
}

copy_sgx_binaries () {
	if [ ! -d "/home/${USER}/Graphics_SDK_${SDK_DIR}" ] ; then
		echo ""
		echo "The SDK is missing, please download the ${SDK} release from"
		echo "http://software-dl.ti.com/dsps/dsps_public_sw/sdo_sb/targetcontent/gfxsdk/"
		echo "Download the FULL release."
		echo ""
		echo "chmod +x Graphics_SDK_setuplinux_${SDK_DIR}.bin"
		echo "./Graphics_SDK_setuplinux_${SDK_DIR}.bin"
		echo ""
		echo "Selecting the defaults.."
		echo ""
		exit
	else
		echo "Starting: copying files from the SDK"
		if [  -d "${DIR}/ti-sdk-pvr/Graphics_SDK/targetfs" ] ; then
			rm -rf "${DIR}/ti-sdk-pvr/Graphics_SDK/targetfs" || true
		fi
		mkdir "${DIR}/ti-sdk-pvr/Graphics_SDK/targetfs"

		if [ -d "${DIR}/ti-sdk-pvr/Graphics_SDK/tools" ] ; then
			rm -rf "${DIR}/ti-sdk-pvr/Graphics_SDK/tools" || true
		fi
		cp -r "/home/${USER}/Graphics_SDK_${SDK_DIR}/tools" "${DIR}/ti-sdk-pvr/Graphics_SDK/"

		if [ -d "${DIR}/ti-sdk-pvr/Graphics_SDK/gfx_rel_es3.x" ] ; then
			rm -rf "${DIR}/ti-sdk-pvr/Graphics_SDK/gfx_rel_es3.x" || true
		fi
		cp -r "/home/${USER}/Graphics_SDK_${SDK_DIR}/gfx_rel_es3.x" "${DIR}/ti-sdk-pvr/Graphics_SDK/"

		if [ -d "${DIR}/ti-sdk-pvr/Graphics_SDK/gfx_rel_es5.x" ] ; then
			rm -rf "${DIR}/ti-sdk-pvr/Graphics_SDK/gfx_rel_es5.x" || true
		fi
		cp -r "/home/${USER}/Graphics_SDK_${SDK_DIR}/gfx_rel_es5.x" "${DIR}/ti-sdk-pvr/Graphics_SDK/"

		#From the full sdk
		if [ -d "${DIR}/ti-sdk-pvr/Graphics_SDK/GFX_Linux_SDK" ] ; then
			rm -rf "${DIR}/ti-sdk-pvr/Graphics_SDK/GFX_Linux_SDK" || true
		fi
#		cp -r "/home/${USER}/Graphics_SDK_${SDK_DIR}/GFX_Linux_SDK" "${DIR}/ti-sdk-pvr/Graphics_SDK/"
		echo "Done: copying files from the SDK"
	fi
}

build_sgx_modules () {
	cd "${DIR}/ti-sdk-pvr/Graphics_SDK/"
	echo "make ${GRAPHICS_PATH} ${KERNEL_PATH} ${USER_VAR} ${CROSS} BUILD="$1" OMAPES="$2" FBDEV="$3" SUPPORT_XORG="$4" "$5""
	make ${GRAPHICS_PATH} ${KERNEL_PATH} ${USER_VAR} ${CROSS} BUILD="$1" OMAPES="$2" FBDEV="$3" SUPPORT_XORG="$4" "$5"
	cd ${DIR}/
}

file_pvr_startup () {
	cat > "${DIR}/ti-sdk-pvr/pkg/pvr_startup" <<-__EOF__
	#!/bin/sh

	if [ "\$1" = "" ]; then
	        echo PVR-INIT: Please use start, stop, or restart.
	        exit 1
	fi

	if [ "\$1" = "stop" -o  "\$1" = "restart" ]; then
	        echo Stopping PVR
	        rmmod bufferclass_ti 2>/dev/null
	        rmmod omaplfb 2>/dev/null
	        rmmod pvrsrvkm 2>/dev/null
	fi

	if [ "\$1" = "stop" ]; then
	        exit 0
	fi

	echo Starting PVR
	modprobe omaplfb
	modprobe bufferclass_ti

	pvr_maj=\$(grep "pvrsrvkm$" /proc/devices | cut -b1,2,3)
	bc_maj=\$(grep "bc" /proc/devices | cut -b1,2,3)

	if [ -e /dev/pvrsrvkm ] ; then
	        rm -f /dev/pvrsrvkm
	fi

	mknod /dev/pvrsrvkm c \$pvr_maj 0
	chmod 666 /dev/pvrsrvkm

	touch /etc/powervr-esrev

	SAVED_ESREVISION="\$(cat /etc/powervr-esrev)"

	devmem2 0x48004B48 w 0x2 > /dev/null
	devmem2 0x48004B10 w 0x1 > /dev/null
	devmem2 0x48004B00 w 0x2 > /dev/null

	ES_REVISION="\$(devmem2 0x50000014 | sed -e s:0x10205:5: -e s:0x10201:3: | tail -n1 | awk -F': ' '{print \$2}')"

	if [ "\${ES_REVISION}" != "\${SAVED_ESREVISION}" ] ; then
	        echo -n "Starting SGX fixup for"
	        echo " ES\${ES_REVISION}.x"
	        cp -a /usr/lib/es\${ES_REVISION}.0/* /usr/lib
	        cp -a /usr/bin/es\${ES_REVISION}.0/* /usr/bin
	        echo "\${ES_REVISION}" > /etc/powervr-esrev
	fi

	/usr/bin/pvrsrvinit

__EOF__

}

file_install_sgx () {
cat > "${DIR}/ti-sdk-pvr/pkg/install-sgx.sh" <<-__EOF__
	#!/bin/sh

	if ! id | grep -q root; then
	        echo "must be run as root"
	        exit
	fi

	DIR=\$PWD

	ln -sf /usr/lib/libXdmcp.so.6.0.0 /usr/lib/libXdmcp.so.0
	ln -sf /usr/lib/libXau.so.6.0.0 /usr/lib/libXau.so.0

	echo "Extracting target files to rootfs"
	tar xf ./gfx_rel_es3.tar.gz -C /
	tar xf ./gfx_rel_es5.tar.gz -C /

	if [ -f /etc/powervr-esrev ] ; then
	        rm -f /etc/powervr-esrev || true
	fi

	echo "[default]" | tee /etc/powervr.ini
	echo "WindowSystem=libpvrPVR2D_FRONTWSEGL.so" | tee -a /etc/powervr.ini

	if [ ! \$(which devmem2) ] ; then
	        dpkg -i ./tools/devmem2*_`dpkg-architecture -qDEB_HOST_ARCH`.deb
	fi

	touch /etc/powervr-esrev

	SAVED_ESREVISION="\$(cat /etc/powervr-esrev)"

	devmem2 0x48004B48 w 0x2 > /dev/null
	devmem2 0x48004B10 w 0x1 > /dev/null
	devmem2 0x48004B00 w 0x2 > /dev/null

	ES_REVISION="\$(devmem2 0x50000014 | sed -e s:0x10205:5: -e s:0x10201:3: | tail -n1 | awk -F': ' '{print \$2}')"

	if [ "\${ES_REVISION}" != "\${SAVED_ESREVISION}" ] ; then
	        echo -n "Starting SGX fixup for"
	        echo " ES\${ES_REVISION}.x"
	        cp -a /usr/lib/es\${ES_REVISION}.0/* /usr/lib
	        cp -a /usr/bin/es\${ES_REVISION}.0/* /usr/bin
	        echo "\${ES_REVISION}" > /etc/powervr-esrev
	fi

	if [ -d /lib/modules/\$(uname -r)/extra/ ] ; then
	        rm -rf /lib/modules/\$(uname -r)/extra/ || true
	fi

	mkdir -p /lib/modules/\$(uname -r)/extra/
	cp -v /opt/sgx_kernel_modules/es\${ES_REVISION}.0/*.ko /lib/modules/\$(uname -r)/extra/

	grep -v -e "extra/pvrsrvkm.ko" /lib/modules/\$(uname -r)/modules.dep >/tmp/modules.tmp
	echo "/lib/modules/\$(uname -r)/extra/pvrsrvkm.ko:" >>/tmp/modules.tmp
	cp /tmp/modules.tmp /lib/modules/\$(uname -r)/modules.dep

	grep -v -e "extra/omaplfb.ko" /lib/modules/\$(uname -r)/modules.dep >/tmp/modules.tmp
	echo "/lib/modules/\$(uname -r)/extra/omaplfb.ko: /lib/modules/\$(uname -r)/extra/pvrsrvkm.ko" >>/tmp/modules.tmp
	cp /tmp/modules.tmp /lib/modules/\$(uname -r)/modules.dep

	grep -v -e "extra/bufferclass_ti.ko" /lib/modules/\$(uname -r)/modules.dep >/tmp/modules.tmp
	echo "/lib/modules/\$(uname -r)/extra/bufferclass_ti.ko: /lib/modules/\$(uname -r)/extra/pvrsrvkm.ko" >>/tmp/modules.tmp
	cp /tmp/modules.tmp /lib/modules/\$(uname -r)/modules.dep

	update-rc.d -f pvr_init remove
	if [ -f /etc/init.d/pvr_init ] ; then
	        rm -f /etc/init.d/pvr_init || true
	fi

	cp ./pvr_startup /etc/init.d/pvr_init
	chmod +x /etc/init.d/pvr_init
	update-rc.d pvr_init defaults

__EOF__

	chmod +x "${DIR}/ti-sdk-pvr/pkg/install-sgx.sh"

}

file_run_sgx () {
	cat > "${DIR}/ti-sdk-pvr/pkg/run-sgx.sh" <<-__EOF__
	#!/bin/sh

	if ! id | grep -q root; then
	        echo "must be run as root"
	        exit
	fi

	DIR=\$PWD

	if [ -f /etc/powervr-esrev ] ; then
	        rm /etc/powervr-esrev || true
	fi

	depmod -a omaplfb

	/etc/init.d/pvr_init restart

__EOF__

	chmod +x "${DIR}/ti-sdk-pvr/pkg/run-sgx.sh"

}

mv_modules_libs_bins () {
	mkdir -p ./opt/sgx_kernel_modules/${CORE}.0/
	mv ./*.ko ./opt/sgx_kernel_modules/${CORE}.0/ || true

	mkdir -p ./opt/sgx_xorg/${CORE}.0/
	mv ./pvr_drv* ./opt/sgx_xorg/${CORE}.0/ || true
	mv ./xorg.conf ./opt/sgx_xorg/${CORE}.0/ || true

	mkdir -p ./opt/sgx_ews/${CORE}.0/
	mv ./ews* ./opt/sgx_ews/${CORE}.0/ || true

	mkdir -p ./opt/sgx_other/${CORE}.0/
	mv ./*.sh ./opt/sgx_other/${CORE}.0/ || true
	mv ./*.pvr ./opt/sgx_other/${CORE}.0/ || true

	mkdir -p ./usr/lib/${CORE}.0/
	mv ./*.so* ./usr/lib/${CORE}.0/ || true
	mv ./*.a ./usr/lib/${CORE}.0/ || true
	mv ./*.dbg ./usr/lib/${CORE}.0/ || true

	mkdir -p ./usr/bin/${CORE}.0/
	mv ./*_test ./usr/bin/${CORE}.0/ || true
	mv ./*gl* ./usr/bin/${CORE}.0/ || true
	mv ./p[dv]* ./usr/bin/${CORE}.0/ || true
	mv ./xgle* ./usr/bin/${CORE}.0/ || true
}

pkg_modules () {
	if [ -d "${DIR}/ti-sdk-pvr/pkg/" ] ; then
		rm -rf "${DIR}/ti-sdk-pvr/pkg" || true
	fi
	mkdir "${DIR}/ti-sdk-pvr/pkg"

	CORE="es3"
	cd "${DIR}/ti-sdk-pvr/Graphics_SDK/gfx_rel_${CORE}.x"
	mv_modules_libs_bins
	tar czf "${DIR}/ti-sdk-pvr/pkg"/gfx_rel_${CORE}.tar.gz *

	CORE="es5"
	cd "${DIR}/ti-sdk-pvr/Graphics_SDK/gfx_rel_${CORE}.x"
	mv_modules_libs_bins
	tar czf "${DIR}/ti-sdk-pvr/pkg"/gfx_rel_${CORE}.tar.gz *
}

pkg_helpers () {
	mkdir "${DIR}/ti-sdk-pvr/pkg/tools/"
	cd "${DIR}/ti-sdk-pvr/pkg/tools"

	#download devmem2
	rm -f /tmp/index.html || true
	wget --directory-prefix=/tmp http://ports.ubuntu.com/pool/universe/d/devmem2/

	DEVMEM_ARMEL=$(cat /tmp/index.html | grep _armel.deb | head -1 | awk -F"\"" '{print $8}')
	DEVMEM_ARMHF=$(cat /tmp/index.html | grep _armhf.deb | head -1 | awk -F"\"" '{print $8}')

	wget -c http://ports.ubuntu.com/pool/universe/d/devmem2/${DEVMEM_ARMEL}
	wget -c http://ports.ubuntu.com/pool/universe/d/devmem2/${DEVMEM_ARMHF}
}

pkg_install_script () {
	cd "${DIR}/ti-sdk-pvr/pkg"
	file_pvr_startup
	file_install_sgx
	file_run_sgx
	cd ${DIR}/
}

pkg_up () {
	cd "${DIR}/ti-sdk-pvr/pkg"
	tar czf ${DIR}/deploy/GFX_${SDK}_libs.tar.gz *
	cd ${DIR}/
}

if [ -e ${DIR}/system.sh ] ; then
	source system.sh
	source version.sh

	set_sgx_make_vars

	git_sgx_modules
	copy_sgx_binaries

	#No reason to rebuild the sdk...
	sed -i -e 's:all_km all_sdk:all_km:g' "${DIR}/ti-sdk-pvr/Graphics_SDK/Makefile"
	sed -i -e 's:install_km install_sdk:install_km:g' "${DIR}/ti-sdk-pvr/Graphics_SDK/Makefile"

	build_sgx_modules release 3.x yes 0 all
	build_sgx_modules release 5.x yes 0 all
##	build_sgx_modules release 6.x yes 0 all
##	build_sgx_modules release 8.x yes 0 all
	pkg_modules
	pkg_helpers
	pkg_install_script
	pkg_up
else
	echo ""
	echo "ERROR: Missing (your system) specific system.sh, please copy system.sh.sample to system.sh and edit as needed."
	echo ""
	echo "example: cp system.sh.sample system.sh"
	echo "example: gedit system.sh"
	echo ""
fi

