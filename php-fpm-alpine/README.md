# php-fpm-alpine

php-fpm alpine with gd an apcu that runs as user 82 (alpine php default).

Php dir is `/var/www/html`
## configuration
php.ini customization files can be mounted in /etc/php7-kube-conf.d/*.ini
fpm.conf customization files cna be mounted in /etc/php7-fpm-kube.d 
A script runs at startup and copy contents of theese dirs to configures ones.

Configuration can be overriden by mounting files with '10-' prepending name in /etc/php7-kube-conf.d and /etc/php7-fpm-kube.d
  