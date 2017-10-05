FROM php:7.0-fpm

# Install composer (latest)
RUN curl -sS https://getcomposer.org/installer | \
  php -- --install-dir=/usr/local/bin --filename=composer

ADD log.conf /usr/local/etc/php-fpm.d/zz-log.conf