Vagrant.configure( "2" ) do |config|

  config.vm.box      = "ubuntu/trusty64"
  config.vm.hostname = "vm1.ongr.dev"

  config.vm.provider :virtualbox do |v|
    v.name   = "vm1"
    v.cpus   = 1
    v.memory = 512
  end

  config.vm.provision :docker
  config.vm.provision :shell, path: ".provision/provision"

  config.vm.provision :puppet do |puppet|
    puppet.manifests_path = ".provision/puppet/manifests"
    puppet.options        = ["--verbose"]
  end

end
