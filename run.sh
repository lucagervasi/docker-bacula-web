#!/bin/sh

IDB_HOST=${DB_HOST:-localhost}
IDB_USER=${DB_USER:-bacula}
IDB_NAME=${DB_NAME:-bacula}
IDB_TYPE=${DB_TYPE:-mysql}
IDB_PORT=${DB_PORT:-3306}
ILABEL=${LABEL:-default}
IPHP_TIMEZONE=${PHP_TIMEZONE:-Europe/Rome}

cat > /var/www/html/application/config/config.php <<EOF
<?php
\$config['language'] = 'en_US';
\$config['show_inactive_clients'] = false;
\$config['hide_empty_pools'] = true;
\$config[0]['label'] = '$ILABEL';
\$config[0]['host'] = '$IDB_HOST';
\$config[0]['login'] = '$IDB_USER';
\$config[0]['password'] = '$DB_PASS';
\$config[0]['db_name'] = '$IDB_NAME';
\$config[0]['db_type'] = '$IDB_TYPE';
\$config[0]['db_port'] = '$IDB_PORT';
?>
EOF

echo "date.timezone = $IPHP_TIMEZONE" >> /etc/php.ini
echo "date.timezone = $IPHP_TIMEZONE" >> /opt/remi/php56/root/etc/php.ini

/usr/sbin/httpd -D FOREGROUND
