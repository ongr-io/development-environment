##nginx settings

#nginx.conf

default[:nginx][:worker_processes] = "1"
default[:nginx][:worker_connections] = "1024"
default[:nginx][:client_body_buffer_size] = "8k"
default[:nginx][:client_max_body_size] = "5m"

#dev vhost
default[:vhost][:server_name] = "ongr.dev"
default[:vhost][:docroot] = "/srv/www/ongr_sandbox/current/web/"

#fastcgi_params
default[:fastcgi_params][:path_translated] = "$document_root$fastcgi_path_info"
default[:fastcgi_params][:script_filename] = "$realpath_root$fastcgi_script_name"
default[:fastcgi_params][:script_name] = "$fastcgi_script_name"
default[:fastcgi_params][:request_uri] = "$request_uri"
default[:fastcgi_params][:document_uri] = "$document_uri"
default[:fastcgi_params][:document_root] = "$realpath_root"
default[:fastcgi_params][:server_protocol] = "$server_protocol"

##php5-fpm

default[:php_fpm][:install_php_modules] = "true"
default[:php_fpm][:php_modules] = ["php5-common","php5-mysql","php5-curl","php5-gd", "php5-gd", "php5-intl"]
default[:php_fpm][:config] = 
'{ 	"config":
	{
		"pid": "/var/run/php5-fpm.pid",
		"error_log": "/var/log/php5-fpm.log",
		"syslog.facility": "daemon",
		"syslog.ident": "php-fpm",
		"log_level": "notice",
		"emergency_restart_threshold": "10",
		"emergency_restart_interval": "60",
		"process_control_timeout": "10",
		"process.max": "0",
		"daemonize": "yes",
		"rlimit_files": "NOT_SET",
		"rlimit_core": "NOT_SET",
		"events.mechanism": "NOT_SET"
	}
}'

#php.ini
default[:opcache][:enable] = "1"
default[:opcache][:memory_consumption] = "256"
default[:opcache][:interned_strings_buffer] = "16"
default[:opcache][:max_accelerated_files] = "9600"
default[:opcache][:validate_timestamps] = "1"
default[:opcache][:revalidate_freq] = "0"
default[:opcache][:fast_shutdown] = "1"


##elasticsearch
default[:elasticsearch][:cluster_name] = "ongr"
default[:elasticsearch][:node_name] = "web"
default[:elasticsearch][:shards] = "2"
default[:elasticsearch][:replicas] = "0"

##ongr_database settings

default[:mysql_host]      =  "127.0.0.1"
default[:mysql_username]  =  "root"
default[:mysql_password]  =  "root"
default[:mysql_database]  =  "ongr"

#java

default[:java][:jdk_version] = "7"

