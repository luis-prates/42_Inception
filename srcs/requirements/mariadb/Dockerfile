# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: lprates <lprates@student.42lisboa.com>     +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2023/02/12 22:52:29 by lprates           #+#    #+#              #
#    Updated: 2023/02/12 22:52:29 by lprates          ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

#FROM alpine:3.16
FROM debian:buster
#FROM alpine:3.7

# - update and upgrade the Alpine Linux package manager packages
# - install the packages for MariaDB database, MariaDB client, gettext, and
#   openrc without caching the package files
RUN apt-get update \
	&& apt-get upgrade -y \
	&& apt-get install -y mariadb-server gettext procps \
	&& apt-get clean \
	&& rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

#RUN	chown -R mysql:mysql /usr/sbin/mysqld

COPY ./tools/docker-entrypoint.sh /usr/local/bin/

ENTRYPOINT [ "docker-entrypoint.sh" ]

CMD [ "mysqld_safe" ]