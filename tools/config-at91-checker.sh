#!/bin/sh -e

DIR=$PWD

check_config_builtin () {
	unset test_config
	test_config=$(grep "${config}=y" ${DIR}/patches/defconfig || true)
	if [ "x${test_config}" = "x" ] ; then
		echo "echo ${config}=y >> ./KERNEL/.config"
	fi
}

check_config_module () {
	unset test_config
	test_config=$(grep "${config}=y" ${DIR}/patches/defconfig || true)
	if [ "x${test_config}" = "x${config}=y" ] ; then
		echo "sed -i -e 's:${config}=y:${config}=m:g' ./KERNEL/.config"
	else
		unset test_config
		test_config=$(grep "${config}=" ${DIR}/patches/defconfig || true)
		if [ "x${test_config}" = "x" ] ; then
			echo "echo ${config}=m >> ./KERNEL/.config"
		fi
	fi
}

check_config () {
	unset test_config
	test_config=$(grep "${config}=" ${DIR}/patches/defconfig || true)
	if [ "x${test_config}" = "x" ] ; then
		echo "echo ${config}=y >> ./KERNEL/.config"
		echo "echo ${config}=m >> ./KERNEL/.config"
	fi
}

check_config_disabled () {
	unset test_config
	test_config=$(grep "${config} is not set" ${DIR}/patches/defconfig || true)
	if [ "x${test_config}" = "x" ] ; then
		unset test_config
		test_config=$(grep "${config}=y" ${DIR}/patches/defconfig || true)
		if [ "x${test_config}" = "x${config}=y" ] ; then
			echo "sed -i -e 's:${config}=y:# ${config} is not set:g' ./KERNEL/.config"
		else
			echo "sed -i -e 's:${config}=m:# ${config} is not set:g' ./KERNEL/.config"
		fi
	fi
}

check_if_set_then_set_module () {
	unset test_config
	test_config=$(grep "${if_config}=y" ${DIR}/patches/defconfig || true)
	if [ "x${test_config}" = "x${if_config}=y" ] ; then
		check_config_module
	fi
}

check_if_set_then_set () {
	unset test_config
	test_config=$(grep "${if_config}=y" ${DIR}/patches/defconfig || true)
	if [ "x${test_config}" = "x${if_config}=y" ] ; then
		check_config_builtin
	fi
}

check_if_set_then_disable () {
	unset test_config
	test_config=$(grep "${if_config}=y" ${DIR}/patches/defconfig || true)
	if [ "x${test_config}" = "x${if_config}=y" ] ; then
		check_config_disabled
	fi
}

if_config="CONFIG_ARCH_AT91"
config="CONFIG_SOC_AT91RM9200"
check_if_set_then_disable
config="CONFIG_SOC_AT91SAM9261"
check_if_set_then_set
config="CONFIG_SOC_AT91SAM9RL"
check_if_set_then_set
config="CONFIG_ARM_APPENDED_DTB"
check_if_set_then_disable
config="CONFIG_CAN"
check_if_set_then_set
config="CONFIG_CAN_DEV"
check_if_set_then_set
config="CONFIG_CAN_AT91"
check_if_set_then_set
config="CONFIG_ATMEL_SSC"
check_if_set_then_set
config="CONFIG_I2C_AT91"
check_if_set_then_set
config="CONFIG_W1"
check_if_set_then_set
config="CONFIG_W1_MASTER_GPIO"
check_if_set_then_set
config="CONFIG_HID_PID"
check_if_set_then_set
config="CONFIG_USB_HIDDEV"
check_if_set_then_set
config="CONFIG_MMC_UNSAFE_RESUME"
check_if_set_then_set
config="CONFIG_LEDS_ATMEL_PWM"
check_if_set_then_set_module
config="CONFIG_LEDS_TRIGGER_ONESHOT"
check_if_set_then_set
config="CONFIG_LEDS_TRIGGER_CPU"
check_if_set_then_set
config="CONFIG_AT_HDMAC"
check_if_set_then_set
config="CONFIG_DMA_ENGINE"
check_if_set_then_set
config="CONFIG_F2FS_FS"
check_if_set_then_set
config="CONFIG_NFS_V3_ACL"
check_if_set_then_set
config="CONFIG_NFS_V4"
check_if_set_then_set
config="CONFIG_PRINTK_TIME"
check_if_set_then_set
config="CONFIG_UNUSED_SYMBOLS"
check_if_set_then_set
config="CONFIG_IIO"
check_if_set_then_set
config="CONFIG_IIO_BUFFER"
check_if_set_then_set
config="CONFIG_AT91_ADC"
check_if_set_then_set
config="CONFIG_PWM"
check_if_set_then_set
config="CONFIG_PWM_SYSFS"
check_if_set_then_set
config="CONFIG_PWM_ATMEL_TCB"
check_if_set_then_set

#
