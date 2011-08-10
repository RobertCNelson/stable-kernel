#!/bin/sh

cd /boot/uboot
sudo mount -o remount,rw /boot/uboot

if ! ls /boot/initrd.img-$(uname -r) >/dev/null 2>&1;then
sudo update-initramfs -c -k $(uname -r)
else
sudo update-initramfs -u -k $(uname -r)
fi

if ls /boot/initrd.img-$(uname -r) >/dev/null 2>&1;then
sudo mkimage -A arm -O linux -T ramdisk -C none -a 0 -e 0 -n initramfs -d /boot/initrd.img-$(uname -r) /boot/uboot/uInitrd
fi

if ls /boot/uboot/boot.cmd >/dev/null 2>&1;then
sudo mkimage -A arm -O linux -T script -C none -a 0 -e 0 -n "Boot Script" -d /boot/uboot/boot.cmd /boot/uboot/boot.scr
fi
if ls /boot/uboot/serial.cmd >/dev/null 2>&1;then
sudo mkimage -A arm -O linux -T script -C none -a 0 -e 0 -n "Boot Script" -d /boot/uboot/serial.cmd /boot/uboot/boot.scr
fi
sudo cp /boot/uboot/boot.scr /boot/uboot/boot.ini
if ls /boot/uboot/user.cmd >/dev/null 2>&1;then
sudo mkimage -A arm -O linux -T script -C none -a 0 -e 0 -n "Reset Nand" -d /boot/uboot/user.cmd /boot/uboot/user.scr
fi

