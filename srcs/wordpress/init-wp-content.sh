#!/bin/sh

if [ ! -f /var/www/wordpress/index.php ]; then
    echo 'Installing WordPress'
    curl -o wordpress.tar.gz -SL https://wordpress.org/wordpress-6.9.tar.gz
    tar -xzf wordpress.tar.gz -C /var/www/
    rm wordpress.tar.gz
    chown -R nobody:nogroup /var/www/wordpress
fi

# PHP-FPM listens on all interfaces
sed -i 's|listen = .*|listen = 0.0.0.0:9000|' /etc/php84/php-fpm.d/www.conf

exec "$@"
