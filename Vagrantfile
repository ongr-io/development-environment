required_plugins = %w(vagrant-hostsupdater vagrant-docker-compose)

plugins_to_install = required_plugins.select { |plugin| not Vagrant.has_plugin? plugin }
if not plugins_to_install.empty?
  puts "Installing plugins: #{plugins_to_install.join(' ')}"
  if system "vagrant plugin install #{plugins_to_install.join(' ')}"
    exec "vagrant #{ARGV.join(' ')}"
  else
    abort "Installation of one or more plugins has failed. Aborting."
  end
end

Vagrant.configure( "2" ) do |config|
  config.vm.box = "ubuntu/trusty64"
  config.vm.network :private_network, ip: '192.168.80.10'
  config.vm.network :forwarded_port, guest: 80, host: 8080
  config.vm.hostname = "ongr.dev"
  
  config.vm.provider :virtualbox do |v|
    v.customize ["modifyvm", :id, "--memory", 2048]
  end  

  config.vm.provision :shell, inline: "apt-get update"
  config.vm.synced_folder "./", "/var/www/",
    owner: "www-data", group: "www-data"  
  config.vm.provision :docker
  config.vm.provision :docker_compose, yml: "/var/www/docker-compose.yml", rebuild: true, project_name: "ongr", run: "always"
  config.vm.provision :shell, path: "./bootstrap"
end
