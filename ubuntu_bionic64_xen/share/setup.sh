#!/bin/bash

apt update
apt install xen-hypervisor-amd64 xen-tools vim -y
pvcreate /dev/sdc
vgcreate vg0 /dev/sdc
update-grub
cp /media/share/50-cloud-init.yaml /etc/netplan/
netplan apply
reboot