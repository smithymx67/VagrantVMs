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
### Request a cert
On the client, first check that the hostname, domain and FQDN are as expected using `facter fqdn domain hostname`<br>
If correct, request a cert from the server using `puppet agent --test`

### Sign a cert
On the server, run `puppetserver ca list` to list all requested certificates<br>
Sign a certificate using `puppetserver ca sign --certname <cert_name>`

### Sync client wit server
Once signed, run `puppet agent --test` again on the client<br>
This will update the client according to puppet definitions

## Command Reference
### To list certs
`puppetserver ca list`<br>
`puppetserver ca list --all`

### To sign a sert
`puppetserver ca sign --certname <cert_name>`

### To revoke a cert
`puppetserver ca revoke --certname <AGENT_NAME>`

### To clean a cert
`puppetserver ca clean --certname <AGENT_NAME>`

### To sync client with puppet
`puppet agent --test`



root@puppet:/etc/puppetlabs/code/environments# rm -rf /etc/puppetlabs/code/environments/production && mkdir -p /etc/puppetlabs/code/environments/production && cp -R /media/share/puppet/etc/puppetlabs/code/environments/production/* /etc/puppetlabs/code/environments/production && cd production/ && bolt puppetfile install && cd ../