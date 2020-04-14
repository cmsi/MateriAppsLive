#!/bin/sh
DEB_HOME=$HOME/vagrant/data
RSYNC="rsync -avzP --delete -e ssh"

DISTS="buster stretch jessie wheezy bionic xenial"

set -x
for d in $DISTS; do
  $RSYNC $DEB_HOME/apt/$d/dists $DEB_HOME/apt/$d/pool root@exa.phys.s.u-tokyo.ac.jp:/var/www/vhosts/exa.phys.s.u-tokyo.ac.jp/httpdocs/archive/MateriApps/apt/$d
done
$RSYNC $DEB_HOME/archive/stretch/*.orig.tar.gz root@exa.phys.s.u-tokyo.ac.jp:/var/www/vhosts/exa.phys.s.u-tokyo.ac.jp/httpdocs/archive/MateriApps/src
$RSYNC $(dirname $0)/sources root@exa.phys.s.u-tokyo.ac.jp:/var/www/vhosts/exa.phys.s.u-tokyo.ac.jp/httpdocs/archive/MateriApps
$RSYNC $(dirname $0)/../README.md root@exa.phys.s.u-tokyo.ac.jp:/var/www/vhosts/exa.phys.s.u-tokyo.ac.jp/httpdocs/archive/MateriApps
$RSYNC $(dirname $0)/../keys root@exa.phys.s.u-tokyo.ac.jp:/var/www/vhosts/exa.phys.s.u-tokyo.ac.jp/httpdocs/archive/MateriApps

for d in $DISTS; do
  $RSYNC $DEB_HOME/apt/$d/dists $DEB_HOME/apt/$d/pool frs.sourceforge.net:/home/frs/project/materiappslive/Debian/$d
done
$RSYNC $DEB_HOME/archive frs.sourceforge.net:/home/frs/project/materiappslive/Debian
$RSYNC $(dirname $0)/sources frs.sourceforge.net:/home/frs/project/materiappslive/Debian/
$RSYNC $(dirname $0)/../README.md frs.sourceforge.net:/home/frs/project/materiappslive
$RSYNC $(dirname $0)/../keys frs.sourceforge.net:/home/frs/project/materiappslive/Debian/

$RSYNC $(dirname $0)/../README-ceenv.md frs.sourceforge.net:/home/frs/project/ceenv

for d in $DISTS; do
  $RSYNC $DEB_HOME/apt/$d/dists $DEB_HOME/apt/$d/pool zetta:/var/www/html/Debian/$d
done
$RSYNC $DEB_HOME/archive zetta:/var/www/html/Debian
$RSYNC $(dirname $0)/../keys zetta:/var/www/html/Debian
