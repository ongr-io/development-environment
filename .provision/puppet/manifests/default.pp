package { "python-pip":
  ensure => installed
}

package { "fig":
  ensure   => latest,
  provider => pip,
  require  => Package["python-pip"]
}
