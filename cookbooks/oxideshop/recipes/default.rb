
git "#{node[:oxideshop][:dir]}" do
  repository "#{node[:oxideshop][:git_repository]}"
  reference "#{node[:oxideshop][:git_revision]}"
  action :sync
end   


directory node[:oxideshop][:dir] do
  owner "web"
  group "dev"
  mode "0755"
  action :create
end

directory "#{node[:oxideshop][:dir]}/log" do
  owner "web"
  group "dev"
  mode "0755"
  action :create
end
    
bash "setup_oxideshop" do
  code <<-EOH
    mysql -h #{node[:oxideshop][:mysql_host]} -u#{node[:oxideshop][:mysql_username]} -p#{node[:oxideshop][:mysql_password]} -e "CREATE DATABASE #{node[:oxideshop][:mysql_database]} "
    mysql -h #{node[:oxideshop][:mysql_host]} -D#{node[:oxideshop][:mysql_database]} -u#{node[:oxideshop][:mysql_username]} -p#{node[:oxideshop][:mysql_password]} <#{node[:oxideshop][:dir]}/source/setup/sql/database.sql
    mysql -h #{node[:oxideshop][:mysql_host]} -D#{node[:oxideshop][:mysql_database]} -u#{node[:oxideshop][:mysql_username]} -p#{node[:oxideshop][:mysql_password]} <#{node[:oxideshop][:dir]}/source/setup/sql/demodata.sql
  EOH
end

template "config.inc.php" do
  path "#{node[:oxideshop][:dir]}/source/config.inc.php"
  source "config.inc.php.erb"
  owner "web"
  group "dev"
  mode "0644"
end

directory "#{node[:oxideshop][:dir]}/tmp" do
  mode 0755
  owner "web"
  group "dev"
  action :create
end

execute "change ownership" do
  command "chown -R web:dev /srv/www/oxideshop_ce"
  user "root"
  action :run
end

execute "fix permissions" do
  command "chmod -R g+wx /srv/www/oxideshop_ce/* && chmod -R g+s /srv/www/oxideshop_ce/"
  user "root"
  action :run
end