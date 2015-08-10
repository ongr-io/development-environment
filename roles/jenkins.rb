name "dev-vm"
description "A testing vm with LEMP"
run_list(
    "recipe[nginx]",
    "recipe[php5-fpm::install]",    
    "recipe[composer::install]",
    "recipe[elasticsearch]",
    "recipe[jenkins::java]",
    "recipe[jenkins::master]",
    "recipe[readline]",
    "recipe[base::jenkins]"
  )
