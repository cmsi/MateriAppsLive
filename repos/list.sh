#!/bin/sh
PACKAGE="$1"
test -z $PACKAGE && exit 127

REPOS_DIR=$HOME/malive/public/repos
CODENAME="trixie bookworm bullseye noble jammy focal"
for cname in $CODENAME; do reprepro -Vb $REPOS_DIR/$cname list $cname $PACKAGE; done
