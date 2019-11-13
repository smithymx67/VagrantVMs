# Ubuntu/eoan64 - Nagios

## Setup
Please install these plugin<br>
* `vagrant plugin install vagrant-vbguest`
* `vagrant plugin install vagrant-disksize`

---

## Commands
Run `vagrant up` to start<br>
Run `vagrant ssh` to connect<br>
Run `vagrant halt` to shutdown<br>
Run `vagrant destroy` to delete

---

## Public Access
Uncomment `config.vm.network "public_network"`<br>
Then select the interface to bridge when asked


https://draculaservers.com/tutorials/install-nagios-ubuntu/
https://www.digitalocean.com/community/tutorials/how-to-install-nagios-4-and-monitor-your-servers-on-ubuntu-18-04

https://github.com/NagiosEnterprises/nagioscore/releases
https://github.com/NagiosEnterprises/nrpe/releases