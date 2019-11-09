#!/bin/bash

export RUN_FROM_SCRIPT='true'
export FIRST_RUN='true'
vagrant up --no-provision
vagrant ssh -c 'sudo apt update'
vagrant ssh -c 'sudo apt upgrade -y'
vagrant ssh -c 'sudo apt install -y build-essential module-assistant linux-headers-amd64 linux-image-amd64 python-pip'
vagrant ssh -c 'sudo m-a prepare'
vagrant halt
export FIRST_RUN='false'
vagrant up