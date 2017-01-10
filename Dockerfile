FROM ubuntu:16.04
MAINTAINER Engine <hello@thisismyengine.com>

EXPOSE 80 8500
VOLUME ["/var/www", "/tmp/config"]

ENV DEBIAN_FRONTEND noninteractive

# update system
RUN apt-get update && \
    apt-get dist-upgrade -y

# install required programs
RUN apt-get install -y \
	expect \
	wget \
	unzip \
	xsltproc

# install apache & php7
RUN apt-get install -y \
	apache2 \
	php7.0 \
	php7.0-cli \
	libapache2-mod-php7.0 \
	php7.0-gd \
	php7.0-json \
	php7.0-ldap \
	php7.0-mbstring \
	php7.0-mysql \
	php7.0-pgsql \
	php7.0-sqlite3 \
	php7.0-curl \
	php7.0-xml \
	php7.0-xsl \
	php7.0-zip \
	php7.0-soap

# add install directory
ADD ./build/install/	/tmp/

# install cf2016
RUN chmod +x /tmp/install-cf2016.sh
RUN /tmp/install-cf2016.sh

# updated default apache config
COPY apache_default /etc/apache2/sites-available/000-default.conf

# enable mod rewrite
RUN a2enmod rewrite
RUN service apache2 restart

ENTRYPOINT service apache2 start && ./opt/coldfusion2016/cfusion/bin/coldfusion start && /bin/bash
