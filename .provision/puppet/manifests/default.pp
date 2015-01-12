node /^vm\d+$/ {
  package { "python-pip":
    ensure => installed
  }

  package { "fig":
    ensure   => latest,
    provider => pip,
    require  => Package["python-pip"]
  }
}

node /^nginx\d+$/ {
  class { "nginx": }

  #nginx::resource::vhost { "vm1.dev":
  #  ensure      => present,
  #  server_name => ["vm1.dev", "www.vm1.dev"],
  #  index_files => ["app_dev.php"],
  #  www_root    => "/srv",
  #  try_files   => ['$uri', '$uri/', '/app_dev.php?$args']
  #}

  #nginx::resource::location { "root":
  #  ensure   => present,
  #  vhost    => "vm1.dev",
  #  location => "/",
  #  fastcgi  => "127.0.0.1:9000"
  #}
}
