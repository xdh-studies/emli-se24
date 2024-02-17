#!/bin/bash


# Print existing iproutes
iptables -L


echo "Changing iptables"
wifi_interface=$(ip route | grep default | awk '{print $5}')
sysctl -w net.ipv4.ip_forward=1
iptables -t nat -A POSTROUTING -o $wifi_interface -j MASQUERADE

# Print new iproutes
iptables -L