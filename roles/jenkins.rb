name "jenkins-vm"
description "A testing vm with jenkins"
run_list(
    "recipe[nginx]",
    "recipe[php5-fpm::install]",    
    "recipe[composer::install]",
    "recipe[elasticsearch]",
    "recipe[jenkins::java]",
    "recipe[jenkins::master]",
    "recipe[readline]",
    "recipe[git]",
    "recipe[myjenkins]"
  )
