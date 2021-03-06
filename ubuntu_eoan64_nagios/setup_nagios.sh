#!/bin/bash

apt update
apt install wget build-essential unzip openssl libssl-dev rrdtool librrds-perl -y
apt install apache2 php libapache2-mod-php php-gd libgd-dev php-xml -y

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
cp /media/share/nagios/etc/apache2/conf-available/nagios.conf /etc/apache2/conf-available/nagios.conf
cp /media/share/nagios/etc/apache2/sites-available/000-default.conf /etc/apache2/sites-available/000-default.conf
cp /media/share/nagios/etc/apache2/sites-available/nagios.conf /etc/apache2/sites-available/nagios.conf
htpasswd -bc /usr/local/nagios/etc/htpasswd.users nagiosadmin nagiosadmin
a2enconf nagios
a2ensite nagios
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

cd /opt
mkdir pnp4nagios
cd pnp4nagios
git clone https://github.com/lingej/pnp4nagios.git .
./configure --with-httpd-conf=/etc/apache2/sites-available
make all
make install
make install-webconf
make install-config
make install-init
rm /usr/local/pnp4nagios/share/install.php
cp /media/share/nagios/usr/local/pnp4nagios/etc/check_commands/nrpe.cfg /usr/local/pnp4nagios/etc/check_commands/nrpe.cfg
cp /media/share/nagios/usr/local/pnp4nagios/share/templates/* /usr/local/pnp4nagios/share/templates/
cp /media/share/nagios/usr/local/pnp4nagios/etc/pages/* /usr/local/pnp4nagios/etc/pages/
ln -s /usr/local/pnp4nagios/share/templates/check_disk.php /usr/local/pnp4nagios/share/templates/check_root.php
ln -s /usr/local/pnp4nagios/share/templates/check_disk.php /usr/local/pnp4nagios/share/templates/check_swap.php
cp /media/share/nagios/etc/apache2/sites-available/pnp4nagios.conf /etc/apache2/sites-available/pnp4nagios.conf
a2ensite pnp4nagios
systemctl restart apache2

mkdir /etc/nagios
mv /usr/local/nagios/etc/* /etc/nagios/
rm -r /usr/local/nagios/etc
ln -s /etc/nagios/ /usr/local/nagios/etc
mkdir /etc/nagios/conf.d

mkdir /usr/lib/nagios
mkdir /usr/lib/nagios/plugins/
cp /media/share/nagios/usr/local/nagios/etc/nagios.cfg /usr/local/nagios/etc/nagios.cfg
cp /media/share/nagios/usr/local/nagios/etc/cgi.cfg /usr/local/nagios/etc/cgi.cfg
cp /media/share/nagios/usr/local/nagios/etc/resource.cfg /usr/local/nagios/etc/resource.cfg
mv /usr/local/nagios/libexec/* /usr/lib/nagios/plugins/
rm -r /usr/local/nagios/etc/objects

cp /media/share/nagios/usr/local/nagios/etc/conf.d/00.templates.cfg /usr/local/nagios/etc/conf.d/00.templates.cfg
cp /media/share/nagios/usr/local/nagios/etc/conf.d/01.contacts.cfg /usr/local/nagios/etc/conf.d/01.contacts.cfg
cp /media/share/nagios/usr/local/nagios/etc/conf.d/01.groups.cfg /usr/local/nagios/etc/conf.d/01.groups.cfg
cp /media/share/nagios/usr/local/nagios/etc/conf.d/01.timeperiods.cfg /usr/local/nagios/etc/conf.d/01.timeperiods.cfg
cp /media/share/nagios/usr/local/nagios/etc/conf.d/02.commands.cfg /usr/local/nagios/etc/conf.d/02.commands.cfg
cp /media/share/nagios/usr/local/nagios/etc/conf.d/02.services.cfg /usr/local/nagios/etc/conf.d/02.services.cfg
cp /media/share/nagios/usr/local/nagios/etc/conf.d/20.HOST.LOCAL.nagios.cfg /usr/local/nagios/etc/conf.d/20.HOST.LOCAL.nagios.cfg
cp /media/share/nagios/usr/local/nagios/etc/conf.d/20.HOST.NRPE.client.cfg /usr/local/nagios/etc/conf.d/20.HOST.NRPE.client.cfg
cp /media/share/nagios/usr/local/nagios/etc/conf.d/40.HOST.NRPE-CHECK.nagios.webserver.cfg /usr/local/nagios/etc/conf.d/40.HOST.NRPE-CHECK.nagios.webserver.cfg
cp /media/share/nagios/usr/local/nagios/etc/conf.d/40.HOST.NRPE-CHECK.client.webserver.cfg /usr/local/nagios/etc/conf.d/40.HOST.NRPE-CHECK.client.webserver.cfg
cp /media/share/nagios/usr/local/nagios/libexec/check_mem /usr/local/nagios/libexec/check_mem
cp /media/share/nagios/usr/local/nagios/libexec/check_apache /usr/local/nagios/libexec/check_apache

chmod +x /usr/local/nagios/libexec/check_mem
chmod +x /usr/local/nagios/libexec/check_apache

systemctl restart nagios
systemctl restart apache2

ufw -f enable
ufw allow 22
ufw allow 80
ufw reload