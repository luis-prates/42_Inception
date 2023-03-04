#!/bin/bash

# comments out the bind-address config so the interface is not binded to a specific IP address
sed -ie 's/bind-address/#bind-address/g' /etc/mysql/mariadb.conf.d/50-server.cnf

# enables the port configuration
sed -ie 's/#port/port/g' /etc/mysql/mariadb.conf.d/50-server.cnf

# Check if database `mysql` has already been created
if [ ! -d "/var/lib/mysql/mysql" ]; then

    # Initializes the MySQL database tables and creates the necessary files in the
    # specified data directory with the specified MySQL user and based directory.
    echo "Install mariadb for the first time"
    mysql_install_db --user=mysql --basedir=/usr --datadir=/var/lib/mysql

fi

# Checks if database $WORDPRESS_DB_NAME has already been created
if [ ! -d /var/lib/mysql/$WORDPRESS_DB_NAME ]
then
service mysql start

# Performs the mysql secure installation
# https://bertvv.github.io/notes-to-self/2015/11/16/automating-mysql_secure_installation/
mysql --user=root <<EOF
UPDATE mysql.user SET Password=PASSWORD('$MARIADB_ROOT_PASSWORD') WHERE User='root';
UPDATE mysql.user SET plugin='mysql_native_password' WHERE user='root' AND host='localhost';
DELETE FROM mysql.user WHERE User='';
DROP DATABASE IF EXISTS test;
DELETE FROM mysql.db WHERE Db='test' OR Db='test\\_%';
FLUSH PRIVILEGES;
EOF

# Creates the project database if it doesn't exist
# and grants privileges to root and the project user
mysql --user=root --password=$MARIADB_ROOT_PASSWORD <<EOF
CREATE DATABASE IF NOT EXISTS $WORDPRESS_DB_NAME;
GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' IDENTIFIED BY '$MARIADB_ROOT_PASSWORD';
GRANT ALL PRIVILEGES ON $WORDPRESS_DB_NAME.* TO '$MARIADB_USER'@'%' IDENTIFIED BY '$MARIADB_USER_PASSWORD' WITH GRANT OPTION;
FLUSH PRIVILEGES;
EOF

service mysql stop
fi

exec "$@"