#!/bin/sh
PACKAGE="$1"
test -z $PACKAGE && exit 127
echo "PACKAGE: $PACKAGE"

REPOS_DIR=$HOME/malive/public/repos
CODENAME="forky trixie bookworm bullseye noble jammy"
for cname in $CODENAME; do
  reprepro --ask-passphrase --ignore=wrongdistribution -Vb $REPOS_DIR/$cname remove $cname $PACKAGE
done
