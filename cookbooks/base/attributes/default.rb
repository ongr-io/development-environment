default['base']['access_key'] = "insert your S3 bucket user access key"
default['base']['secret_key'] = "insert your S3 bucket user secret key"

#ongr_database settings

# default[:ongr][:mysql_host]      =  "127.0.0.1"
# default[:ongr][:mysql_username]  =  "root"
# default[:ongr][:mysql_password]  =  "root"
# default[:ongr][:mysql_database]  =  "ongr"

#nginx vhost settings

default['base']['server_name'] = "ongr.dev"
default['base']['docroot'] = "/srv/www/current/web/"