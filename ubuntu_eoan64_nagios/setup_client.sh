#!/bin/bash

apt update
apt install autoconf gcc libmcrypt-dev make libssl-dev wget dc build-essential gettext nagios-nrpe-server apache2 php libapache2-mod-php -y

useradd nagios

cd ~
curl -L -O https://nagios-plugins.org/download/nagios-plugins-2.2.1.tar.gz
tar zxf nagios-plugins-2.2.1.tar.gz
cd nagios-plugins-2.2.1
./configure
make
make install

cp /media/share/client/etc/nagios/nrpe.cfg /etc/nagios/nrpe.cfg
cp /media/share/client/etc/nagios/nrpe.d/core.cfg /etc/nagios/nrpe.d/core.cfg
cp /media/share/client/etc/nagios/nrpe.d/services.cfg /etc/nagios/nrpe.d/services.cfg

mkdir /usr/lib/nagios/custom
cp /media/share/nagios/usr/local/nagios/libexec/check_mem /usr/lib/nagios/custom/check_mem
cp /media/share/nagios/usr/local/nagios/libexec/check_apache /usr/lib/nagios/custom/check_apache
chmod +x /usr/lib/nagios/custom/check_mem
chmod +x /usr/lib/nagios/custom/check_apache

/etc/init.d/nagios-nrpe-server restart

ufw -f enable
ufw allow 22
ufw allow 80
ufw allow 5666
ufw reload

a2enmod cgi rewrite
systemctl restart apache2