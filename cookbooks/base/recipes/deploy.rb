include_recipe "deploy"

node[:deploy].each do |application, deploy|

  Chef::Log.info("Deploying application #{application} on #{node[:opsworks][:instance][:hostname]}")


  opsworks_deploy_dir do
    user deploy[:user]
    group deploy[:deploy]
    path deploy[:deploy_to]
  end

  opsworks_deploy do
    app application
    deploy_data deploy
  end

  nginx_web_app application do
    application deploy
  end
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

file "/srv/www/ongr_sandbox/current/wiubewfngreitewichruetiuwe.php" do
  content '<?php opcache_reset(); ?>'
  mode '0644'
  owner 'web'
  group 'dev'
end
