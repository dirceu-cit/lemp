#!/bin/bash
echo "Initializing setup..."

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
$DIR/m2setup.sh

/usr/local/sbin/php-fpm