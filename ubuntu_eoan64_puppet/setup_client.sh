#!/bin/bash

cp /media/share/client/client_hosts /etc/hosts

wget https://apt.puppetlabs.com/puppet6-release-bionic.deb
dpkg -i puppet6-release-bionic.deb
apt update
apt install puppet-agent -y
/opt/puppetlabs/bin/puppet resource service puppet ensure=running enable=true

export PATH=/opt/puppetlabs/bin:$PATH
puppet config set server puppet
/opt/puppetlabs/bin/puppet config set certname client
