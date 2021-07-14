FROM debian:10.3-slim

ADD . /app
WORKDIR /app

RUN apt-get update \
    && apt-get install -y php php-cli php-dom php-zip php-sqlite3 php-mbstring \
    && apt-get install -y curl libxrender1 libfontconfig1 libxext6 fonts-ipafont

COPY php-override.ini /etc/php/7.3/cli/conf.d

# Composer
RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
RUN php -r "if (hash_file('sha384', 'composer-setup.php') === '756890a4488ce9024fc62c56153228907f1545c228516cbf63f885e036d37e9a59d27d63f46af1d4d07ee0f76181c7d3') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;"
RUN php composer-setup.php --install-dir=/usr/local/bin --filename=composer
RUN php -r "unlink('composer-setup.php');"

# Node.js
RUN curl -sL https://deb.nodesource.com/setup_12.x | bash - \
    && apt-get install -y nodejs \
    && npm install -g npm \
    && npm install -g yarn

RUN composer install && yarn install && yarn dev && php artisan migrate

CMD php artisan serve --host=0.0.0.0
