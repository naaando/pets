# syntax=docker/dockerfile:1

# ─── Stage 1: Install Composer dependencies ───────────────────────────────────
FROM composer:2 AS composer-deps
WORKDIR /build
COPY pets-api/composer.json pets-api/composer.lock ./
ARG APP_VERSION=dev
RUN --mount=type=cache,target=/root/.composer/cache \
    composer install --no-dev --no-scripts --no-autoloader --prefer-dist --ignore-platform-reqs
COPY pets-api/ .
RUN mkdir -p bootstrap/cache storage/framework/views storage/framework/cache/data storage/logs
RUN --mount=type=cache,target=/root/.composer/cache \
    composer install --no-dev --optimize-autoloader --ignore-platform-reqs

# ─── Stage 2: Build Vite assets ───────────────────────────────────────────────
FROM node:20-alpine AS node-assets
WORKDIR /build
COPY pets-api/package*.json ./
RUN --mount=type=cache,target=/root/.npm npm ci
COPY pets-api/ .
RUN npm run build

# ─── Stage 3: Production image ────────────────────────────────────────────────
FROM php:8.4-fpm-alpine

COPY --from=mlocati/php-extension-installer /usr/bin/install-php-extensions /usr/local/bin/

RUN --mount=type=cache,target=/etc/apk/cache \
    apk add --update-cache nginx supervisor gettext \
        icu-dev icu-libs libzip-dev libpng-dev libjpeg-turbo-dev libwebp-dev

ENV IPE_GD_WITHOUTAVIF=1
RUN --mount=type=cache,target=/tmp/ipe-cache \
    install-php-extensions pdo_pgsql gd zip intl bcmath exif pcntl opcache

RUN mv "$PHP_INI_DIR/php.ini-production" "$PHP_INI_DIR/php.ini"
COPY pets-api/docker/production/opcache.ini $PHP_INI_DIR/conf.d/opcache.ini

ARG APP_VERSION=dev
ENV APP_VERSION=${APP_VERSION}

WORKDIR /app
COPY --from=composer-deps /build .
COPY --from=node-assets /build/public/build ./public/build

RUN mkdir -p \
    storage/logs \
    storage/framework/cache/data \
    storage/framework/sessions \
    storage/framework/views \
    bootstrap/cache \
 && chown -R nobody:nobody storage bootstrap/cache \
 && chmod -R 775 storage bootstrap/cache

COPY pets-api/docker/production/ /docker/
RUN chmod +x /docker/start.sh

EXPOSE 8080

HEALTHCHECK --interval=30s --timeout=5s --start-period=60s --retries=3 \
    CMD wget -qO- http://127.0.0.1:${PORT:-8080}/up || exit 1

CMD ["/docker/start.sh"]
