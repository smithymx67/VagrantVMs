#!/bin/bash

apt update
apt install xen-system xen-tools vim -y
pvcreate /dev/sdb
vgcreate vg0 /dev/sdb
update-grub
cp /media/share/interfaces /etc/network/
service networking restart
reboot
