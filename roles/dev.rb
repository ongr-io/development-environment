name "dev-vm"
description "A testing vm with LEMP"
run_list(
    "recipe[nginx]",
    "recipe[php5-fpm::install]",
    "recipe[mysql::server]",
    "recipe[mysql::client]",
    "recipe[nodejs::install_from_package]",    
    "recipe[composer]",
    "recipe[git]",
    "recipe[java]",
    "recipe[elasticsearch]",
    "recipe[base::web]",
    "recipe[deploy::default]",
    "recipe[base::deploy]"
  )
