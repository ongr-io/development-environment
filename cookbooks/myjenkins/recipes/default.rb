#configure nginx 

template "/etc/nginx/sites-available/jenkins.dev" do
  source "jenkins.dev.erb"
  owner 'root'
  group 'root'
  mode '0644'
  variables ({
    :upstream => node[:jenkins_vhost][:upstream],
    :server_name => node[:jenkins_vhost][:server_name]
  })
end

nginx_site 'jenkins.dev'

cookbook_file '/etc/nginx/sites-available/default' do
  source "default"
  owner 'root'
  group 'root'
  mode '0644'
  action :create
end

nginx_site 'default'

#jenkins config

directory '/var/lib/jenkins/.ssh' do
  owner 'jenkins'
  group 'jenkins'
  mode '0700'
  action :create
end

cookbook_file '/var/lib/jenkins/.ssh/id_rsa' do
  source "id_rsa"
  owner 'jenkins'
  group 'jenkins'
  mode '0600'
  action :create
end

jenkins_plugin 'git' do
  version '2.3.5'
end

jenkins_plugin 'git-client' do
  version '1.17.1'
end

jenkins_plugin 'rbenv' do
  version '0.0.16'
end

jenkins_plugin 'ruby-runtime' do
  version '0.12'
end

jenkins_plugin 'scm-api' do
  version '0.2'
end

jenkins_plugin 's3' do
  version '0.7'
end

cookbook_file '/var/lib/jenkins/credentials.xml' do
  source "credentials.xml"
  owner 'jenkins'
  group 'jenkins'
  mode '0644'
  action :create
end

template "/var/lib/jenkins/hudson.plugins.s3.S3BucketPublisher.xml" do
  source "hudson.plugins.s3.S3BucketPublisher.xml.erb"
  owner 'jenkins'
  group 'jenkins'
  mode '0644'
  variables ({
    :access_key => node[:s3][:access_key],
    :secret_key => node[:s3][:secret_key]
    })
end

template "build" do
  source "master_build.xml.erb"
  variables ({
    :url => node[:master_build][:url],
    :cred_id => node[:master_build][:cred_id]
    })
end

jenkins_job 'master_build' do
  config "build"
end

service "jenkins" do
  action :restart
end

#mysql

mysql_service 'default' do
  version '5.5' 
  initial_root_password 'root'
  action [:create, :start]
end