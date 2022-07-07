#!/sbin/sh

# Locate the Userdata partition on a device

# find the boot device type
boot_device=$(getprop "ro.boot.bootdevice")
data_location=" "

echo "Boot Device: $boot_device"

# Listing Partitions in Boot Device
echo "Listing available partitons:\n"$(ls /dev/block/platform/soc/$boot_device/by-name)

# Finding the userdata partition
echo "Locating Userdata on $boot_device"

data_location=$(find /dev/block/platform/soc/$boot_device/by-name -name "userdata")

if [ $data_location == " " ]
then
    echo "Data Partition not found!"
else
    echo "Data Partition found here: $data_location"
fi

# Link Userdata
echo "Linking Userdata to /dev/block/bootdevice/"
ln -s $data_location /dev/block/bootdevice/by-name/userdata

echo "Quitting Script"

exit 0;
#