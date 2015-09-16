name "oxid-vm"
description "A testing vm with oxideshop"
run_list(
    "recipe[nginx]",
    "recipe[php5-fpm::install]",    
    "recipe[composer]",
    "recipe[lemp_oxid]",
    "recipe[oxideshop]",
  )
