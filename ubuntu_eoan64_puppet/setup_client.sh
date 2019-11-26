#!/bin/bash

cp /media/share/client/client_hosts /etc/hosts

/opt/puppetlabs/bin/puppet --version && exit 0
cd /tmp || exit
command -v curl || apt-get install -y curl
curl -LO "https://apt.puppetlabs.com/puppet6-release-bionic.deb"
dpkg -i "puppet6-release-bionic.deb"
apt-get update
apt-get install -qy puppet-agent
