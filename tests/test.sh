#!/usr/bin/env bash


# debug output
echo ""
echo "source from $PWD"
echo ""
BASE_DIR=$PWD
source $BASE_DIR"/config/config.txt"
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
