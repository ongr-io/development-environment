FROM ubuntu:14.04.1
MAINTAINER Gintaras Danilevičius
RUN apt-get update && apt-get install -y nginx
COPY ./nginx.conf /etc/nginx/nginx.conf
COPY ./includes /etc/nginx/includes
RUN mkdir /var/www
RUN chown -R www-data:www-data /var/www
RUN apt-get -y autoremove
RUN apt-get clean
RUN rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
EXPOSE 80
CMD ["nginx"]