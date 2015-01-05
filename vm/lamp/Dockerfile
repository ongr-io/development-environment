FROM eboraas/apache-php
RUN apt-get update && \
  apt-get -y install php5-mysql php5-xdebug mysql-client
WORKDIR /var/www/
RUN chown -R www-data:www-data /var/www
RUN echo 'localhost mysql' >> /etc/hosts