#!/usr/bin/env bash

# Check if config file exists.
if [ ! -f "$HOME/.yawap.config" ]; then
    echo "Error: Configuration file not found!"
    echo "Exit now"
    exit 1
fi

# Load configuration file.
source "$HOME/.yawap.config"

# Update repository and install some packages
apt-get update
apt-get install -y hostapd dnsmasq wireless-tools net-tools iw wvdial

# Once everything is installed, we configure dnsmasq to serve DHCP and
# DNS on the wireless interface and then start the dnsmasq service.
sed -i 's#^DAEMON_CONF=.*#DAEMON_CONF=/etc/hostapd/hostapd.conf#' /etc/init.d/hostapd

# Writing dnsmasq configuration file.
# -----------------------------------
echo " " >> $DNSMASQ_CONF
echo "# YaWaP Configuration" >> $DNSMASQ_CONF
echo "log-facility=/var/log/dnsmasq.log" >> $DNSMASQ_CONF
echo "#address=/#/10.0.0.1" >> $DNSMASQ_CONF
echo "#address=/google.com/10.0.0.1" >> $DNSMASQ_CONF
echo "interface="$AP_DEVICE >> $DNSMASQ_CONF
echo "dhcp-range=10.0.0.10,10.0.0.250,12h" >> $DNSMASQ_CONF
echo "dhcp-option=3,10.0.0.1" >> $DNSMASQ_CONF
echo "dhcp-option=6,10.0.0.1" >> $DNSMASQ_CONF
echo "#no-resolv" >> $DNSMASQ_CONF
echo "log-queries" >> $DNSMASQ_CONF

# Writing hostapd configuration file.
# -----------------------------------
touch $HOSTAPD_CONF
echo "# YaWaP Configuration" > $HOSTAPD_CONF
echo "interface="$AP_DEVICE >> $HOSTAPD_CONF
echo "driver=nl80211" >> $HOSTAPD_CONF
echo "ssid=FreeWifi" >> $HOSTAPD_CONF
echo "channel=1" >> $HOSTAPD_CONF

# Bring up Access Point
ifconfig $AP_DEVICE up
ifconfig $AP_DEVICE 10.0.0.1/24

# Setup iptables
iptables -t nat -F
iptables -F
iptables -t nat -A POSTROUTING -o $WAN_DEVICE -j MASQUERADE
iptables -A FORWARD -i $AP_DEVICE -o $WAN_DEVICE -j ACCEPT
echo '1' > /proc/sys/net/ipv4/ip_forward


echo .
echo "Run following commands in seperate terminal windows."
echo .
echo dnsmasq -C /etc/dnsmasq.conf -d
echo hostapd /etc/hostapd/hostapd.conf

