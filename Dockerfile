FROM php:8.4-fpm-alpine

# Variables ARG para UID y GID
ARG PUID=1000
ARG PGID=1000

# Instalar dependencias del sistema y extensiones necesarias de PHP
RUN apk add --no-cache \
  bash \
  nano \
  linux-headers \
  libpng-dev \
  zlib-dev \
  freetype-dev \
  libjpeg-turbo-dev \
  libzip-dev \
  zip \
  unzip \
  curl \
  $PHPIZE_DEPS \
  && docker-php-ext-configure gd --with-freetype --with-jpeg \
  && docker-php-ext-install -j$(nproc) pdo pdo_mysql gd zip \
  && pecl install xdebug \
  && docker-php-ext-enable xdebug \
  && apk del $PHPIZE_DEPS

# Copiar php.ini de desarrollo como base
RUN cp "$PHP_INI_DIR/php.ini-development" "$PHP_INI_DIR/php.ini"

# Instalar Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Crear usuario sin privilegios
RUN addgroup -g ${PGID} appuser \
  && adduser -u ${PUID} -G appuser -s /bin/bash -D appuser

# Crear carpetas necesarias para Laravel y asignar permisos
RUN mkdir -p /var/www/html/storage /var/www/html/bootstrap/cache \
  && chown -R appuser:appuser /var/www/html \
  && chmod -R 775 /var/www/html/storage /var/www/html/bootstrap/cache

USER appuser
WORKDIR /var/www/html