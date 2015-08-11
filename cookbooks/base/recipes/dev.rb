#configure nginx vhost

template "/etc/nginx/sites-available/ongr.dev" do
  source "dev.erb"
  owner 'root'
  group 'root'
  mode '0644'
  variables ({
    :server_name => node['base']['server_name'],
    :docroot => node['base']['docroot']
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


#configure php5-fpm

apt_package 'php5-common'
apt_package 'php5-curl'
apt_package 'php5-mysql'
apt_package 'php5-cli'
apt_package 'php5-gd'
apt_package 'php5-intl'

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

template "/etc/nginx/fastcgi_params" do
  source "fastcgi_params"
  owner 'root'
  group 'root'
  mode '0644'
end

cookbook_file '/usr/local/elasticsearch/config/elasticsearch.yml' do
  source "elasticsearch.yml"
  owner 'elasticsearch'
  group 'elasticsearch'
  mode '0664'
  action :create
end

#mysql
mysql_service 'default' do
  version '5.5'
  initial_root_password 'root'
  action [:create, :start]
end

bash 'create ongr database' do
  code <<-EOF
    mysql -h #{node[:ongr][:mysql_host]} -u#{node[:ongr][:mysql_username]} -p#{node[:ongr][:mysql_password]} -e "CREATE DATABASE IF NOT EXISTS #{node[:ongr][:mysql_database]} "
  EOF
end

#dev user
user "dev" do
  supports :manage_home => true
  comment 'Developer user'
  home '/home/dev'
  shell '/bin/bash'
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

# #deploy app

# directory '/srv/www/ongr_sandbox/current/' do
#   owner 'web'
#   group 'dev'
#   mode '0755'
#   recursive true
#   action :create
# end

# remote_file '/tmp/ongr-sandbox.tar.gz' do
#   source 'https://ongr-jenkins.s3.amazonaws.com/ongr-sandbox.tar.gz'
# end

# tarball '/tmp/ongr-sandbox.tar.gz' do
#   destination '/srv/www/ongr_sandbox/current' 
#   owner 'web'
#   group 'dev'
#   umask 002            
#   action :extract
# end

# #fix dev ownership

# execute "change ownership" do
#   command "chown -R web:dev /srv/www/ongr_sandbox"
#   user "root"
#   action :run
#   not_if "stat -c %U /srv/www/ongr_sandbox |grep web"
# end

# execute "fix permissions" do
#   command "chmod -R g+wx /srv/www/ongr_sandbox/releases/* && chmod -R g+s /srv/www/ongr_sandbox/"
#   user "root"
#   action :run
# end

# file "/srv/www/ongr_sandbox/current/wiubewfngreitewichruetiuwe.php" do
#   content '<?php opcache_reset(); ?>'
#   mode '0644'
#   owner 'web'
#   group 'dev'
# end