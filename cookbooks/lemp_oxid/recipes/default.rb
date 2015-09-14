#install packages

%w{ vim screen mc curl make g++ php5-common php5-gd php5-mysql php5-json php5-cli php5-curl libxml2 libmysqlclient-dev ruby-dev}.each do |a_package|
  package a_package
end

#configure nginx vhost

file '/etc/nginx/sites-available/default' do
	action :delete
	notifies :restart, "service[nginx]", :delayed
end

cookbook_file '/etc/nginx/sites-available/oxid.dev' do
  source "oxid.dev"
  owner 'root'
  group 'root'
  mode '0644'
  action :create
end

nginx_site 'oxid.dev'

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

#mysql

mysql_service 'default' do
  version '5.5' 
  initial_root_password 'root'
  action [:create, :start]
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
    file.insert_line_if_no_match("/umask 0002/","umask 0002")
    file.write_file
  end
end

ruby_block "insert php umask" do
  block do
    file = Chef::Util::FileEdit.new("/etc/init/php5-fpm.conf")
    file.insert_line_if_no_match("/umask 0002/","umask 0002")
    file.write_file
  end
end

service "php5-fpm" do
	restart_command "service php5-fpm restart"
end