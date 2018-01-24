FROM php:7.1-fpm
#Cleanup before install or reinstall redis
RUN pecl uninstall redis-3.1.6
RUN rm -f /usr/local/etc/php/conf.d/docker*redis*.ini
#Build and install redis
RUN pecl install redis-3.1.6 \
    && docker-php-ext-enable redis 
COPY docker-php-redis-save-session.ini /usr/local/etc/php/conf.d/docker-php-redis-save-session.ini
