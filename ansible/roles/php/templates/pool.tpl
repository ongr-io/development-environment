[www]
###### Base Pool Configuration
user = {{ php.config.pool.user }}
group = {{ php.config.pool.group }}
listen = {{ php.config.pool.listen }}
listen.allowed_clients =
listen.owner = {{ php.config.pool.listen_owner }}
listen.group = {{ php.config.pool.listen_group }}
listen.mode = {{ php.config.pool.listen_mode }}
listen.backlog = 65536
###### PM Configuration
pm = {{ php.config.pool.pm }}
pm.max_children = {{ php.config.pool.pm_max_children }}
pm.start_servers = {{ php.config.pool.pm_start_servers }}
pm.min_spare_servers = {{ php.config.pool.pm_min_spare_servers }}
pm.max_spare_servers = {{ php.config.pool.pm_max_spare_servers }}
pm.process_idle_timeout = {{ php.config.pool.pm_process_idle_timeout }}
pm.max_requests = {{ php.config.pool.pm_max_requests }}
pm.status_path = /status
###### Ping Status
ping.path = /ping
ping.response = /pong
###### Logging
access.format = %R - %u %t "%m %r" %s
request_slowlog_timeout = 0
request_terminate_timeout = 0
access.log = /var/log/php-fpm_access.log
slowlog = /var/log/php-fpm_slow.log
###### Misc
chdir = /
chroot =
catch_workers_output = no
security.limit_extensions = .php
rlimit_files =
rlimit_core =
