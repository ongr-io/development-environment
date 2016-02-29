[REMOTE]
xdebug.default_enable=1
xdebug.remote_autostart=0
xdebug.remote_connect_back=1
xdebug.remote_enable=1
xdebug.remote_handler=dbgp
xdebug.remote_port={{ php.config.xdebug.remote_port }}
xdebug.remote_host={{ php.config.xdebug.remote_host }}
xdebug.max_nesting_level={{ php.config.xdebug.max_nesting_level }}
[CUSTOM]
display_errors=On
error_reporting=-1
date.timezone={{ php.config.xdebug.timezone }}
