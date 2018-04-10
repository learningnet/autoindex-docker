FROM php:5.6-apache
MAINTAINER James Carlos <james@learning.net>

# prevent debian errors
ENV DEBIAN_FRONTEND noninteractive
ENV TERM xterm

# Install supplimentary programs
RUN apt-get update && apt-get install -y -qq --no-install-recommends \
    curl \
    git \
    wget \
    build-essential \
    unzip \
    rsync \
    python-software-properties \
    software-properties-common \
    libmcrypt-dev \
    libxml2-dev && \
    docker-php-ext-install \
    pdo \
    pdo_mysql \
    mysqli \
    iconv \
    mcrypt \
    bcmath \
    mbstring && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /etc/apache2/sites-enabled/* /etc/apache2/sites-available/* && \
    a2enmod deflate rewrite ssl proxy_http

COPY php.ini /usr/local/etc/php/

RUN cd /var/www/html && \
    wget https://github.com/justinhagstrom/AutoIndex/archive/master.zip && \
    unzip master.zip && \
    mv AutoIndex-master/* . && \
    rm -rf AutoIndex-master && \
    rm master.zip

EXPOSE 80 443