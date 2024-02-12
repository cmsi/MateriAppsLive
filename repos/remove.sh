#!/bin/sh
PACKAGE="$1"
test -z $PACKAGE && exit 127
echo "PACKAGE: $PACKAGE"

CODENAME="trixie bookworm bullseye buster noble jammy focal"
for cname in $CODENAME; do
  reprepro --ask-passphrase --ignore=wrongdistribution -Vb $HOME/malive/data/apt/$cname remove $cname $PACKAGE
done
