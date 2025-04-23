#! /usr/bin/env bash

wp core download --allow-root --force

wp config create  --allow-root --path=$WP_ROUTE --dbname=$DB_NAME --dbuser=$DB_USER --dbpass=$DB_PASS --dbhost=$DB_HOST --dbprefix=wp_


if ! wp core is-installed --allow-root --path=$WP_ROUTE; then

	wp core install --allow-root --url=mdanish.42.fr --title=inception --admin_user=$WP_ADMIN_USER --admin_email=$WP_ADMIN_EMAIL --admin_password=$WP_ADMIN_PASS
	wp user create $WP_USER $WP_EMAIL --allow-root --role=author --user_pass=$WP_PASS

fi

sed -i 's|^listen = .*|listen = 0.0.0.0:9000|' /etc/php/7.4/fpm/pool.d/www.conf

if [ ! -d /run/php ]; then
	mkdir -p /run/php
fi

php-fpm7.4 -F
