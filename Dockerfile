FROM php:7.3.6-fpm-alpine3.9

RUN apk add bash --no-cache shadow openssl mysql-client
RUN docker-php-ext-install pdo pdo_mysql

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer
ENV DOCKERIZE_VERSION v0.6.1
RUN wget https://github.com/jwilder/dockerize/releases/download/$DOCKERIZE_VERSION/dockerize-linux-amd64-$DOCKERIZE_VERSION.tar.gz \
    && tar -C /usr/local/bin -xzvf dockerize-linux-amd64-$DOCKERIZE_VERSION.tar.gz \
    && rm dockerize-linux-amd64-$DOCKERIZE_VERSION.tar.gz

WORKDIR /var/www
RUN rm -rf /var/www/html && ln -s public html
#COPY . /var/www

#RUN composer install \
#    && php artisan key:generate \
#    && php artisan cache:clear \
#    && php artisan config:clear \
#    && chmod -R 775 storage

EXPOSE 9000
ENTRYPOINT ["php-fpm"]
