#!/bin/sh

DEB_HOME=$HOME/malive/data
RSYNC="rsync -avzP --delete -e ssh"

DISTS="trixie bookworm bullseye noble jammy focal"

EXA="tk2-248-33678.vs.sakura.ne.jp"

set -x
for d in $DISTS; do
  $RSYNC $DEB_HOME/apt/$d/dists $DEB_HOME/apt/$d/pool root@${EXA}:/var/www/html/archive/MateriApps/apt/$d
done
scp $(dirname $0)/source/* root@${EXA}:/var/www/html/archive/MateriApps/apt/
scp $(dirname $0)/../keys/materiapps.gpg root@${EXA}:/var/www/html/archive/MateriApps/apt/

for d in $DISTS; do
  $RSYNC $DEB_HOME/apt/$d/dists $DEB_HOME/apt/$d/pool frs.sourceforge.net:/home/frs/project/materiappslive/Debian/$d
done
scp $(dirname $0)/source/* frs.sourceforge.net:/home/frs/project/materiappslive/Debian/
scp $(dirname $0)/../keys/materiapps.gpg frs.sourceforge.net:/home/frs/project/materiappslive/Debian/
