#!/bin/sh

# Sets the script to run in debug mode, which displays commands and their
# arguments as they are executed
set -x

#sleep 5

if [ -f /usr/local/bin/.docker-entrypoint-finished ]; then
	rm -f /usr/local/bin/.docker-entrypoint-finished
	echo "Removed .docker-entrypoint-finished"
fi

# Check if config file has already been created by a previous run of this script
if [ -e /etc/php/7.3/fpm/pool.d/www.conf ]; then
	  echo "FastCGI Process Manager config already created"
else

    # Hydrate configuration template with env variables and create config file
    cat /www.conf.tmpl | envsubst > /etc/php/7.3/fpm/pool.d/www.conf
	chmod 755 /etc/php/7.3/fpm/pool.d/www.conf
fi

# Check if wp-config.php file has already been created by a previous run
if [ -e wp-config.php ]; then
	  echo "Wordpress config already created"
else

    # Create the wordpress config file using environment variables
    wp config create --allow-root \
        --dbname=$WORDPRESS_DB_NAME \
        --dbuser=$MARIADB_USER \
        --dbpass=$MARIADB_USER_PASSWORD \
        --dbhost=$MARIADB_HOST

	chmod 600 wp-config.php
fi

# Check if wordpress is already installed
if wp core is-installed --allow-root; then
	  echo "Wordpress core already installed"
else

    # Install wordpress with environment variables
    wp core install --allow-root \
        --url=$WORDPRESS_URL \
        --title=$WORDPRESS_TITLE \
        --admin_user=$WORDPRESS_ADMIN_NAME \
        --admin_email=$WORDPRESS_ADMIN_EMAIL \
        --admin_password=$WORDPRESS_ADMIN_PASSWORD

    # create a new author user
    wp user create --allow-root \
        $WORDPRESS_USER_NAME \
        $WORDPRESS_USER_EMAIL \
        --role=author \
        --user_pass=$WORDPRESS_USER_PASSWORD

    # Set the debugging mode of WordPress to false which will turn off debugging
    # messages, error reporting, and logging. Needed when using CLI from container
    wp config set WORDPRESS_DEBUG false --allow-root
fi

if !(wp user list --field=user_login --allow-root | grep $WORDPRESS_USER_NAME); then

	# create a new author user
    wp user create --allow-root \
        $WORDPRESS_USER_NAME \
        $WORDPRESS_USER_EMAIL \
        --role=author \
        --user_pass=$WORDPRESS_USER_PASSWORD

fi

wp plugin update --all --allow-root

sed -ie 's/listen = \/run\/php\/php7.3-fpm.sock/listen = 0.0.0.0:9000/g' \
/etc/php/7.3/fpm/pool.d/www.conf

chown -R wordpress_server:wordpress_server /var/www/html/*

touch /usr/local/bin/.docker-entrypoint-finished
echo "Created .docker-entrypoint-finished"

exec "$@"