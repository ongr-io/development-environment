include '::ntp'
include git
include composer

#Will be loaded all needed configurations in this variable
if $server_config == undef {
  $server_config = hiera('server', false)
}

exec { "apt-update":
  command => "/usr/bin/apt-get update"
}

package {
  [
    'htop'
  ]:
    ensure  => 'installed',
    require => Exec['apt-update'],
}

Exec["apt-update"] -> Package <| |>

Exec { path => [ '/bin/', '/sbin/', '/usr/bin/', '/usr/sbin/' ] }
File { owner => 0, group => 0, mode => 0644 }

group { "mysql":
  ensure => "present",
}

user { "vagrant_user":
    name       => vagrant,
    ensure     => present,
    groups     => ["www-data", "mysql"]
}

file_line { "vagrant_umask":
    ensure  => present,
    line    => "umask 002",
    path    => "/home/vagrant/.bashrc",
    require => User["vagrant_user"]
}

class { "apt": }
apt::source { 'packages.dotdeb.org-php55':
    location          => 'http://packages.dotdeb.org',
    release           => 'wheezy-php55',
    repos             => 'all',
    required_packages => 'debian-keyring debian-archive-keyring',
    key               => '89DF5277',
    key_server        => 'keys.gnupg.net',
    include_src       => true
}

ensure_packages( ['augeas-tools'] )

class { '::mysql::server':
  root_password    => 'root',
  override_options => {
    'mysqld' => {
        'log-bin' => 'mysql-bin',
        'binlog_format' => 'ROW'
    }
  }
}

file { "/var/lib/mysql":
    ensure => "directory",
    owner  => "mysql",
    group  => "mysql",
    mode   => 770,
}

class { 'php':
  version             => 'latest',
  package             => "php5-cli",
  config_file         => "/etc/php5/cli/php.ini",
  service_autorestart => false,
  require             => Class["apt"]
}

php::module {
  [
    'mysql',
    'curl',
    'intl',
    'gd',
    'mcrypt',
    'common',
    'xdebug'
  ]:
}

augeas { "custom":
  context => "/files/etc/php5/mods-available/custom.ini",
  changes => [
    "set PHP/date.timezone Europe/Vilnius",
    "set XDEBUG/xdebug.default_enable 1",
    "set XDEBUG/xdebug.remote_autostart 0",
    "set XDEBUG/xdebug.remote_connect_back 1",
    "set XDEBUG/xdebug.remote_enable 1",
    "set XDEBUG/xdebug.remote_handler dbgp",
    "set XDEBUG/xdebug.remote_port 9000",
    "set XDEBUG/xdebug.remote_host 192.168.32.1"
  ],
  require => Class["php"]
}

file { "/etc/php5/cli/conf.d/custom.ini":
  ensure => link,
  source => '/etc/php5/mods-available/custom.ini',
  require => Augeas["custom"]
}

file { "/usr/local/sbin/switch-es":
  ensure => present,
  mode => 755,
  source => '/vagrant/provision/docker/switch-es'
}

file { '/usr/local/bin/debug':
  ensure => present,
  mode => 755,
  content => "#!/bin/sh\nenv PHP_IDE_CONFIG=\"serverName=fox\" XDEBUG_CONFIG=\"idekey=PHPSTORM\" SYMFONY_DEBUG=\"1\" $@"
}
