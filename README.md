# Testing vm project

### Install instructions
##### 1. The requirements for this project are:
* Linux/Unix or OS X based environment.
* [Virtualbox](https://www.virtualbox.org/wiki/Downloads)
* [Vagrant](https://www.vagrantup.com/downloads.html) with omnibus, berkshelf and cachier(optional) [plugins](http://docs.vagrantup.com/v2/plugins/usage.html) installed. 
         
##### There are 3 available chef-roles on this project: jenkins node, dev node with ONGR and oxid e-shop node. To switch between them, uncomment a desired role in the Vagrantfile before running `vagrant up`.

##### To edit specific values for service configuration files, use the node default attribute files for each node:
* [dev node attributes](cookbooks/dev/attributes/default.rb)
* [jenkins node attributes](cookbooks/myjenkins/attributes/default.rb)
* [dev node attributes](cookbooks/oxideshop/attributes/default.rb)

Run the following commands to start project:

1. `git clone git@github.com:kazgurs/testing-vm.git`
2. `cd testing-vm`
3. `vagrant up` 
4. `vagrant ssh`

### What's inside

* all instances comprise of LEMP stacks with nginx, php5-fpm and MySQL 5.5
* jenkins stack:
    * plugins: git, rbenv, ruby-runtime, scm-api, s3
* ongr stack:
    * 
* oxid stack:
    * Oxid CE, 
