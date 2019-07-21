#!/sbin/sh

SLOT=`getprop ro.boot.slot_suffix`
mount /dev/block/bootdevice/by-name/vendor$SLOT /vendor -o ro

panel_supplier=""
panel_supplier=$(cat /sys/devices/virtual/graphics/fb0/panel_supplier 2> /dev/null)
echo "panel supplier vendor is: [$panel_supplier]"

case $panel_supplier in
	ofilm)
		insmod /vendor/lib/modules/focaltech_mmi.ko
		;;
	tianma)
		insmod /vendor/lib/modules/ilitek_mmi.ko
		;;
	csot)
		insmod /vendor/lib/modules/nova_mmi.ko
		;;
	*)
		echo "$panel_supplier not supported"
		;;
esac

# MMI Common
insmod /vendor/lib/modules/exfat.ko
insmod /vendor/lib/modules/mmi_annotate.ko
insmod /vendor/lib/modules/mmi_info.ko
insmod /vendor/lib/modules/mmi_sys_temp.ko
insmod /vendor/lib/modules/sensors_class.ko
insmod /vendor/lib/modules/tzlog_dump.ko
insmod /vendor/lib/modules/utags.ko


# Ocean specific
insmod /vendor/lib/modules/aw8624.ko
insmod /vendor/lib/modules/drv2624_mmi.ko
insmod /vendor/lib/modules/sx932x_sar.ko
insmod /vendor/lib/modules/tps61280.ko

umount /vendor
setprop crypto.ready 1
