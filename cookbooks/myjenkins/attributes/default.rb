##S3 bucket settings
default[:s3][:access_key] = "insert your S3 bucket user access key"
default[:s3][:secret_key] = "insert your S3 bucket user secret key"

##master build settings
default[:master_build][:url] = "git@github.com:kazgurs/ongr-sandbox.git"
default[:master_build][:cred_id] = "cd1266eb-e062-4702-a6c0-6a536f3fbc71"

##php5-fpm
default[:php_fpm][:install_php_modules] = "true"
default[:php_fpm][:php_modules] = ["php5-common","php5-mysql","php5-curl","php5-gd", "php5-gd", "php5-intl"]

##nginx settings

#nginx.conf
default[:nginx][:worker_processes] = "1"
default[:nginx][:worker_connections] = "1024"
default[:nginx][:client_body_buffer_size] = "8k"
default[:nginx][:client_max_body_size] = "5m"


#jenkins vhost
default[:jenkins_vhost][:upstream] = "127.0.0.1:8080 fail_timeout=0;"
default[:jenkins_vhost][:server_name] = "jenkins.dev"
