#!/bin/bash

# Function to get current IP address
get_current_ip() {
    current_ip=$(uci get network.lan.ipaddr)
}

# Update lists_dir in opkg.conf
sed -i -e "/^lists_dir\s/s:/var/opkg-lists$:/usr/lib/opkg/lists:" /etc/opkg.conf
opkg update

# Add force_space option to opkg.conf
echo option force_space >> /etc/opkg.conf

# Download and install luci-theme-argon
wget -O /tmp/luci-theme-argon_2.3_all.ipk https://github.com/peditx/PeDitXrt-rebirth/raw/main/apps/luci-theme-argon_2.3_all.ipk
opkg install /tmp/luci-theme-argon_2.3_all.ipk

# Download and install luci-app-argon-config
wget -O /tmp/luci-app-argon-config_0.9_all.ipk https://github.com/peditx/PeDitXrt-rebirth/raw/main/apps/luci-app-argon-config_0.9_all.ipk
opkg install /tmp/luci-app-argon-config_0.9_all.ipk

# Install luci-lib-ipkg
opkg install luci-lib-ipkg

# Ask for swap size
read -p "Enter swap size in MB (press Enter for default 1024MB): " swap_size
swap_size=${swap_size:-1024}

# Create and activate swap file
DIR="$(uci -q get fstab.extroot.target)"
dd if=/dev/zero of=${DIR}/swap bs=1M count=$swap_size
mkswap ${DIR}/swap

uci -q delete fstab.swap
uci set fstab.swap="swap"
uci set fstab.swap.device="${DIR}/swap"
uci commit fstab
service fstab boot

# Set hostname
uci set system.@system[0].hostname=PeDitXrt
uci commit system

# Install and configure packages
opkg remove dnsmasq
opkg install dnsmasq-full
opkg install kmod-nft-tproxy kmod-nft-socket

# Add passwall repository and install related packages
wget -O passwall.pub https://master.dl.sourceforge.net/project/openwrt-passwall-build/passwall.pub
opkg-key add passwall.pub

read release arch << EOF
$(. /etc/openwrt_release ; echo ${DISTRIB_RELEASE%.*} $DISTRIB_ARCH)
EOF
for feed in passwall_luci passwall_packages passwall2; do
  echo "src/gz $feed https://master.dl.sourceforge.net/project/openwrt-passwall-build/releases/packages-$release/$arch/$feed" >> /etc/opkg/customfeeds.conf
done

opkg update
opkg install v2ray-core brook hysteria trojan-go sing-box
opkg install luci-app-passwall luci-app-passwall2 v2ray-geosite-ir

# Get current IP address
get_current_ip

# Select router IP
echo "Select the number corresponding to the IP range for the router:"
select ip_option in "10.1.1.1" "11.1.1.1" "192.168.22.1" "192.168.1.1" "192.168.0.1"; do
    case $REPLY in
        1) router_ip="10.1.1.1"; break;;
        2) router_ip="11.1.1.1"; break;;
        3) router_ip="192.168.22.1"; break;;
        4) router_ip="192.168.1.1"; break;;
        5) router_ip="192.168.0.1"; break;;
        *) echo "No option selected, router IP remains unchanged."; router_ip=""; break;;
    esac
done

if [ ! -z "$router_ip" ]; then
    if [ "$router_ip" != "$current_ip" ]; then
        uci set network.lan.ipaddr="$router_ip"
        uci commit network
        /etc/init.d/network restart
        echo "Now you can connect to the device with the IP you chose: $router_ip"
    else
        echo "The selected IP is the same as the current device IP. No change has been made."
    fi
fi

# Reboot the device
echo "Rebooting the device..."
reboot
