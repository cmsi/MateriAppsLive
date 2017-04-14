#!/bin/sh
DEB_HOME=$HOME/vagrant/data
RSYNC="rsync -avzP --delete -e ssh"

set -x
$RSYNC $DEB_HOME/apt/wheezy/dists $DEB_HOME/apt/wheezy/pool frs.sourceforge.net:/home/frs/project/materiappslive/Debian/apt
$RSYNC $DEB_HOME/apt/wheezy/dists $DEB_HOME/apt/wheezy/pool frs.sourceforge.net:/home/frs/project/materiappslive/Debian/wheezy
$RSYNC $DEB_HOME/apt/jessie/dists $DEB_HOME/apt/jessie/pool frs.sourceforge.net:/home/frs/project/materiappslive/Debian/jessie
$RSYNC $DEB_HOME/archive frs.sourceforge.net:/home/frs/project/materiappslive/Debian
$RSYNC $(dirname $0)/sources frs.sourceforge.net:/home/frs/project/materiappslive/Debian/
