FROM debian:bullseye

ARG ADMINER_ROUTE

RUN apt-get update && apt-get upgrade --no-install-recommends -y && \
	apt-get install --no-install-recommends -y wget php-fpm php-mbstring php-mysqli php-pdo php-pdo-mysql && \
	rm -rf /var/lib/apt/lists/* && \
	mkdir -p ${ADMINER_ROUTE} && \
	mkdir -p /run/php && \
	wget --no-check-certificate https://www.adminer.org/latest.php -O ${ADMINER_ROUTE}/index.php && \
	sed -i 's|^listen = .*|listen = 0.0.0.0:9000|' /etc/php/7.4/fpm/pool.d/www.conf

CMD [ "php-fpm7.4", "-F" ]
