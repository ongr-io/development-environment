name "dev-vm"
description "A testing vm with LEMP"
run_list(
    "recipe[nginx]",
    "recipe[php5-fpm::install]",
    "recipe[nodejs::install_from_package]",    
    "recipe[composer]",
    "recipe[git]",
    "recipe[java]",
    "recipe[dev]",
    "recipe[dev::deploy]",
  )
