#!/bin/bash -x

# Install puppet-agent if is not present
# also installs curl if not present

/opt/puppetlabs/bin/puppet --version && exit 0
cd /tmp || exit
command -v curl || apt-get install -y curl
curl -LO "https://apt.puppetlabs.com/puppet6-release-$(lsb_release -cs).deb"
dpkg -i "puppet6-release-$(lsb_release -cs).deb"
apt-get update
apt-get install -qy puppet-agent