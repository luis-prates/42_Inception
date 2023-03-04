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

FROM debian:buster

RUN apt-get update \
	&& apt-get upgrade -y \
	&& apt-get install -y mariadb-server gettext procps \
	&& apt-get clean \
	&& rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# - copies the entrypoint script
COPY ./tools/docker-entrypoint.sh /usr/local/bin/

# - sets the execution permission to the entrypoint script
RUN chmod +x /usr/local/bin/docker-entrypoint.sh

ENTRYPOINT [ "docker-entrypoint.sh" ]

CMD [ "mysqld_safe" ]