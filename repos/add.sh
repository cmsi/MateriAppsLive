#!/bin/sh
PACKAGE="$1"
test -z $PACKAGE && exit 127
echo "PACKAGE: $PACKAGE"

DATA_DIR=$HOME/malive/data
CODENAME="bookworm bullseye buster stretch jammy focal bionic"
for cname in $CODENAME; do
  CHANGES=$(ls $DATA_DIR/pkg/$cname/${PACKAGE}_*.changes)
  for cng in $CHANGES; do
    echo "Adding ${cng}..."
    reprepro --ask-passphrase --ignore=wrongdistribution -Vb $DATA_DIR/apt/$cname include $cname $cng
  done
  cp -fp $DATA_DIR/apt/$cname/pool/*/*/*/*${PACKAGE}_* $DATA_DIR/archive/$cname
done
