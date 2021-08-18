#!/bin/sh
PACKAGE="$1"
test -z $PACKAGE && exit 127
echo "PACKAGE: $PACKAGE"

CODENAME="bullseye buster stretch jessie wheezy focal bionic xenial"
for cname in $CODENAME; do
  reprepro --ask-passphrase --ignore=wrongdistribution -Vb $HOME/data/apt/$cname remove $cname $PACKAGE
done
