FROM alpine:3.22

# https://github.com/TrafeX/docker-wordpress/blob/master/Dockerfile
RUN apk --no-cache add \
  vim \
  php84 \
  php84-fpm \
  php84-mysqli \
  php84-json \
  php84-openssl \
  php84-curl \
  php84-zlib \
  php84-xml \
  php84-phar \
  php84-intl \
  php84-dom \
  php84-xmlreader \
  php84-xmlwriter \
  php84-exif \
  php84-fileinfo \
  php84-sodium \
  php84-gd \
  php84-simplexml \
  php84-ctype \
  php84-mbstring \
  php84-zip \
  php84-opcache \
  php84-iconv \
  php84-pecl-imagick \
  php84-session \
  php84-tokenizer \
  curl

WORKDIR /var/www/wordpress

COPY init-wp-content.sh  /init-wp-content.sh
RUN chmod +x /init-wp-content.sh

ENTRYPOINT [ "/init-wp-content.sh" ]

CMD [ "/usr/sbin/php-fpm84" , "-F" ] 
