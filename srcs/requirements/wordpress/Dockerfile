# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: lprates <lprates@student.42lisboa.com>     +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2023/03/04 06:03:32 by lprates           #+#    #+#              #
#    Updated: 2023/03/04 06:03:32 by lprates          ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

FROM debian:buster

ARG	WORDPRESS_VERSION=5.8.3

RUN apt-get update && apt-get install -y \
	gettext \
	php7.3 \
	php7.3-fpm \
	php7.3-cli \
	wget \
	curl \
	procps \
	php7.3-curl \
	php7.3-mysql \
	php7.3-mbstring \
	php7.3-xml \
	php7.3-gd \
	sendmail \
	mariadb-client \
	gettext-base \
	&& apt-get clean \
	&& rm -rf /var/lib/apt/lists/* \
	&& mkdir /run/php

RUN wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
	--output-document=/usr/local/bin/wp \
  && chmod +x /usr/local/bin/wp

# - create the wordpress directories
# - set the permissions of the template config file to be readable, writeable, and
#   executable by the owner and readable and writeable by others
RUN mkdir -p /run/php /var/www/html/wordpress \
  && chmod -R 755 /var/www/html/

# https://askubuntu.com/questions/873839/what-is-the-www-data-user

# - add the "wordpress_server" group and user
RUN addgroup --system wordpress_server \
  && adduser --system wordpress_server

# - copy the config file to container root as a template file
COPY ./conf/www.conf /www.conf.tmpl

WORKDIR /var/www/html/wordpress

RUN wp core download --allow-root --version=$WORDPRESS_VERSION

COPY tools/docker-entrypoint.sh /usr/local/bin/

RUN chmod +x /usr/local/bin/docker-entrypoint.sh

RUN rm -f /etc/php/7.3/fpm/pool.d/www.conf

ENTRYPOINT [ "docker-entrypoint.sh" ]

CMD [ "/usr/sbin/php-fpm7.3", "-F" ]