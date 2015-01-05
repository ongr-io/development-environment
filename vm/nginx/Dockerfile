FROM nginx:1.7.9
MAINTAINER Gintaras Danilevičius
COPY ./conf.d /etc/nginx/conf.d
COPY ./includes /etc/nginx/includes
RUN mkdir /var/www
RUN chown -R www-data:www-data /var/www