#!/bin/sh
DEB_HOME=$HOME/malive/data
RSYNC="rsync -avzP --delete -e ssh"

DISTS="bullseye buster stretch jessie wheezy focal bionic xenial"

EXA="tk2-248-33678.vs.sakura.ne.jp"

set -x
for d in $DISTS; do
  $RSYNC $DEB_HOME/apt/$d/dists $DEB_HOME/apt/$d/pool root@${EXA}:/var/www/html/archive/MateriApps/apt/$d
done
$RSYNC $DEB_HOME/archive/stretch/*.orig.tar.gz root@${EXA}:/var/www/html/archive/MateriApps/src
$RSYNC $(dirname $0)/sources root@${EXA}:/var/www/html/archive/MateriApps
$RSYNC $(dirname $0)/../README.md root@${EXA}:/var/www/html/archive/MateriApps
$RSYNC $(dirname $0)/../keys root@${EXA}:/var/www/html/archive/MateriApps
$RSYNC $(dirname $0)/../ova/vbconfig.bat root@${EXA}:/var/www/html/archive/MateriApps/scripts
$RSYNC $(dirname $0)/../ova/vbconfig.command root@${EXA}:/var/www/html/archive/MateriApps/scripts

for d in $DISTS; do
  $RSYNC $DEB_HOME/apt/$d/dists $DEB_HOME/apt/$d/pool frs.sourceforge.net:/home/frs/project/materiappslive/Debian/$d
done
$RSYNC $DEB_HOME/archive frs.sourceforge.net:/home/frs/project/materiappslive/Debian
$RSYNC $(dirname $0)/sources frs.sourceforge.net:/home/frs/project/materiappslive/Debian/
$RSYNC $(dirname $0)/../README.md frs.sourceforge.net:/home/frs/project/materiappslive
$RSYNC $(dirname $0)/../keys frs.sourceforge.net:/home/frs/project/materiappslive/Debian/
$RSYNC $(dirname $0)/../ova/vbconfig.bat frs.sourceforge.net:/home/frs/project/materiappslive/Debian/scripts
$RSYNC $(dirname $0)/../ova/vbconfig.command frs.sourceforge.net:/home/frs/project/materiappslive/Debian/scripts

$RSYNC $(dirname $0)/../README-ceenv.md frs.sourceforge.net:/home/frs/project/ceenv

for d in $DISTS; do
  $RSYNC $DEB_HOME/apt/$d/dists $DEB_HOME/apt/$d/pool zetta:/var/www/html/Debian/$d
done
$RSYNC $DEB_HOME/archive zetta:/var/www/html/Debian
$RSYNC $(dirname $0)/../keys zetta:/var/www/html/Debian
