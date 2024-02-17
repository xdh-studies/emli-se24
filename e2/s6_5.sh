
user_name="test"
rpi_user_password="best"

rpi_user_password_hash=$(openssl passwd -6 $rpi_user_password)
echo "$user_name:$rpi_user_password_hash" >> /media/user/bootfs/userconf


cat <<EOF >> /media/user/rootfs/etc/network/interfaces.d/eth0
allow-hotplug eth0
iface eth0 inet static
address 10.0.0.10
network 10.0.0.0
netmask 255.255.255.0
gateway 10.0.0.1
EOF

touch /media/user/bootfs/ssh

echo "1.1.1.1" >> /media/user/rootfs/etc/resolv.conf
echo "8.8.8.8" >> /media/user/rootfs/etc/resolv.conf

umount /media/user/bootfs
umount /media/user/rootfs