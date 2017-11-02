#!/bin/sh
PACKAGE="$1"
test -z $PACKAGE && exit 127
echo "PACKAGE: $PACKAGE"

CODENAME="stretch jessie wheezy"
for cname in $CODENAME; do
  CHANGES=$(ls $HOME/data/pkg/$cname/${PACKAGE}_*.changes)
  for cng in $CHANGES; do
    echo "Adding ${cng}..."
    reprepro --ask-passphrase --ignore=wrongdistribution -Vb $HOME/data/apt/$cname include $cname $cng
  done
  cp -fp $HOME/data/apt/$cname/pool/*/*/*/${PACKAGE}_* /data/archive/$cname
done
