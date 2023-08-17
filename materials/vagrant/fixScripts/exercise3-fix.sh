#!/bin/bash
sed -i 's/Require all denied/Require all granted/g' /etc/apache2/sites-available/000-default.conf
chown -R www-data:www-data /var/www/
systemctl restart apache2
