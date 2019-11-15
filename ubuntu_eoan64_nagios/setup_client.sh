#!/bin/bash

apt update
apt install autoconf gcc libmcrypt-dev make libssl-dev wget dc build-essential gettext nagios-nrpe-server -y

useradd nagios

cd ~
curl -L -O https://nagios-plugins.org/download/nagios-plugins-2.2.1.tar.gz
tar zxf nagios-plugins-2.2.1.tar.gz
cd nagios-plugins-2.2.1
./configure
make
make install

cp /media/share/nrpe.cfg /etc/nagios/nrpe.cfg
cp /media/share/core.cfg /etc/nagios/nrpe.d/core.cfg

mkdir /usr/lib/nagios/custom
cp /media/share/check_mem /usr/lib/nagios/custom/check_mem
chmod +x /usr/lib/nagios/custom/check_mem

/etc/init.d/nagios-nrpe-server restart

ufw -f enable
ufw allow 22
ufw allow 5666
ufw reload