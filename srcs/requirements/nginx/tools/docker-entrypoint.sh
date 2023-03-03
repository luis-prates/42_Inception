#!/bin/bash

# substitutes env vars and creates a file with the result
#
cat /etc/nginx/wordpress.conf.template | envsubst '$DOMAIN_NAME' > /etc/nginx/sites-available/wordpress.conf
#sed -ie s/'$DOMAIN_NAME'/$DOMAIN_NAME/g /etc/nginx/sites-available/wordpress.conf

# nginx.conf has the global defined configs setup
# shouldn't be changed unless necessary
# for changes it's better to define on their own specific websites

# sites-available has all the websites that can be used by nginx
unlink /etc/nginx/sites-enabled/default

# sites-enable has symlinks to the websites in sites-available that
# the user wants to enable
ln -s /etc/nginx/sites-available/wordpress.conf /etc/nginx/sites-enabled/

# setting up openssl for tls security
# https://codingwithmanny.medium.com/configure-self-signed-ssl-for-nginx-docker-from-a-scratch-7c2bcd5478c6
openssl req -x509 -nodes -days 365 -subj "/C=PT/ST=Santarem/L=Abrantes/O=42lisboa/CN=lprates.42.fr" \
	-newkey rsa:2048 -keyout /etc/ssl/nginx-selfsigned.key -out /etc/ssl/nginx-selfsigned.crt;

exec "$@"