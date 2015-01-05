Vagrant.configure("2") do |config|
    config.vm.box = "ubuntu/trusty64"
    config.vm.network :private_network, ip: "192.168.33.67"
    config.vm.provision :shell, :path => "docker.sh"
    config.vm.synced_folder "./", "/home/vagrant/ongr", type: "nfs"
    config.vm.provider "virtualbox" do |v|
        v.memory = 2048
        v.cpus = 2
    end
end
