#!/bin/bash
cd "$(dirname "$0")"

/usr/local/php5/bin/pecl -C /usr/local/php5/etc/pear.conf install redis-2.2.8

# Add config files
echo "extension=redis.so" | sudo tee -a /usr/local/php5/etc/conf.d/modules.ini
