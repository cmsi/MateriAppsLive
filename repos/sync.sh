#!/bin/sh

REPOS_DIR=$HOME/malive/public/repos
VB_DIR=$HOME/malive/public/vb
RSYNC="rsync -avzP --delete -e ssh"

DISTS="trixie bookworm bullseye noble jammy focal"

EXA_ROOT="root@tk2-248-33678.vs.sakura.ne.jp:/var/www/html/archive/MateriApps"
SF_ROOT="frs.sourceforge.net:/home/frs/project/materiappslive"
AWS_ROOT="s3://malive"

set -x

# exa
for d in $DISTS; do
  $RSYNC $REPOS_DIR/$d/dists $REPOS_DIR/$d/pool $EXA_ROOT/apt/$d
done
scp $(dirname $0)/source/setup.sh $EXA_ROOT/apt/
scp $(dirname $0)/../keys/materiapps.gpg $EXA_ROOT/apt/
scp $(dirname $0)/../docker/malive.sh $EXA_ROOT

# sourceforge
for d in $DISTS; do
  $RSYNC $REPOS_DIR/$d/dists $REPOS_DIR/$d/pool $SF_ROOT/Debian/$d
done
cp $(dirname $0)/source/setup.sh $SF_ROOT/Debian/
scp $(dirname $0)/../keys/materiapps.gpg $SF_ROOT/Debian/
scp $(dirname $0)/../docker/malive.sh $SF_ROOT

# aws
for d in $DISTS; do
  aws s3 sync $REPOS_DIR/$d/dists $AWS_ROOT/repos/$d/dists --delete
  aws s3 sync $REPOS_DIR/$d/pool $AWS_ROOT/repos/$d/pool --delete
done
aws s3 sync $VB_DIR $AWS_ROOT/vb --delete
aws s3 cp $(dirname $0)/source/setup.sh $AWS_ROOT/repos/
aws s3 cp $(dirname $0)/../keys/materiapps.gpg $AWS_ROOT/repos/
aws s3 cp $(dirname $0)/../docker/malive.sh $AWS_ROOT/
