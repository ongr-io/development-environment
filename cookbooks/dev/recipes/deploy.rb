
#fix dev ownership

directory '/srv/www/ongr_sandbox/current/' do
  user 'web'
  group 'dev'
  mode '0775'
  recursive true
  action :create
end


git '/srv/www/ongr_sandbox/current' do
  repository 'git@gitlab.scale.sc:nfq/ci-dev-project.git'
  user 'dev'
  group 'dev'
  action :sync
end

execute 'composer install --no-interaction' do
  cwd '/srv/www/ongr_sandbox/current'
end

execute 'bundle install' do
  cwd '/srv/www/ongr_sandbox/current'
  not_if 'bundle check'
end

execute 'app/console assetic:dump' do
  cwd '/srv/www/ongr_sandbox/current'
end

execute "change ownership" do
  command "chown -R web:dev /srv/www/ongr_sandbox"
  user "root"
  action :run
end

execute "fix permissions" do
  command "chmod -R g+wx /srv/www/ongr_sandbox/* && chmod -R g+s /srv/www/ongr_sandbox/"
  user "root"
  action :run
end