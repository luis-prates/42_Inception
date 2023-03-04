#!/bin/bash

if [ $1 ]; then
	DOMAIN_USER=$1

	# deletes any line that has 42.fr in it
	sudo sed -i '/42.fr/d' /etc/hosts

	# gets the container attributed ip address
	NGINX_IP=`docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' nginx`

	# sets the different domains to the hosts file to allow access
	sudo echo "$NGINX_IP $DOMAIN_USER.42.fr" | sudo tee -a /etc/hosts 1>/dev/null
else
	echo "This script should only be ran from the Makefile with the proper Domain Name set!"
fi