#!/bin/sh

WP_PATH=/var/www/wordpress

if [ ! -f "$WP_PATH/index.php" ]; then
    echo 'Installing WordPress'
    curl -o wordpress.tar.gz -SL https://wordpress.org/wordpress-6.9.tar.gz
    tar -xzf wordpress.tar.gz -C /var/www/
    mv /var/www/wordpress/wordpress/* /var/www/wordpress/
    rm -rf /var/www/wordpress/wordpress wordpress.tar.gz
    chown -R nobody:nogroup "$WP_PATH"
fi

if [ ! -f "$WP_PATH/wp-config.php" ]; then
    echo "Generating wp-config.php"

    cp "$WP_PATH/wp-config-sample.php" "$WP_PATH/wp-config.php"

    sed -i "s/database_name_here/${WORDPRESS_DB_NAME}/" "$WP_PATH/wp-config.php"
    sed -i "s/username_here/${WORDPRESS_DB_USER}/" "$WP_PATH/wp-config.php"
    sed -i "s/password_here/$(cat ${WORDPRESS_DB_PASSWORD_FILE})/" "$WP_PATH/wp-config.php"
    sed -i "s/localhost/${WORDPRESS_DB_HOST}/" "$WP_PATH/wp-config.php"
    sed -i "s/wp_/${WORDPRESS_TABLE_PREFIX}/" "$WP_PATH/wp-config.php"

    chown nobody:nogroup "$WP_PATH/wp-config.php"
fi

# PHP-FPM listens on all interfaces
sed -i 's|listen = .*|listen = 0.0.0.0:9000|' /etc/php84/php-fpm.d/www.conf

exec "$@"
