FROM ubuntu:trusty
VOLUME /vagrant
RUN ["apt-get", "install", "puppet", "-y"]
RUN ["ls", "-l", "/vagrant"]
RUN ["puppet", "apply", "/vagrant/.provision/puppet/manifests/default.pp", "--modulepath=/vagrant/.provision/puppet/modules", "--verbose"]
