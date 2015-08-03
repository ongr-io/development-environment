FROM nmcteam/php56

#packages
RUN apt-get update \
		&& apt-get install git ruby bundler openjdk-7-jdk -y

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*