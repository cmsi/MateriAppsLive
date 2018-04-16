#!/bin/sh
DEB_HOME=$HOME/vagrant/data
RSYNC="rsync -avzP --delete -e ssh"

set -x
$RSYNC $DEB_HOME/apt/wheezy/dists $DEB_HOME/apt/wheezy/pool zetta:/var/www/html/Debian/wheezy
$RSYNC $DEB_HOME/apt/jessie/dists $DEB_HOME/apt/jessie/pool zetta:/var/www/html/Debian/jessie
$RSYNC $DEB_HOME/apt/stretch/dists $DEB_HOME/apt/stretch/pool zetta:/var/www/html/Debian/stretch
$RSYNC $DEB_HOME/archive zetta:/var/www/html/Debian
$RSYNC $(dirname $0)/../keys zetta:/var/www/html/Debian
