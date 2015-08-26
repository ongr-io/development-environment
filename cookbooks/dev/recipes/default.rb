#configure nginx

template "/etc/nginx/sites-available/ongr.dev" do
  source "dev.erb"
  owner 'root'
  group 'root'
  mode '0644'
  variables ({
    :server_name => node[:vhost][:server_name],
    :docroot => node[:vhost][:docroot]
  })
end

nginx_site 'ongr.dev'

cookbook_file '/etc/nginx/sites-available/default' do
  source "default"
  owner 'root'
  group 'root'
  mode '0644'
  action :create
end

nginx_site 'default'

template "/etc/nginx/fastcgi_params" do
  source "fastcgi_params.erb"
  owner 'root'
  group 'root'
  mode '0644'
  variables ({
    :path_translated => node[:fastcgi_params][:path_translated],
    :script_filename => node[:fastcgi_params][:script_filename],
    :script_name => node[:fastcgi_params][:script_name],
    :request_uri => node[:fastcgi_params][:request_uri],
    :document_uri => node[:fastcgi_params][:document_uri],
    :document_root => node[:fastcgi_params][:document_root],
    :server_protocol => node[:fastcgi_params][:server_protocol]
  })
end

#configure php5-fpm

directory '/var/log/php-fpm' do
  owner 'root'
  group 'root'
  mode '0755'
  action :create
end

user "web" do
  comment 'User to run fpm pool'
  shell '/sbin/nologin'
end

php5_fpm_pool 'www' do
  pool_user 'web'
  pool_group 'web'
  use_sockets true
  listen_socket '/var/run/php5-fpm.sock'
  listen_owner 'www-data'
  listen_group 'www-data'
  listen_mode '0660'
  access_log '/var/log/php-fpm/access.log'
  slow_log '/var/log/php-fpm/slow.log'
  overwrite true
  action :create
  notifies :restart, "service[php5-fpm]", :delayed
end

template "/etc/php5/fpm/php.ini" do
  source "php.ini.erb"
  owner 'root'
  group 'root'
  mode '0644'
  variables ({
    :enable => node[:opcache][:enable],
    :memory_consumption => node[:opcache][:memory_consumption],
    :interned_strings_buffer => node[:opcache][:interned_strings_buffer],
    :max_accelerated_files => node[:opcache][:max_accelerated_files],
    :validate_timestamps => node[:opcache][:validate_timestamps],
    :revalidate_freq => node[:opcache][:revalidate_freq],
    :fast_shutdown => node[:opcache][:fast_shutdown]
      })
end

file "/usr/share/nginx/opreset.php" do
  content '<?php opcache_reset(); ?>'
  mode '0644'
  owner 'root'
  group 'root'
end

#elasticsearch

template '/usr/local/elasticsearch/config/elasticsearch.yml' do
  source "elasticsearch.yml.erb"
  owner 'elasticsearch'
  group 'elasticsearch'
  mode '0664'
  variables ({
    :cluster_name => node[:elasticsearch][:cluster_name],
    :node_name => node[:elasticsearch][:node_name],
    :shards => node[:elasticsearch][:shards],
    :replicas => node[:elasticsearch][:replicas]
  })
end

#mysql
mysql_service 'default' do
  version '5.5'
  initial_root_password 'root'
  action [:create, :start]
end

bash 'create ongr database' do
  code <<-EOF
    mysql -h #{node[:mysql_host]} -u#{node[:mysql_username]} -p#{node[:mysql_password]} -e "CREATE DATABASE IF NOT EXISTS #{node[:mysql_database]} "
  EOF
end

#dev user
user "dev" do
  supports :manage_home => true
  comment 'Developer user'
  home '/home/dev'
  shell '/bin/bash'
end

cookbook_file '/home/dev/.ssh/id_rsa' do
  source "id_rsa"
  owner 'dev'
  group 'dev'
  mode '0600'
  action :create
end

ssh_authorize_key 'dev' do
  key 'AAAAB3NzaC1yc2EAAAADAQABAAABAQCjYSAjen018JnUF07xcT9QizLWxDcNYbr26yPTkvkE6Ztph1u+ChrfgRP/cryGedNmhy/q0VMelIPMuaz4hBnuBnff8YetCOXHeDtTKELMSE5RKdd5ry3ShSBSH7BPLMhCj7TPm9rA/YgbQLVyRyuc04Z9fNh1Uu8S1B6d2CWOTjrHVGMXnNvQFTJF1UFkf34rSv4jfUOT490B/yzyfvQ5mttbAuHYuH6CXALCCZb2e9va1fOV6QofFVn6wngDZpmDTsmbTNQ7ZrLZL0v65Zppu+z/Tc696wJrxk5cPTbAQNut+NF6Ks9OkQlIsvtwDvfK8ZirHkp6Xkg+qDq2jvSj'
  user 'dev'
end

group 'dev' do
  action :modify
  members "web"
  append true
end

#umasks
ruby_block "insert dev umask" do
  block do
    file = Chef::Util::FileEdit.new("/home/dev/.bashrc")
    file.insert_line_if_no_match(/umask 0002/,"umask 0002")
    file.write_file
  end
end

ruby_block "insert php umask" do
  block do
    file = Chef::Util::FileEdit.new("/etc/init/php5-fpm.conf")
    file.insert_line_if_no_match(/umask 0002/,"umask 0002")
    file.write_file
  end
end

service "php5-fpm" do
  restart_command "service php5-fpm restart"
end