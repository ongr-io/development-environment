# ONGR testing VM

This is the repository to play with [ONGR Demo](https://github.com/ongr-io/Demo) or run unit and functional tests for the bundles if you dont have your own environment. 

[![Build Status](http://img.shields.io/travis/ongr-io/testing-vm.svg)](https://travis-ci.org/ongr-io/testing-vm)
[![GitHub issues](https://img.shields.io/github/issues/ongr-io/testing-vm.svg?style=flat-square)](https://github.com/ongr-io/testing-vm/issues)
[![GitHub license](https://img.shields.io/badge/license-MIT-blue.svg?style=flat-square)](https://raw.githubusercontent.com/ongr-io/testing-vm/master/LICENSE)

<img src="https://cloud.githubusercontent.com/assets/12516828/11679876/007f6f74-9e5d-11e5-9804-c5ba978c516e.png" width="80" height="80">
<img src="https://cloud.githubusercontent.com/assets/12516828/11679879/0082c5d4-9e5d-11e5-89fe-33c53506c6c7.jpg" width="80" height="80">
<img src="https://cloud.githubusercontent.com/assets/12516828/11679877/007faade-9e5d-11e5-8c47-218a0915a693.png" width="80" height="80">
<img src="https://cloud.githubusercontent.com/assets/12516828/11679874/00542198-9e5d-11e5-845f-0b917fb323c5.png" width="80" height="80">
<img src="https://cloud.githubusercontent.com/assets/12516828/11679926/5e83b5b2-9e5d-11e5-8499-acea5399b2ac.png" width="80" height="80">
<img src="https://cloud.githubusercontent.com/assets/12516828/11679878/0081c382-9e5d-11e5-9fd6-05163acd3af7.png" width="80" height="80">


## Prerequisites
  * Linux/Unix or OS X based operating system.
  * [Virtualbox](https://www.virtualbox.org/wiki/Downloads)
  * [Vagrant](https://www.vagrantup.com/downloads.html)

> Recommendation: Install `Virtualbox` before Vagrant.

## Install instructions

Clone this repository:

```bash
git clone https://github.com/ongr-io/testing-vm.git
```

Go in to the folder:

```bash
cd testing-vm
```

Run `vagrant up` to start and provision the machine.

That's it. 

## Customization
The VM should hold all of the components needed to test ONGR bundles. To customize various settings, such as nginx, php, mariadb, ES configuration, edit the following ansible vars `ansible/vars/vagrant.yml`. For remote provision, it's `ansible/vars/remote.yml`.

## Remote provision

The `ansible/remote.yml` playbook can be used to provision a remote ubuntu host that you have root access to. This has to be ran from a machine that has ansible installed (no Windows support).

Firstly, edit your ansible inventory and add the IP address of your remote host(s). This can be done within global ansible [inventory](http://docs.ansible.com/ansible/intro_inventory.html) or in your project: `ansible/iventories/ongr`. The default settings for the remote run are defined in your project's `ansible.cfg`, so make sure to run the remote playbook inside the project folder:

```
ansible-playbook ansible/remote.yml
```

## What's inside

* LEMP stack: nginx, php5-fpm and mariaDB
* git
* vim
* java JDK
* elasticsearch
* nodejs
* composer
* xdebug
* bower
* gulp

#### Fast recurring provision times!
![](https://cloud.githubusercontent.com/assets/12516828/11679885/131e650e-9e5d-11e5-8b16-dd46d73c6cc7.gif)

##License
MIT - see the accompanying [LICENSE](https://github.com/ongr-io/testing-vm/blob/master/LICENSE) file for details.
