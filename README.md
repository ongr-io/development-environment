# Testing vm project

### Install instructions

Run the following commands to start the project:

1. `git clone https://github.com/ongr-io/testing-vm.git`
2. `cd testing-vm`
3. `vagrant up`
4. `vagrant ssh`

### Using together with ONGR sandbox

Clone the official ONGR sandbox repo together with this testing-vm:

````
git clone --recursive https://github.com/ongr-io/ongr-sandbox.git
````
Or with:
````
git clone https://github.com/ongr-io/ongr-sandbox.git
git submodule init
git submodule update
````
Then run `vagrant up` inside vagrant subdirectory.

#### What's inside

* Ubuntu Trusty x64
* LEMP stack: nginx, php5-fpm and MySQL 5.5
* Java 1.7 JDK,
* elasticsearch 1.4
* git
* composer
* nodejs
* bower
* gulp
* compass
* xdebug
* phantomjs
* casperjs
