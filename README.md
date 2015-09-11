# Testing vm project

### Install instructions
1. The requirements for this project are:
  * Linux/Unix or OS X based environment.
  * [Virtualbox](https://www.virtualbox.org/wiki/Downloads)
  * [Vagrant](https://www.vagrantup.com/downloads.html) with `omnibus`, `berkshelf`, `hostsupdater` [plugins](http://docs.vagrantup.com/v2/plugins/usage.html) installed.
         
2. Clone this repository `git clone git@github.com:kazgurs/testing-vm.git` and navigate to the testing-vm directory. There are 3 available chef-roles on this project: jenkins VM, dev VM with ONGR and oxid e-shop VM. 

3. To edit specific values for configuration files, use the node default attribute files for each node:
  * [dev node attributes](cookbooks/dev/attributes/default.rb)
  * [jenkins node attributes](cookbooks/myjenkins/attributes/default.rb)
  * [oxid node attributes](cookbooks/oxideshop/attributes/default.rb)

4. When you have desired settings layed out go ahead and spin up a specific node:
 ```
 vagrant up dev
 vagrant up jenkins
 vagrant up oxid
 ```
or to start all 3 nodes simultaneously, simply run `vagrant up`. 
### What's inside

* all instances comprise of LEMP stacks with nginx, php5-fpm and MySQL 5.5
* jenkins stack:
    * plugins: git, rbenv, ruby-runtime, scm-api, s3
* ongr stack:
    * Java 1.7 JDK, elasticsearch 1.7.1, git, composer, nodejs, compass, xdebug, phantomjs
* oxid stack:
    * Oxid CE on LEMP stack
