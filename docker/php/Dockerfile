FROM php:7.0-fpm

RUN apt-get update \
    && apt-get install -y libicu-dev \
        zlib1g-dev \
        libfreetype6-dev \
        libjpeg62-turbo-dev \
        libmcrypt-dev \
        libpng12-dev \
    && docker-php-ext-install pdo_mysql \
    && docker-php-ext-install json \
    && docker-php-ext-install intl \
    && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
        && docker-php-ext-install -j$(nproc) gd \
    && docker-php-ext-install zip
