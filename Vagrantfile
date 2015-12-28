Vagrant.require_version ">= 1.5"

#install required vagrant plugin(s)
required_plugins = %w(vagrant-hostsupdater vagrant-vbguest vagrant-winnfsd)

plugins_to_install = required_plugins.select { |plugin| not Vagrant.has_plugin? plugin }
if not plugins_to_install.empty?
  puts "Installing plugins: #{plugins_to_install.join(' ')}"
  if system "vagrant plugin install #{plugins_to_install.join(' ')}"
    exec "vagrant #{ARGV.join(' ')}"
  else
    abort "Installation of one or more plugins has failed. Aborting."
  end
end

# Check to determine whether we're on a windows or linux/os-x host
def which(cmd)
    exts = ENV['PATHEXT'] ? ENV['PATHEXT'].split(';') : ['']
    ENV['PATH'].split(File::PATH_SEPARATOR).each do |path|
        exts.each { |ext|
            exe = File.join(path, "#{cmd}#{ext}")
            return exe if File.executable? exe
        }
    end
    return nil
end

hostname = "ongr.dev"

Vagrant.configure("2") do |config|

    config.vm.provider :virtualbox do |v|
        v.name = hostname
	      v.customize ["setextradata", :id, "VBoxInternal2/SharedFoldersEnableSymlinksCreate/v-root", "1"]
        v.customize [
            "modifyvm", :id,
            "--name", "ongr.dev",
            "--memory", 2048,
            "--natdnshostresolver1", "on",
            "--cpus", 2,
        ]
    end

    config.vm.box = "ubuntu/trusty64"

    config.vm.network :private_network, ip: "192.168.33.10"
    config.vm.hostname = hostname
    config.ssh.forward_agent = true
    config.vm.synced_folder "./", "/var/www/", type: "nfs"

    # If ansible is in your path it will provision from your HOST machine
    # If ansible is not found in the path it will be instaled in the VM and provisioned from there
    if which('ansible-playbook')
        config.vm.provision "ansible" do |ansible|
            ansible.playbook = "ansible/vagrant.yml"
            ansible.inventory_path = "ansible/inventories/ongr"
            ansible.limit = 'all'
  #          ansible.verbose = "vvv"
        end
    else
        config.vm.provision :shell, path: "ansible/setup.sh", args: [hostname]
    end
end
