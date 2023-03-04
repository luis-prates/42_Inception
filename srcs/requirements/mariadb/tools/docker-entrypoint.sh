#!/bin/bash

sed -ie 's/bind-address/#bind-address/g' /etc/mysql/mariadb.conf.d/50-server.cnf
sed -ie 's/#port/port/g' /etc/mysql/mariadb.conf.d/50-server.cnf

# Check if database `mysql` has already been created
if [ ! -d "/var/lib/mysql/mysql" ]; then

    # Initialize the MySQL database tables and create the necessary files in the
    # specified data directory with the specified MySQL user and based directory.
    echo "Install mariadb for the first time"
    mysql_install_db --user=mysql --basedir=/usr --datadir=/var/lib/mysql

fi

if [ ! -d /var/lib/mysql/$WORDPRESS_DB_NAME ]
then
service mysql start

# https://bertvv.github.io/notes-to-self/2015/11/16/automating-mysql_secure_installation/
mysql --user=root <<EOF
UPDATE mysql.user SET Password=PASSWORD('$MARIADB_ROOT_PASSWORD') WHERE User='root';
UPDATE mysql.user SET plugin='mysql_native_password' WHERE user='root' AND host='localhost';
DELETE FROM mysql.user WHERE User='';
DROP DATABASE IF EXISTS test;
DELETE FROM mysql.db WHERE Db='test' OR Db='test\\_%';
FLUSH PRIVILEGES;
EOF

mysql --user=root --password=$MARIADB_ROOT_PASSWORD <<EOF
CREATE DATABASE IF NOT EXISTS $WORDPRESS_DB_NAME;
GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' IDENTIFIED BY '$MARIADB_ROOT_PASSWORD';
GRANT ALL PRIVILEGES ON $WORDPRESS_DB_NAME.* TO '$MARIADB_USER'@'%' IDENTIFIED BY '$MARIADB_USER_PASSWORD' WITH GRANT OPTION;
FLUSH PRIVILEGES;
EOF

service mysql stop
fi

exec "$@"