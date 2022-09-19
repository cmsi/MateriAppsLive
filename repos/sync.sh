#!/bin/sh

DEB_HOME=$HOME/malive/data
RSYNC="rsync -avzP --delete -e ssh"

DISTS="bullseye buster jammy focal bionic"

EXA="tk2-248-33678.vs.sakura.ne.jp"

set -x
for d in $DISTS; do
  $RSYNC $DEB_HOME/apt/$d/dists $DEB_HOME/apt/$d/pool root@${EXA}:/var/www/html/archive/MateriApps/apt/$d
done
$RSYNC $(dirname $0)/sources root@${EXA}:/var/www/html/archive/MateriApps

for d in $DISTS; do
  $RSYNC $DEB_HOME/apt/$d/dists $DEB_HOME/apt/$d/pool frs.sourceforge.net:/home/frs/project/materiappslive/Debian/$d
done
$RSYNC $(dirname $0)/sources frs.sourceforge.net:/home/frs/project/materiappslive/Debian/
