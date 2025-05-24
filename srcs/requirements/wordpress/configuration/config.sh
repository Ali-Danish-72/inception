#! /usr/bin/env bash

# Download the main WordPress application and create a configuration file.
wp core download --allow-root --force
wp config create  --allow-root --path=$WP_ROUTE --dbname=$DB_NAME --dbuser=$DB_USER --dbpass=$DB_PASS --dbhost=$DB_HOST --dbprefix=wp_

# Check is the WordPress application is downloaded. If so, install WordPress and create a user.
if ! wp core is-installed --allow-root --path=$WP_ROUTE; then
	wp core install --allow-root --url=mdanish.42.fr --title=inception --admin_user=$WP_ADMIN_USER --admin_email=$WP_ADMIN_EMAIL --admin_password=$WP_ADMIN_PASS
	wp user create $WP_USER $WP_EMAIL --allow-root --role=author --user_pass=$WP_PASS
fi

# Change the configuration file to enable it to listen from all connections on the port 9000.
sed -i 's|^listen = .*|listen = 0.0.0.0:9000|' /etc/php/7.4/fpm/pool.d/www.conf

# Install and configure redis-cache - needed for Bonus.
wp plugin install redis-cache --allow-root --activate
wp config set WP_REDIS_HOST redis --allow-root --type=constant
wp config set WP_REDIS_PORT 6379 --allow-root --type=constant
wp config set WP_CACHE true --allow-root --type=constant
wp redis enable --allow-root

# Check for the /run/php directory. If unavaible, create it.
if [ ! -d /run/php ]; then
	mkdir -p /run/php
fi

# Give the ftp and wordpress users access to the website as necessary to maintian shared access.
groupadd ftpuser
chown -R :ftpuser /var/www/html/wordpress/
chown -R :www-data /var/www/html/wordpress/wp-content/uploads
chmod -R 2775 /var/www/html/wordpress/

# Run WordPress.
php-fpm7.4 -F
