#SETTING CONFIGURATION: pid ###############
pid = {{ php_run }}.pid

#SETTING CONFIGURATION: error_log ###############
error_log = /var/log/{{ php.version }}-fpm.log

#SETTING CONFIGURATION: syslog.facility ###############
syslog.facility = {{ php.config.fpm.syslog_facility }}

#SETTING CONFIGURATION: syslog.ident ###############
syslog.ident = {{ php.config.fpm.syslog_ident }}

#SETTING CONFIGURATION: log_level ###############
log_level = {{ php.config.fpm.log_level }}

#SETTING CONFIGURATION: emergency_restart_threshold ###############
emergency_restart_threshold = {{ php.config.fpm.emergency_restart_threshold }}

#SETTING CONFIGURATION: emergency_restart_interval ###############
emergency_restart_interval = {{ php.config.fpm.emergency_restart_interval }}

#SETTING CONFIGURATION: process_control_timeout ###############
process_control_timeout = {{ php.config.fpm.process_control_timeout }}

#SETTING CONFIGURATION: process.max ###############
process.max = {{ php.config.fpm.process_max }}

#SETTING CONFIGURATION: daemonize ###############
daemonize = {{ php.config.fpm.daemonize }}


#POOL DIRECTORY LOCATION
include={{ php_path }}/fpm/pool.d/*.conf
