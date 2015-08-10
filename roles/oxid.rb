name "dev-vm"
description "A testing vm with LEMP"
run_list(
    "recipe[nginx]",
    "recipe[php5-fpm::install]",    
    "recipe[composer]",
    "recipe[lemp_oxid]",
    "recipe[oxideshop]",
  )
