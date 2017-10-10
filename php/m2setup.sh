#!/bin/bash
echo "Initializing setup..."

chmod +x /src/bin/magento

/usr/local/bin/composer install -d /src

if [ "$M2SETUP_FORCE_EXECUTION" == "true" ] || [ ! -f /src/app/etc/config.php ] || [ ! -f /src/app/etc/env.php ]; then
  if [ "$M2SETUP_USE_SAMPLE_DATA" = true ]; then
    echo "Installing composer dependencies..."
    /src/bin/magento sampledata:deploy

    echo "Ignore the above error (bug in Magento), fixing with 'composer update'..."
    composer update

    M2SETUP_USE_SAMPLE_DATA_STRING="--use-sample-data"
  else
    M2SETUP_USE_SAMPLE_DATA_STRING=""
  fi

  echo "Running Magento 2 setup script..."
  /src/bin/magento setup:install \
    --db-host=$M2SETUP_DB_HOST \
    --db-name=$M2SETUP_DB_NAME \
    --db-user=$M2SETUP_DB_USER \
    --db-password=$M2SETUP_DB_PASSWORD \
    --base-url=$M2SETUP_BASE_URL \
    --admin-firstname=$M2SETUP_ADMIN_FIRSTNAME \
    --admin-lastname=$M2SETUP_ADMIN_LASTNAME \
    --admin-email=$M2SETUP_ADMIN_EMAIL \
    --admin-user=$M2SETUP_ADMIN_USER \
    --admin-password=$M2SETUP_ADMIN_PASSWORD \
    --backend-frontname=$M2SETUP_ADMIN_URI \
    $M2SETUP_USE_SAMPLE_DATA_STRING

  /src/bin/magento setup:static-content:deploy
  /src/bin/magento indexer:reindex
  /src/bin/magento deploy:mode:set $M2MODE

  echo "Applying ownership & proper permissions..."
  sed -i 's/0770/0775/g' /src/vendor/magento/framework/Filesystem/DriverInterface.php
  sed -i 's/0660/0664/g' /src/vendor/magento/framework/Filesystem/DriverInterface.php
  find pub -type f -exec chmod 664 {} +
  find pub -type d -exec chmod 775 {} +
  find /src/var/generation -type d -exec chmod g+s {} +
  chown -R www-data:www-data /src
  echo "The setup script has completed execution."
fi

/usr/local/sbin/php-fpm