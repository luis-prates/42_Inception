-- https://mariadb.com/kb/en/

-- create `LOGIN` user, change password and grant privileges to wordpress database
-- CREATE DATABASE IF NOT EXISTS $MARIADB_DATABASE;

-- CREATE USER IF NOT EXISTS '$MARIADB_USER'@'%' IDENTIFIED BY '$MARIADB_USER_PASSWORD';
GRANT ALL PRIVILEGES ON $MARIADB_DATABASE.* TO '$MARIADB_USER'@'%' IDENTIFIED BY '$MARIADB_USER_PASSWORD' WITH GRANT OPTION;

-- set root password
UPDATE mysql.user SET password=password('$MARIADB_ROOT_PASSWORD') WHERE user='root';

-- reset to take effect
FLUSH PRIVILEGES;