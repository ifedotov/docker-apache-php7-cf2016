cd /tmp

# download MySQL 5 driver
wget -O mysql-connector-java-5.1.40.tar.gz https://www.dropbox.com/s/6txfasgc9xfjd6x/mysql-connector-java-5.1.40.tar.gz?dl=1

# extract jar file
tar -zxvf mysql-connector-java-5.1.40.tar.gz

# copy jar file to cf directory
cd mysql-connector-java-5.1.40
cp mysql-connector-java-5.1.40-bin.jar /opt/coldfusion2016/cfusion/lib

# fix permissions
chown coldfusion /opt/coldfusion2016/cfusion/lib/mysql-connector-java-5.1.40-bin.jar
chmod 0700 /opt/coldfusion2016/cfusion/lib/mysql-connector-java-5.1.40-bin.jar

# restart cf
/opt/coldfusion2016/cfusion/bin/coldfusion restart

if [ -f "mysql-connector-java-5.1.40.tar.gz" ]
then
    rm mysql-connector-java-5.1.40.tar.gz
fi

if [ -d "mysql-connector-java-5.1.40" ]
then
    rm -rf mysql-connector-java-5.1.40
fi
