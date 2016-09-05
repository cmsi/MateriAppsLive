#!/bin/sh

set -x

DEB_HOME=$HOME/vagrant/data
RSYNC="rsync -avzP --delete -e ssh"

cp -fp $DEB_HOME/apt/wheezy/pool/*/*/*/* $DEB_HOME/archive/wheezy

$RSYNC $DEB_HOME/apt $DEB_HOME/archive zetta:/usr/local/pub/MateriApps

$RSYNC $DEB_HOME/apt/wheezy/dists $DEB_HOME/apt/wheezy/pool frs.sourceforge.net:/home/frs/project/materiappslive/Debian/apt
$RSYNC $DEB_HOME/archive frs.sourceforge.net:/home/frs/project/materiappslive/Debian
