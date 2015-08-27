
#fix dev ownership

directory '/srv/www/ongr_sandbox/current/' do
  user 'web'
  group 'dev'
  mode '0775'
  recursive true
  action :create
end


git '/srv/www/ongr_sandbox/current' do
  repository 'git@github.com:kazgurs/ongr-sandbox.git'
  user 'dev'
  group 'dev'
  action :sync
end

execute "change ownership" do
  command "chown -R web:dev /srv/www/ongr_sandbox"
  user "root"
  action :run
  not_if "stat -c %U /srv/www/ongr_sandbox |grep web"
end

execute "fix permissions" do
  command "chmod -R g+wx /srv/www/ongr_sandbox/* && chmod -R g+s /srv/www/ongr_sandbox/"
  user "root"
  action :run
end