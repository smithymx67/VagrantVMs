#!/bin/bash

apt update
apt install wget build-essential unzip openssl libssl-dev -y
apt install apache2 php libapache2-mod-php php-gd libgd-dev -y
adduser --disabled-password --gecos "" nagios
groupadd nagcmd
usermod -a -G nagcmd nagios
usermod -a -G nagcmd www-data

cd /opt
wget https://github.com/NagiosEnterprises/nagioscore/releases/download/nagios-4.4.5/nagios-4.4.5.tar.gz
tar xzf nagios-4.4.5.tar.gz
cd nagios-4.4.5
./configure --with-command-group=nagcmd
make all
make install
make install-init
make install-daemoninit
make install-config
make install-commandmode
make install-exfoliation
cp -R contrib/eventhandlers/ /usr/local/nagios/libexec/
chown -R nagios:nagios /usr/local/nagios/libexec/eventhandlers

cp /media/share/nagios.conf /etc/apache2/conf-available/nagios.conf
htpasswd -bc /usr/local/nagios/etc/htpasswd.users admin admin
a2enconf nagios
a2enmod cgi rewrite
systemctl restart apache2

cd /opt
wget http://www.nagios-plugins.org/download/nagios-plugins-2.2.1.tar.gz
tar xzf nagios-plugins-2.2.1.tar.gz
cd nagios-plugins-2.2.1
./configure --with-nagios-user=nagios --with-nagios-group=nagios --with-openssl
make
make install
/usr/local/nagios/bin/nagios -v /usr/local/nagios/etc/nagios.cfg
systemctl start nagios
systemctl enable nagios

cd /opt
curl -L -O https://github.com/NagiosEnterprises/nrpe/releases/download/nrpe-3.2.1/nrpe-3.2.1.tar.gz
tar zxf nrpe-3.2.1.tar.gz
cd nrpe-3.2.1
./configure
make check_nrpe
make install-plugin
cp /media/share/nagios.cfg /usr/local/nagios/etc/nagios.cfg
cp /media/share/contacts.cfg /usr/local/nagios/etc/objects/contacts.cfg
mkdir /usr/local/nagios/etc/servers
cp /media/share/commands.cfg /usr/local/nagios/etc/objects/commands.cfg
systemctl reload nagios