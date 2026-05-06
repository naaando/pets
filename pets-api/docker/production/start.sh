#!/bin/sh
set -e

PORT="${PORT:-8080}"
export PORT

echo "==> Generating nginx config for port $PORT..."
mkdir -p /tmp/nginx-temp/client_body /tmp/nginx-temp/proxy /tmp/nginx-temp/fastcgi /tmp/nginx-temp/uwsgi /tmp/nginx-temp/scgi
envsubst '$PORT' < /docker/nginx.conf.template > /tmp/nginx.conf

echo "==> Ensuring storage directories..."
mkdir -p \
  /app/storage/logs \
  /app/storage/framework/cache/data \
  /app/storage/framework/sessions \
  /app/storage/framework/views \
  /app/bootstrap/cache
chmod -R 775 /app/storage /app/bootstrap/cache

cd /app

echo "==> Caching Laravel config..."
php artisan config:cache

echo "==> Running database migrations..."
php artisan migrate --force

echo "==> Caching routes and views..."
php artisan route:cache
php artisan view:cache

echo "==> Creating storage symlink..."
php artisan storage:link --force || true

echo "==> Starting services on port $PORT..."
exec supervisord -c /docker/supervisord.conf
