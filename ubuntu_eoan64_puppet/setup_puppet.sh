#!/bin/bash

cp /media/share/puppet/puppet_hosts /etc/hosts

apt update
apt install ntp ntpdate -y
ntpdate -u 0.ubuntu.pool.ntp.org
timedatectl set-timezone Europe/London

wget https://apt.puppetlabs.com/puppet6-release-bionic.deb
dpkg -i puppet6-release-bionic.deb
apt update
apt install puppetserver -y

/opt/puppetlabs/bin/puppetserver ca setup
cp /media/share/puppet/puppetserver /etc/default/puppetserver
cp /media/share/puppet/puppet.conf /etc/puppet/puppet.conf

systemctl start puppetserver
systemctl enable puppetserver

cp /media/share/puppet/code/environments/production/manifests/site.pp /etc/puppetlabs/code/environments/production/manifests/site.pp