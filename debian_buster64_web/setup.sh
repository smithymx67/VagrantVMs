#!/bin/bash

apt update
apt install apache2 -y
apt install curl -y
apt install mariadb-server -y
apt install php libapache2-mod-php php-mysql php-cli php-mbstring -y
apt install curl git unzip
curl -sL https://deb.nodesource.com/setup_13.x | bash -
apt-get install -y nodejs
curl -sS https://getcomposer.org/installer -o composer-setup.php
php composer-setup.php --install-dir=/usr/local/bin --filename=composer