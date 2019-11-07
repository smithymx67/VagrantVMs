#!/bin/bash

cp /mnt/share/interfaces /etc/network/
service networking restart
reboot