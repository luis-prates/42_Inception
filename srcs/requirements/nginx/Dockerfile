#FROM alpine:3.16.3
FROM debian:buster

#RUN apk update \
#	&& apk upgrade \
#	&& apk add -y --no-cache nginx openssl gettext


RUN apt-get update -y \
	&& apt-get install -y nginx openssl gettext-base procps \
	&& apt-get clean \
	&& rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# VOLUME [ "/etc/nginx/sites-enabled", "/etc/nginx/certs" ]

# WORKDIR /etc/nginx
COPY ./conf/wordpress.conf /etc/nginx/wordpress.conf.template
COPY ./tools/docker-entrypoint.sh /usr/local/bin/

# To make sure it has execute permission
RUN chmod +x /usr/local/bin/docker-entrypoint.sh

# here the run argument gets appended
ENTRYPOINT [ "docker-entrypoint.sh" ]

# here the run argument gets substituted
CMD ["nginx", "-g", "daemon off;"]


# if ENTRYPOINT and CMD is used, CMD will be used as the default value for ENTRYPOINT
# e.g. ENTRYPOINT ["sleep"] \n CMD ["5"]+