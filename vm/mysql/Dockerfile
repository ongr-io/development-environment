FROM mysql:latest
MAINTAINER Gintaras Danilevičius
RUN mysql_install_db && chown -R mysql:mysql /var/lib/mysql && (/usr/bin/mysqld_safe &) && sleep 5 && mysql -uroot -e "GRANT ALL PRIVILEGES ON *.* TO root@'%' WITH GRANT OPTION;" && mysqladmin -uroot shutdown
RUN mysqld_safe --init-file=./mysql-init &
RUN mysqld_safe