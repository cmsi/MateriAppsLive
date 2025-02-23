#!/bin/sh
PACKAGE="$1"
test -z $PACKAGE && exit 127
echo "PACKAGE: $PACKAGE"

DATA_DIR=$HOME/malive/data
REPOS_DIR=$HOME/malive/public/repos
CODENAME="trixie bookworm bullseye noble jammy focal"
for cname in $CODENAME; do
  CHANGES=$(ls $DATA_DIR/pkg/$cname/${PACKAGE}_*.changes)
  for cng in $CHANGES; do
    echo "Adding ${cng}..."
    reprepro --ask-passphrase --ignore=wrongdistribution -Vb $REPOS_DIR/$cname include $cname $cng
  done
  cp -fp $REPOS_DIR/$cname/pool/*/*/*/*${PACKAGE}_* $DATA_DIR/archive/$cname
done
