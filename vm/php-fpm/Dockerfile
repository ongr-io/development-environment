FROM debian:wheezy
MAINTAINER Gintaras Danilevičius
ENV DEBIAN_FRONTEND noninteractive
ENV CONF_DIR_PHP5_FPM /etc/php5/fpm
RUN apt-get update && apt-get install -y --no-install-recommends \
        php5-curl \
        php5-cli \
        php5-fpm \
        php5-gd \
        php5-intl \
        php5-imagick \
        php5-ldap \
        php5-mcrypt \
        php5-mhash \
        php5-mysql \
        php5-pgsql \
        php5-sqlite
COPY ./php.ini /etc/php5/fpm/php.ini
COPY ./php-fpm.conf /etc/php5/fpm/php-fpm.conf
COPY ./www.conf /etc/php5/fpm/pool.d/www.conf
RUN chown -R www-data:www-data /var/www
RUN apt-get -y autoremove
RUN apt-get clean
RUN rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
EXPOSE 9000
CMD ["php5-fpm"]
