#!/usr/bin/env bash


# debug output
echo ""
echo "read config file from $HOME"
echo ""
CONFIG_FILE="$HOME/.yawap.config"
if [ ! -f "$CONFIG_FILE" ]; then
    echo "Error: Configuration file not found!"
    echo "Exit now"
    exit 1
fi
source "$CONFIG_FILE"
echo $AP_DEVICE

# debug output
echo ""
echo "/etc/init.d/hostapd"
echo ""
cat /etc/init.d/hostapd

# debug output
echo ""
echo "/etc/dnsmasq.conf"
echo ""
cat /etc/dnsmasq.conf

# debug output
echo ""
echo "/etc/hostapd/hostapd.conf"
echo ""
cat /etc/hostapd/hostapd.conf

# debug output
echo ""
echo "ifconfig"
echo ""
sudo ifconfig

# debug output
echo ""
echo "IPtables"
echo ""
sudo iptables -L
