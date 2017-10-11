#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

echo "Initializing Magento2 setup..."

if [ "$M2SETUP_FORCE_EXECUTION" == "true" ] || [ ! -f /src/app/etc/config.php ] || [ ! -f /src/app/etc/env.php ]; then

  $DIR/magento-create-project.sh "/src"

  $DIR/magento-set-permissions.sh "/src"

  if [ "$M2SETUP_USE_SAMPLE_DATA" = true ]; then
    echo "Running magento sampledata:deploy"
    /src/bin/magento sampledata:deploy

    echo "Ignore the above error (bug in Magento), fixing with 'composer update'..."
    composer update

    M2SETUP_USE_SAMPLE_DATA_STRING="--use-sample-data"
  else
    M2SETUP_USE_SAMPLE_DATA_STRING=""
  fi

  echo "Running magento setup:install"
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

  echo "Running magento static-content:deploy, indexer:reindex and setting deploy:mode to $M2MODE"
  /src/bin/magento setup:static-content:deploy
  /src/bin/magento indexer:reindex
  /src/bin/magento deploy:mode:set $M2MODE

  chown -R www-data:www-data /src
  echo "The setup script has completed execution."
fi
