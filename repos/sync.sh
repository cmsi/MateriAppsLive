#!/bin/sh
DEB_HOME=$HOME/vagrant/data
RSYNC="rsync -avzP --delete -e ssh"

DISTS="buster stretch jessie wheezy focal bionic xenial"

EXA0="vps200093.vz3.domainserver.ne.jp"
EXA1="tk2-248-33678.vs.sakura.ne.jp"

set -x
for d in $DISTS; do
  $RSYNC $DEB_HOME/apt/$d/dists $DEB_HOME/apt/$d/pool root@${EXA0}:/var/www/vhosts/exa.phys.s.u-tokyo.ac.jp/httpdocs/archive/MateriApps/apt/$d
done
$RSYNC $DEB_HOME/archive/stretch/*.orig.tar.gz root@${EXA0}:/var/www/vhosts/exa.phys.s.u-tokyo.ac.jp/httpdocs/archive/MateriApps/src
$RSYNC $(dirname $0)/sources root@${EXA0}:/var/www/vhosts/exa.phys.s.u-tokyo.ac.jp/httpdocs/archive/MateriApps
$RSYNC $(dirname $0)/../README.md root@${EXA0}:/var/www/vhosts/exa.phys.s.u-tokyo.ac.jp/httpdocs/archive/MateriApps
$RSYNC $(dirname $0)/../keys root@${EXA0}:/var/www/vhosts/exa.phys.s.u-tokyo.ac.jp/httpdocs/archive/MateriApps
$RSYNC $(dirname $0)/../ova/vbconfig.bat root@${EXA0}:/var/www/vhosts/exa.phys.s.u-tokyo.ac.jp/httpdocs/archive/MateriApps/scripts
$RSYNC $(dirname $0)/../ova/vbconfig.command root@${EXA0}:/var/www/vhosts/exa.phys.s.u-tokyo.ac.jp/httpdocs/archive/MateriApps/scripts

for d in $DISTS; do
  $RSYNC $DEB_HOME/apt/$d/dists $DEB_HOME/apt/$d/pool root@${EXA1}:/var/www/html/archive/MateriApps/apt/$d
done
$RSYNC $DEB_HOME/archive/stretch/*.orig.tar.gz root@${EXA1}:/var/www/html/archive/MateriApps/src
$RSYNC $(dirname $0)/sources root@${EXA1}:/var/www/html/archive/MateriApps
$RSYNC $(dirname $0)/../README.md root@${EXA1}:/var/www/html/archive/MateriApps
$RSYNC $(dirname $0)/../keys root@${EXA1}:/var/www/html/archive/MateriApps
$RSYNC $(dirname $0)/../ova/vbconfig.bat root@${EXA1}:/var/www/html/archive/MateriApps/scripts
$RSYNC $(dirname $0)/../ova/vbconfig.command root@${EXA1}:/var/www/html/archive/MateriApps/scripts

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
