#!/bin/sh

composer install
yarn install && yarn dev
touch database/database.sqlite
php artisan migrate

exec "$@"
