FROM ubuntu:latest
MAINTAINER Gintaras Danilevičius
# Install base packages
ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update && \
apt-get -yq install \
curl \
apache2 \
php5-cli \
php5-xdebug \
graphviz \
python \
libapache2-mod-php5 \
php5-mysql \
php5-gd \
php5-curl \
php-pear \
php-apc && \
rm -rf /var/lib/apt/lists/*
RUN sed -i "s/variables_order.*/variables_order = \"EGPCS\"/g" /etc/php5/apache2/php.ini
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer
# Add image configuration and scripts
ADD run.sh /run.sh
RUN chmod 755 /*.sh
EXPOSE 80
WORKDIR /var/www
ENV DEBIAN_FRONTEND noninteractive
ADD ./conf/apache/000-default /etc/apache2/sites-available/000-default.conf
RUN a2enmod rewrite
ENV PHP_UPLOAD_MAX_FILESIZE 10M
ENV PHP_POST_MAX_SIZE 10M
VOLUME ["/var/www"]
EXPOSE 80 3306
CMD ["/run.sh"]