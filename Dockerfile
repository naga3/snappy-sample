FROM debian:10.3-slim

ADD . /app
WORKDIR /app

RUN apt-get update \
    && apt-get install -y php php-cli php-dom php-zip php-sqlite3 php-mbstring \
    && apt-get install -y curl libxrender1 libfontconfig1 libxext6 fonts-ipafont

COPY php-override.ini /etc/php/7.3/cli/conf.d

# Composer
RUN curl -sS https://getcomposer.org/installer -o composer-setup.php \
    && php composer-setup.php --install-dir=/usr/local/bin --filename=composer \
    && rm composer-setup.php

# Node.js
RUN curl -sL https://deb.nodesource.com/setup_12.x | bash - \
    && apt-get install -y nodejs \
    && npm install -g npm \
    && npm install -g yarn

RUN composer install && yarn install && yarn dev && php artisan migrate

CMD php artisan serve --host=0.0.0.0
