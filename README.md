apache-php7-cf2016
==================

Usage
------

Build image:
```
$ docker build -t thisismyengine/docker-apache-php7-cf2016 git://github.com/thisismyengine/docker-apache-php7-cf2016.git
```

Run newly created image in a container:
```bash
$ docker run -dit -p 80:80 -p 8500:8500 \
    -v /Volumes/Data/Server:/var/www \
    --name apache-php7-cf2016 --restart always \
    thisismyengine/docker-apache-php7-cf2016
```

* `-v [local path]:/var/www` maps the container's webroot to a local path
* `-p [local port]:80` maps a local port to the container's HTTP port 80
* `-p [local port]:8500` maps a local port to the ColdFusions built in webserver port 8500

Installed packages
-------------------
* Ubuntu Server 16.04, based on ubuntu docker image
* ColdFusion 2016
	* MySQL Connector 5.1.34
* apache2
* php7.0
* php7.0-cli
* libapache2-mod-php7.0
* php7.0-gd
* php7.0-json
* php7.0-ldap
* php7.0-mbstring
* php7.0-mysql
* php7.0-pgsql
* php7.0-sqlite3
* php7.0-curl
* php7.0-xml
* php7.0-xsl
* php7.0-zip
* php7.0-soap

Default Configurations
----------------------

* Apache: .htaccess-Enabled in webroot (mod_rewrite with AllowOverride all)
* php.ini:
  * display_errors = On
  * error_reporting = E_ALL (default, overridable per env variable)
