
#fix dev ownership

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