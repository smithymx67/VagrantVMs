# Ubuntu/eoan64

## Setup
Please install these plugin<br>
* `vagrant plugin install vagrant-vbguest`
* `vagrant plugin install vagrant-disksize`

Run `vagrant up` to get started<br>
Run `vagrant ssh` to connect<br>
Run `vagrant halt` to shutdown<br>
Run `vagrant destroy` to delete

## Once provisioned
### To list certs
`puppetserver ca list`<br>
`puppetserver ca list --all`

### To sign a sert
`puppetserver ca sign --certname <cert_name>`

### To revoke a cert
`puppetserver ca revoke --certname <AGENT_NAME>`

### To sync client with puppet
`puppet agent --test`


https://www.bogotobogo.com/DevOps/Puppet/Puppet6-Install-on-Ubuntu18.0.4.php