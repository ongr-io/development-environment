Vagrant.configure( "2" ) do |config|

  config.vm.box      = "ubuntu/trusty64"
  config.vm.hostname = "vm1.ongr.dev"

  config.vm.provider :virtualbox do |v|
    v.name   = "vm1"
    v.cpus   = 1
    v.memory = 512
    v.gui    = true
  end

  config.vm.network :private_network, type: :dhcp
  config.vm.synced_folder "./", "/srv/www", type: :nfs

  config.hostsupdater.aliases = ["www.vm1.dev", "vm1.dev"]

  config.vm.provision :docker
  config.vm.provision :shell, path: ".provision/bootstrap"

  config.vm.provision :puppet do |p|
    p.module_path    = ".provision/puppet/modules"
    p.manifests_path = ".provision/puppet/manifests"
    p.options        = ["--verbose"]
  end

end
