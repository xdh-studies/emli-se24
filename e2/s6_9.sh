
# Set variable from env var
wifi_interface=$WIFI_INTERFACE
wifi_username=$WIFI_USERNAME
wifi_password=$WIFI_PASSWORD


raspi-config nonint do_wifi_country DK
nmcli d wifi list
nmcli d wifi connect "eduroam" password "password" ifname wlan0

sysctl -w net.ipv4.ip_forward=0
ip route show