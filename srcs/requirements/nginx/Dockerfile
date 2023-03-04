# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: lprates <lprates@student.42lisboa.com>     +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2023/03/04 05:54:06 by lprates           #+#    #+#              #
#    Updated: 2023/03/04 05:54:26 by lprates          ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

FROM debian:buster

RUN apt-get update -y \
	&& apt-get install -y nginx openssl gettext-base procps \
	&& apt-get clean \
	&& rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

COPY ./conf/wordpress.conf /etc/nginx/wordpress.conf.template
COPY ./tools/docker-entrypoint.sh /usr/local/bin/

# To make sure it has execute permission
RUN chmod +x /usr/local/bin/docker-entrypoint.sh

# here the run argument gets appended
ENTRYPOINT [ "docker-entrypoint.sh" ]

# here the run argument gets substituted
CMD ["nginx", "-g", "daemon off;"]