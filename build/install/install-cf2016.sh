#!/bin/sh
#
# Script based on https://forums.adobe.com/message/4727551

cd /tmp

# get the coldfusion installer
if [ ! -f "ColdFusion_2016_WWEJ_linux64.bin" ]
then
    wget https://s3-eu-west-1.amazonaws.com/accent-docker/ColdFusion_2016_WWEJ_linux64.bin
fi

chmod 755 ColdFusion_2016_WWEJ_linux64.bin

# add user to run coldfusion
useradd -c "user for coldfusion" -M -G www-data coldfusion

# install
/tmp/ColdFusion_2016_WWEJ_linux64.bin -f installer.profile

# disable admin security
chmod 755 /tmp/neo-security-config.sh
/tmp/neo-security-config.sh /opt/coldfusion2016/cfusion false

# start up the CF server instance and wait for a moment
/opt/coldfusion2016/cfusion/bin/coldfusion start; sleep 15

# simulate a browser request on the admin UI to complete installation
wget --delete-after http://localhost:8500/CFIDE/administrator/index.cfm?configServer=true

# set the default admin password
chmod 755 set-admin-password.sh
./set-admin-password.sh

# stop the CF server instance
/opt/coldfusion2016/cfusion/bin/coldfusion stop

# re-enable admin security
chmod 755 /tmp/neo-security-config.sh
/tmp/neo-security-config.sh /opt/coldfusion2016/cfusion true

# configure apache2 to run in front of Tomcat
/opt/coldfusion2016/cfusion/runtime/bin/wsconfig -ws Apache -dir /etc/apache2 -bin /usr/sbin/apache2ctl -script /usr/sbin/apache2ctl

# start the CF server instance
/opt/coldfusion2016/cfusion/bin/coldfusion start

# install mysql 5 driver
chmod 755 install-mysql-driver.sh
./install-mysql-driver.sh

if [ -f "ColdFusion_2016_WWEJ_linux64.bin" ]
then
	rm ColdFusion_2016_WWEJ_linux64.bin
fi
