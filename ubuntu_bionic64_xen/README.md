# Ubuntu/bionic64 Xen

## Prerequisites
Please install these plugin<br>
* `vagrant plugin install vagrant-vbguest`
* `vagrant plugin install vagrant-disksize`

**I consider this setup a single use throw away VM, it does not like being restarted or brought up with vagrant commands. Xen seems to break VBox Guest Additions.**

## Setup Steps
* Run `vagrant up`
* Connect and run `sudo /media/share/setup.sh`
* Once the system has rebooted, you can play with Xen

---

## Useful Commands
| Description                     | Command                                 |
| ------------------------------- | --------------------------------------- |
| Enter real root                 |`sudo -i`                                |
| See list of disks               |`fdisk -l`                               |
| Create LVM drive                |`lvcreate -n test-vm-data -L 10G vg0`    |
| Remove LVM drive                |`lvremove /dev/vg0/test-vm-data`         |
| Show logical vols               |`lvdisplay`                              |
| Show vol groups                 |`vgdisplay`                              |
| Show physical vols              |`pvdisplay`                              |
| View info about system          |`xl info`                                |
| List all running domains        |`xl list`                                |
| Show stats on running domains   |`xl top`                                 |
| Run a guest                     |`xl create -c /etc/xen/my-guest.cfg`     |
| Connect to a guest console      |`xl console my-guest`                    |
| Escape a guest console          |`Ctrl+]`                                 |
| Shutdown a guest                |`xl shutdown my-guest`                   |
| Destroy a guest                 |`xl destroy my-guest`                    |
| Reboot a guest                  |`xl reboot my-guest`                     |
| Deleting a guest                |`xen-delete-image my-guest`              |

---

## Process of creating an image
`xen-create-image --hostname=my-guest --memory=512mb --vcpus=1 --lvm=vg0 --dhcp --pygrub --dist=buster --size=10gb --swap=1gb --password=root`

`--dist` can be debian code names, for example, buster<br>
<https://manpages.debian.org/buster/xen-tools/xen-create-image.8.en.html>

---

## Starting a guest
* `xl create -c /etc/xen/my-guest.cfg`

---

## Deleting a guest (the manual way)
* `xl shutdown my-guest`
* `rm /etc/xen/my-guest.cfg`
* `lvremove /dev/vg0/my-guest-disk`
* `lvremove /dev/vg0/my-guest-swap`