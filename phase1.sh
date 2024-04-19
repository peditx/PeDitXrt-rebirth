#!/bin/sh

# Display welcome message
echo "PeDitX"
echo "Phase 1"
echo "easy exroot"
echo "-----------------------------------"

# Update package lists
opkg update

# Install required packages
opkg install kmod-usb-storage kmod-usb-storage-uas usbutils block-mount kmod-fs-ext4 e2fsprogs parted curl gdisk kmod-usb-storage-extras

# List block devices
ls -l /sys/block

# Define disk device
DISK="/dev/sda"

# Determine total USB storage size
TOTAL_SIZE=$(block info ${DISK} | grep -oP '(?<=Size:\s)\d+')

# Ask user if they want to use the entire USB storage
echo "Do you want to use the entire USB storage for the partition? (y/n)"
read USE_FULL_STORAGE

if [ "$USE_FULL_STORAGE" = "y" ]; then
    PART_SIZE=${TOTAL_SIZE}
else
    # Ask user for partition size
    echo "Enter partition size (in MiB, e.g., 1024 for 1GiB):"
    read PART_SIZE
fi

# Create partition
parted -s ${DISK} -- mklabel gpt mkpart extroot 2048s ${PART_SIZE}MiB

# Wait for udev to settle
sleep 2

# Format partition as ext4
DEVICE="${DISK}1"
mkfs.ext4 -L extroot ${DEVICE}

# Get UUID of the partition
eval $(block info ${DEVICE} | grep -o -e 'UUID="\S*"')

# Get mount point of the partition
eval $(block info | grep -o -e 'MOUNT="\S*/overlay"')

# Configure fstab
uci -q delete fstab.extroot
uci set fstab.extroot="mount"
uci set fstab.extroot.uuid="${UUID}"
uci set fstab.extroot.target="${MOUNT}"
uci commit fstab

# Mount the partition and copy contents
mount ${DEVICE} /mnt
tar -C ${MOUNT} -cvf - . | tar -C /mnt -xf -

# Get device for overlay partition
DEVICE="$(block info | sed -n -e '/MOUNT="\S*\/overlay"/s/:\s.*$//p')"

# Configure fstab for overlay partition
uci -q delete fstab.rwm
uci set fstab.rwm="mount"
uci set fstab.rwm.device="${DEVICE}"
uci set fstab.rwm.target="/rwm"
uci commit fstab

# Download banner file
curl -o /etc/banner https://raw.githubusercontent.com/peditx/PeDitXrt/openwrt-21.02/package/base-files/files/etc/banner

# Update opkg configuration
sed -i -e "/^lists_dir\s/s:/var/opkg-lists$:/usr/lib/opkg/lists:" /etc/opkg.conf

# Display instruction message
echo "Before rebooting, please follow the instructions provided at https://t.me/peditx or on the GitHub repository to continue the PeDitXrt rebirth process."
echo "If you don't follow the instructions, the process won't complete."

# Wait for user confirmation to proceed with reboot
echo "Press Enter to proceed with rebooting..."
read

# Reboot the system
reboot
