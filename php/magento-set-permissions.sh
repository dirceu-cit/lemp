#!/bin/bash

targetdir=$1

echo "Set permissions for shared hosting (one user)"
find $targetdir/var $targetdir/vendor $targetdir/pub/static $targetdir/pub/media $targetdir/app/etc -type f -exec chmod u+w {} \;
find $targetdir/var $targetdir/vendor $targetdir/pub/static $targetdir/pub/media $targetdir/app/etc -type d -exec chmod u+w {} \;
chmod u+x $targetdir/bin/magento
