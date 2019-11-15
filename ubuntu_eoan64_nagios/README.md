# Ubuntu/eoan64 - Nagios

## Setup
Please install these plugin<br>
* `vagrant plugin install vagrant-vbguest`
* `vagrant plugin install vagrant-disksize`

---

## Commands
Run `vagrant up` to start<br>
Run `vagrant ssh <nagios|client>` to connect<br>
Run `vagrant halt` to shutdown<br>
Run `vagrant destroy` to delete

---

## Usage
Once provisioned, you can access nagios at http://10.0.0.10<br>
Login using `nagiosadmin` as the username and password<br>
From there you can view stats and graphs for both VMs

---

## Useful Links
https://draculaservers.com/tutorials/install-nagios-ubuntu/<br>
https://www.digitalocean.com/community/tutorials/how-to-install-nagios-4-and-monitor-your-servers-on-ubuntu-18-04<br>
https://github.com/NagiosEnterprises/nagioscore/releases<br>
https://github.com/NagiosEnterprises/nrpe/releases<br>
https://github.com/lingej/pnp4nagios/releases