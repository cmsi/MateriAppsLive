#!/bin/sh
PACKAGE="$1"
test -z $PACKAGE && exit 127
echo "PACKAGE: $PACKAGE"

CODENAME="bookworm bullseye buster stretch jammy focal bionic"
for cname in $CODENAME; do
  reprepro --ask-passphrase --ignore=wrongdistribution -Vb $HOME/data/apt/$cname remove $cname $PACKAGE
done
