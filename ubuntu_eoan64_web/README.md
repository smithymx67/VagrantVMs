# Debian/buster64

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

## Secure the database
You can run `mysql_secure_installation` to secure the mysql database

---

## Access the datbase console
You can access the database using `mariadb` or `mysql`

---

## Public Access
Uncomment `config.vm.network "public_network"`<br>
Then select the interface to bridge when asked

--

## Composer and Node
Composer can be used with the command `composer`<br>
Node and NPM is also installed, `node` and `npm`