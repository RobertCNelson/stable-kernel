#!/bin/bash -e
#Based on: http://omappedia.org/wiki/DSPBridge_Project#Build_Userspace_Files
unset BUILD
unset CC
DIR=$PWD

BIOS_VER=5_33_06
BIOS_FILE_VER=5.33.06
BIOS=bios_setuplinux_${BIOS_VER}.bin
BIOS_DIR=bios_${BIOS_VER}
BIOS_FILE=DSP_BIOS_${BIOS_FILE_VER}_Components

CGVERSION=7.0.2
CGTOOLS_BIN=ti_cgt_c6000_${CGVERSION}_setup_linux_x86.bin

TIOPENMAX=0.3.5

function libstd_dependicy {
DIST=$(lsb_release -sc)

if [ $(uname -m) == "x86_64" ] ; then
	LIBSTD=$(file /usr/lib32/libstdc++.so.5 | grep -v ERROR 2> /dev/null)
	if [ "-$LIBSTD-" = "--" ] ; then
		if [ "-$DIST-" = "-karmic-" ] ; then
			sudo apt-get install -y ia32-libs
		else
			cd /tmp
			wget -c http://security.ubuntu.com/ubuntu/pool/universe/i/ia32-libs/ia32-libs_2.7ubuntu6.1_amd64.deb
			dpkg-deb -x ia32-libs_2.7ubuntu6.1_amd64.deb ia32-libs
			sudo cp ia32-libs/usr/lib32/libstdc++.so.5.0.7 /usr/lib32/
			cd /usr/lib32
			sudo ln -s libstdc++.so.5.0.7 libstdc++.so.5
		fi
	fi
else
	LIBSTD=$(file /usr/lib/libstdc++.so.5 | grep -v ERROR 2> /dev/null)
	if [ "-$LIBSTD-" = "--" ] ; then
		if [ "-$DIST-" != "--" ] ; then
			cd /tmp
			wget -c http://mirrors.kernel.org/ubuntu/pool/universe/g/gcc-3.3/libstdc++5_3.3.6-17ubuntu1_i386.deb
			dpkg-deb -x libstdc++5_3.3.6-17ubuntu1_i386.deb libs
			sudo cp libs/usr/lib/libstdc++.so.5.0.7 /usr/lib/
			cd /usr/lib
			sudo ln -s libstdc++.so.5.0.7 libstdc++.so.5
		fi
	fi
fi
cd ${DIR}
}

function check_dsp_bios {
if [ -e ${DIR}/dl/${BIOS} ]; then
  echo "${BIOS} found"
  if [ -e  ${DIR}/dl/${BIOS_DIR}/${BIOS_FILE} ]; then
    echo "Installed ${BIOS} found"
  else
    cd ${DIR}/dl/
    echo "${BIOS} needs to be executable"
    sudo chmod +x ${DIR}/dl/${BIOS}
    ${DIR}/dl/${BIOS} --mode console --prefix ${DIR}/dl/${BIOS_DIR} <<setupBIOS
Y
 
q Y
setupBIOS

    cd ${DIR}
  fi
else
  echo ""
  echo "${BIOS} not found"
  echo "Download ${BIOS}"
  echo "DL From: http://software-dl.ti.com/dsps/dsps_registered_sw/sdo_sb/targetcontent/bios/index.html"
  echo "Copy to: ${DIR}/dl"
  echo ""
  exit
fi
}

function check_cgtools {
if [ -e ${DIR}/dl/${CGTOOLS_BIN} ]; then
  echo "${CGTOOLS_BIN} found"
  if [ -e  ${DIR}/dl/TI_CGT_C6000_${CGVERSION}/uninstall_cgt_c6000.bin ]; then
    echo "Installed ${CGTOOLS_BIN} found"
  else
    cd ${DIR}/dl/
    echo "${CGTOOLS_BIN} needs to be executable"
    sudo chmod +x ${DIR}/dl/${CGTOOLS_BIN}
    ${DIR}/dl/${CGTOOLS_BIN} --mode console --prefix ${DIR}/dl/TI_CGT_C6000_${CGVERSION} <<setupCG
Y
 
q Y
 
 
 
setupCG

    cd ${DIR}
  fi
else
  echo ""
  echo "${CGTOOLS_BIN} not found"
  echo "Download ${CGTOOLS_BIN}"
  echo "DL From: https://www-a.ti.com/downloads/sds_support/TICodegenerationTools/download.htm" 
  echo "Copy to: ${DIR}/dl"
  echo ""
  exit
fi
}

function check_dspbridge_userspace {
if [ -e ${DIR}/dl/userspace-dspbridge/source/Makefile ]; then
  cd ${DIR}/dl/userspace-dspbridge/
  git checkout master -f
  git pull
  cd ${DIR}
  BUILD+=G
else
  cd ${DIR}/dl/
  git clone git://dev.omapzoom.org/pub/scm/tidspbridge/userspace-dspbridge.git
  cd ${DIR}/dl/userspace-dspbridge/
  cd ${DIR}
if [ -e ${DIR}/dl/userspace-dspbridge/source/Makefile ]; then
  echo "userspace available"
else
  exit
fi
fi
}

function build_dsp_userspace {
sudo rm -rfd /tmp/dsp-tc/ || true
mkdir -p /tmp/dsp-tc/
mkdir -p /tmp/dsp-tc/bios_${BIOS_VER}
mkdir -p /tmp/dsp-tc/cgt6x-${CGVERSION}
cp -r ${DIR}/dl/${BIOS_DIR}/*  /tmp/dsp-tc/bios_${BIOS_VER}

if [ -e  /tmp/dsp-tc/bios_5_33_04/DSP_BIOS_5.33.04_Components ] ; then
	echo "Fixing BIOS 5.33.04 Permissions"
	sudo chmod -R +x /tmp/dsp-tc/bios_5_33_04/xdctools
fi

cp -r ${DIR}/dl/TI_CGT_C6000_${CGVERSION}/* /tmp/dsp-tc/cgt6x-${CGVERSION}

export DEPOT=/tmp/dsp-tc

cd ${DIR}/dl/userspace-dspbridge/source/

#Fix evil makefile
sed -i -e 's:SABIOS_VER   = 5.33.04:SABIOS_VER   = '$BIOS_FILE_VER':g' product.mak
sed -i -e 's:SABIOS_VER_2 = 5_33_04:SABIOS_VER_2 = '$BIOS_VER':g' product.mak
sed -i -e 's:CGT6X_VER = 6.0.7:CGT6X_VER = '$CGVERSION':g' product.mak

make clean
make ARCH=arm CROSS=${CC} all

cd ${DIR}/dl/userspace-dspbridge/source/

sed -i -e 's:SABIOS_VER   = '$BIOS_FILE_VER':SABIOS_VER   = 5.33.04:g' product.mak
sed -i -e 's:SABIOS_VER_2 = '$BIOS_VER':SABIOS_VER_2 = 5_33_04:g' product.mak
sed -i -e 's:CGT6X_VER = '$CGVERSION':CGT6X_VER = 6.0.7:g' product.mak

cd ${DIR}
}

function file-DSP-startup {

cat > ${DIR}/DSP/opt/dsp <<dspscript
#!/bin/sh
		
case "\$1" in
	start)
		modprobe dspbridge
		modprobe bridgedriver
		;;
esac

dspscript

}

function file-install-DSP {

cat > ${DIR}/DSP/install-DSP.sh <<installDSP
#!/bin/bash

DIR=\$PWD

if [ \$(uname -m) == "armv7l" ] ; then

 if [ -e  \${DIR}/dsp_libs.tar.gz ]; then

  echo "Extracting target files to rootfs"
  sudo tar xf dsp_libs.tar.gz -C /

  if which lsb_release >/dev/null 2>&1 && [ "\$(lsb_release -is)" = Ubuntu ]; then

    if [ \$(lsb_release -sc) == "jaunty" ]; then
      sudo cp /opt/dsp /etc/rcS.d/S61dsp.sh
      sudo chmod +x /etc/rcS.d/S61dsp.sh
    else
      #karmic/lucid/maverick/etc
      sudo cp /opt/dsp /etc/init.d/dsp
      sudo chmod +x /etc/init.d/dsp
      sudo update-rc.d dsp defaults
    fi

  else

    sudo cp /opt/dsp /etc/init.d/dsp
    sudo chmod +x /etc/init.d/dsp
    sudo update-rc.d dsp defaults

  fi

 else
  echo "dsp_libs.tar.gz is missing"
  exit
 fi

else
 echo "This script is to be run on an armv7 platform"
 exit
fi

installDSP

}


function create_DSP_package {
	cd ${DIR}
	sudo rm -rfd ${DIR}/DSP/
	mkdir -p ${DIR}/DSP/
	mkdir -p ${DIR}/DSP/lib/
	mkdir -p ${DIR}/DSP/opt/

	sudo cp -rv ${DIR}/dl/userspace-dspbridge/source/target/dspbridge/ ${DIR}/DSP/opt/
	sudo cp -v ${DIR}/dl/userspace-dspbridge/source/target/lib/* ${DIR}/DSP/lib/

file-DSP-startup

	cd ${DIR}/DSP/
	tar czf ${DIR}/dsp_libs.tar.gz *
	cd ${DIR}

	sudo rm -rfd ${DIR}/DSP/
	mkdir -p ${DIR}/DSP/

	mv ${DIR}/dsp_libs.tar.gz ${DIR}/DSP/

file-install-DSP
	chmod +x ./DSP/install-DSP.sh

	cd ${DIR}/DSP
	tar czf ${DIR}/DSP_Install_libs.tar.gz *
	cd ${DIR}

	sudo rm -rfd ${DIR}/DSP/
	cd ${DIR}
}


if [ -e ${DIR}/system.sh ]; then
	. system.sh

	libstd_dependicy
	check_dsp_bios
	check_cgtools
	check_dspbridge_userspace

	build_dsp_userspace
	create_DSP_package

else
	echo "Missing system.sh, please copy system.sh.sample to system.sh and edit as needed"
	echo "cp system.sh.sample system.sh"
	echo "gedit system.sh"
fi
