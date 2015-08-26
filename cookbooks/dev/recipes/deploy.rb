
#fix dev ownership


deploy 'ongr_sandbox' do
  repo 'git@github.com:kazgurs/ongr-sandbox.git'
  user 'dev'
  deploy_to '/srv/www/ongr_sandbox/current/'
  action :deploy
end

execute "change ownership" do
  command "chown -R web:dev /srv/www/ongr_sandbox"
  user "root"
  action :run
  not_if "stat -c %U /srv/www/ongr_sandbox |grep web"
end

execute "fix permissions" do
  command "chmod -R g+wx /srv/www/ongr_sandbox/releases/* && chmod -R g+s /srv/www/ongr_sandbox/"
  user "root"
  action :run
end