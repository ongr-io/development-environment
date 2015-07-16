include_recipe 'git'

cookbook_file '/etc/nginx/sites-available/ongr.dev' do
  source "ongr.dev"
  owner 'root'
  group 'root'
  mode '0644'
  action :create
end

file '/etc/nginx/sites-enabled/default' do
	action :delete
end

nginx_site 'ongr.dev'