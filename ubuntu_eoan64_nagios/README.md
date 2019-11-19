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

## Known issues
There is an issue with apache data not being saved into the RRD file.<br>
The following is a snippet from `/usr/local/pnp4nagios/var/perfdata.log`

```
2019-11-19 08:54:10 [27606] [0] RRDs::update /usr/local/pnp4nagios/var/perfdata/nagios/apache.rrd 1574153646:1:8:6:9:0:0:0:0:0:9:0:0:140:0:1:0:715:325:2487

2019-11-19 08:54:10 [27606] [0] RRDs::update ERROR /usr/local/pnp4nagios/var/perfdata/nagios/apache.rrd: found extra data on update argument: 2487
```

To address this issue, I have found that deleting the `apache.rrd` files fixes this issue, you will however loose any previous data.

Run the following to remove the files:<br>
`find /usr/local/pnp4nagios/var/perfdata -name "apache.rrd" -type f -delete`

They should be regernerated on the next update and the apache graphs should be working again.

--- 

## Useful Links
https://draculaservers.com/tutorials/install-nagios-ubuntu/<br>
https://www.digitalocean.com/community/tutorials/how-to-install-nagios-4-and-monitor-your-servers-on-ubuntu-18-04<br>
https://github.com/NagiosEnterprises/nagioscore/releases<br>
https://github.com/NagiosEnterprises/nrpe/releases<br>
https://github.com/lingej/pnp4nagios/releases