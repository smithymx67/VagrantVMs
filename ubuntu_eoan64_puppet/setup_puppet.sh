#!/bin/bash

cp /media/share/puppet/hosts /etc/hosts

apt update
apt install ntp ntpdate -y
ntpdate -u 0.ubuntu.pool.ntp.org
timedatectl set-timezone Europe/London

wget https://apt.puppetlabs.com/puppet6-release-bionic.deb
dpkg -i puppet6-release-bionic.deb

wget https://apt.puppet.com/puppet-tools-release-bionic.deb
dpkg -i puppet-tools-release-bionic.deb

apt update
apt install puppetserver -y
apt install puppet-bolt -y

rm -rf /etc/puppetlabs/code/environments/production
mkdir -p /etc/puppetlabs/code/environments/production
cp -R /media/share/puppet/etc/puppetlabs/code/environments/production/* /etc/puppetlabs/code/environments/production
cp /media/share/puppet/etc/default/puppetserver /etc/default/puppetserver

/opt/puppetlabs/bin/puppetserver ca setup

cd /etc/puppetlabs/code/environments/production
bolt puppetfile install

systemctl start puppetserver
systemctl enable puppetserver