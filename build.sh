#!/bin/bash
cd "$(dirname "$0")"

# Dependencies
sudo apt-get update
sudo apt-get install -y \
    build-essential \
    pkg-config \
    git-core \
    autoconf \
    libxml2-dev \
    libbz2-dev \
    libmcrypt-dev \
    libicu-dev \
    libssl-dev \
    libcurl4-openssl-dev \
    libltdl-dev \
    libjpeg-dev \
    libpng-dev \
    libpspell-dev \
    libreadline-dev \
    re2c


# https://bugs.php.net/bug.php?id=69055
sudo apt-get purge bison
sudo apt-get install -y build-essential m4

wget http://ftp.gnu.org/gnu/bison/bison-2.7.tar.gz
tar -xvf bison-2.7.tar.gz
rm bison-2.7.tar.gz
cd bison-2.7

./configure --prefix=/usr/local/bison --with-libiconv-prefix=/usr/local/libiconv/

make
sudo make install

sudo ln -sf /usr/local/bison/bin/bison /usr/bin/bison
sudo ln -sf /usr/local/bison/bin/yacc /usr/bin/yacc

cd ..


sudo mkdir /usr/local/php5

git clone https://github.com/php/php-src.git
cd php-src
git checkout PHP-5.6.26
git pull
./buildconf --force

CONFIGURE_STRING="--prefix=/usr/local/php5 \
                  --with-config-file-scan-dir=/usr/local/php5/etc/conf.d \
                  --with-pear \
                  --enable-bcmath \
                  --with-bz2 \
                  --enable-calendar \
                  --enable-intl \
                  --enable-exif \
                  --enable-dba \
                  --enable-ftp \
                  --with-gettext \
                  --with-gd \
                  --with-jpeg-dir \
                  --enable-mbstring \
                  --with-mcrypt \
                  --with-mhash \
                  --enable-mysqlnd \
                  --with-mysql=mysqlnd \
                  --with-mysql-sock=/var/run/mysqld/mysqld.sock \
                  --with-mysqli=mysqlnd \
                  --with-pdo-mysql=mysqlnd \
                  --with-openssl \
                  --enable-pcntl \
                  --with-pspell \
                  --enable-shmop \
                  --enable-soap \
                  --enable-sockets \
                  --enable-sysvmsg \
                  --enable-sysvsem \
                  --enable-sysvshm \
                  --enable-wddx \
                  --with-zlib \
                  --enable-zip \
                  --with-readline \
                  --with-curl \
                  --enable-fpm \
                  --with-fpm-user=www-data \
                  --with-fpm-group=www-data"

./configure $CONFIGURE_STRING

make
sudo make install
