# -*- mode: ruby -*-
# vi: set ft=ruby :
Vagrant.require_version '>= 1.6.5'
# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = '2'
Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  
  # Vagrant plugins config
  config.cache.scope = :box
  config.omnibus.chef_version = :latest
  config.berkshelf.enabled = true
  
  # Box
  config.vm.box = 'ubuntu/trusty64'
  if Vagrant.has_plugin?("vagrant-cachier")
    config.cache.scope = :box
    config.cache.synced_folder_opts = {
      type: :nfs,
      mount_options: ['rw', 'vers=3', 'tcp', 'nolock']
    }
  end
  config.vm.network :private_network, ip: '192.168.80.10'
  config.ssh.forward_agent = true
  config.vm.provider :virtualbox do |v|
    v.memory = 1024
    v.cpus = 1
    v.customize ['modifyvm', :id, '--memory', 1024]
    v.customize ["setextradata", :id, "--VBoxInternal2/SharedFoldersEnableSymlinksCreate/v-root", "1"]
  end

  # Install the latest version of chef
  config.omnibus.chef_version = :latest
  config.vm.hostname = 'ongr.dev'
  
  #provision via chef solo
  config.vm.provision :shell, inline: "apt-get update"
  config.vm.provision 'chef_solo' do |chef|
      chef.node_name = 'ongr.dev'
      chef.roles_path = 'roles'
      chef.add_role('dev')
#      chef.add_role('jenkins') 
#      chef.add_role('oxid') 
end
end
