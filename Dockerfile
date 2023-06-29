FROM existenz/webstack:8.2-edge as local

RUN apk --update --no-cache add --repository http://dl-cdn.alpinelinux.org/alpine/edge/community/ \
curl \
gettext-dev \
icu-libs \
libintl \
musl-locales \
php82 \
php82-apcu \
php82-bcmath \
php82-ctype \
php82-curl \
php82-dom \
php82-fileinfo \
php82-iconv \
php82-json \
php82-mbstring \
php82-opcache \
php82-openssl \
php82-pcntl \
php82-pdo \
php82-pdo_pgsql \
php82-phar \
php82-posix \
php82-redis \
php82-session \
php82-tokenizer \
php82-xml \
php82-xmlwriter \
php82-zip \
&& ln /usr/bin/php82 /usr/bin/php

RUN apk add gnu-libiconv=1.15-r3 --update-cache --repository http://dl-cdn.alpinelinux.org/alpine/v3.13/community/ --allow-untrusted

ENV LD_PRELOAD /usr/lib/preloadable_libiconv.so
ENV MUSL_LOCPATH /usr/share/i18n/locales/musl

RUN apk --update --no-cache add --repository http://dl-cdn.alpinelinux.org/alpine/edge/community/ \
bash \
gettext-dev \
patch \
php82-pecl-xdebug \
npm

ARG USERID
ARG GROUPID

RUN apk --update add \
shadow \
sudo \
&& apk del php82-opcache \
&& echo '%wheel ALL=(ALL) NOPASSWD:ALL' > /etc/sudoers.d/wheel \
&& usermod -u ${USERID} php \
&& groupmod -o -g ${GROUPID} php \
&& adduser php wheel

WORKDIR /www
