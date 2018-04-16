#!/bin/sh
DEB_HOME=$HOME/vagrant/data
RSYNC="rsync -avzP --delete -e ssh"

set -x
$RSYNC $DEB_HOME/apt/wheezy/dists $DEB_HOME/apt/wheezy/pool frs.sourceforge.net:/home/frs/project/materiappslive/Debian/apt
$RSYNC $DEB_HOME/apt/wheezy/dists $DEB_HOME/apt/wheezy/pool frs.sourceforge.net:/home/frs/project/materiappslive/Debian/wheezy
$RSYNC $DEB_HOME/apt/jessie/dists $DEB_HOME/apt/jessie/pool frs.sourceforge.net:/home/frs/project/materiappslive/Debian/jessie
$RSYNC $DEB_HOME/apt/stretch/dists $DEB_HOME/apt/stretch/pool frs.sourceforge.net:/home/frs/project/materiappslive/Debian/stretch
$RSYNC $DEB_HOME/archive frs.sourceforge.net:/home/frs/project/materiappslive/Debian
$RSYNC $(dirname $0)/sources frs.sourceforge.net:/home/frs/project/materiappslive/Debian/
$RSYNC $(dirname $0)/../README.md frs.sourceforge.net:/home/frs/project/materiappslive
$RSYNC $(dirname $0)/../keys frs.sourceforge.net:/home/frs/project/materiappslive/Debian/

$RSYNC $DEB_HOME/apt/wheezy/dists $DEB_HOME/apt/wheezy/pool root@exa.phys.s.u-tokyo.ac.jp:/var/www/vhosts/exa.phys.s.u-tokyo.ac.jp/httpdocs/archive/MateriApps/apt/wheezy
$RSYNC $DEB_HOME/apt/jessie/dists $DEB_HOME/apt/jessie/pool root@exa.phys.s.u-tokyo.ac.jp:/var/www/vhosts/exa.phys.s.u-tokyo.ac.jp/httpdocs/archive/MateriApps/apt/jessie
$RSYNC $DEB_HOME/apt/stretch/dists $DEB_HOME/apt/stretch/pool root@exa.phys.s.u-tokyo.ac.jp:/var/www/vhosts/exa.phys.s.u-tokyo.ac.jp/httpdocs/archive/MateriApps/apt/stretch
$RSYNC $DEB_HOME/archive/wheezy/*.orig.tar.gz root@exa.phys.s.u-tokyo.ac.jp:/var/www/vhosts/exa.phys.s.u-tokyo.ac.jp/httpdocs/archive/MateriApps/src
$RSYNC $(dirname $0)/sources root@exa.phys.s.u-tokyo.ac.jp:/var/www/vhosts/exa.phys.s.u-tokyo.ac.jp/httpdocs/archive/MateriApps
$RSYNC $(dirname $0)/../README.md root@exa.phys.s.u-tokyo.ac.jp:/var/www/vhosts/exa.phys.s.u-tokyo.ac.jp/httpdocs/archive/MateriApps
$RSYNC $(dirname $0)/../keys root@exa.phys.s.u-tokyo.ac.jp:/var/www/vhosts/exa.phys.s.u-tokyo.ac.jp/httpdocs/archive/MateriApps
