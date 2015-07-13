name "testing-vm"
description "A testing vm with LEMP"
run_list(
    "recipe[build-essential]",
    "recipe[apt]",
    "recipe[nginx]",
    "recipe[nodejs]",
    "recipe[mysql::server]",
    "recipe[php5-fpm::install]",
    "recipe[php::module_mysql]",
    "recipe[php::module_curl]",
    "recipe[php::module_gd]",
    "recipe[composer]",
    "recipe[git]",
    "recipe[java]",
    "recipe[elasticsearch]",
    "recipe[base]",
  )
