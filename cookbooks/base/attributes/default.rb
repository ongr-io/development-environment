#S3 bucket settings
default['base']['access_key'] = "insert your S3 bucket user access key"
default['base']['secret_key'] = "insert your S3 bucket user secret key"

#ongr_database settings

 default[:ongr][:mysql_host]      =  "127.0.0.1"
 default[:ongr][:mysql_username]  =  "root"
 default[:ongr][:mysql_password]  =  "root"
 default[:ongr][:mysql_database]  =  "ongr"

#nginx vhost settings

default['base']['server_name'] = "ongr.dev"
default['base']['docroot'] = "/srv/www/ongr_sandbox/current/web/"

default['base']['path_translated'] = "$document_root$fastcgi_path_info"
default['base']['script_filename'] = "$$realpath_root$fastcgi_script_name"
default['base']['script_name'] = "$fastcgi_script_name"
default['base']['request_uri'] = "$request_uri"
default['base']['document_uri'] = "$document_uri"
default['base']['document_root'] = "$realpath_root"
default['base']['server_protocol'] = "$server_protocol"