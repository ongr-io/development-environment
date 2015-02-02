# -*- mode: ruby -*-
# vi: set ft=ruby :
# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"
Vagrant.require_version ">= 1.6"
Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = "nfq/docker"
  config.vm.network :private_network, ip: "192.168.32.50"
  config.ssh.forward_agent = true

  config.vm.provider :virtualbox do |v|
    v.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
    v.customize ["modifyvm", :id, "--memory", 1024]
    v.customize ["setextradata", :id, "--VBoxInternal2/SharedFoldersEnableSymlinksCreate/v-root", "1"]
  end

  config.vm.hostname = "foxtestvm"

  config.vm.synced_folder "./", "/var/www", id: "vagrant-root" , :type => "nfs"
  config.vm.provision :shell, :path => "provision/install.sh"
  
  config.vm.provision :puppet do |puppet|
    puppet.manifests_path = "provision/manifests"
    puppet.options = ["--verbose", "--debug", "--hiera_config /vagrant/hiera.yaml", "--parser future"]
    puppet.facter = { 
        "ssh_username" => "vagrant"
    }
  end

  config.ssh.shell = "bash -l"
  config.ssh.keep_alive = true
  config.ssh.forward_agent = false
  config.ssh.forward_x11 = false
  config.vagrant.host = :detect
end
