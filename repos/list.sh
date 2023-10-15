#!/bin/sh
PACKAGE="$1"
test -z $PACKAGE && exit 127

DATA_DIR=$HOME/malive/data
CODENAME="trixie bookworm bullseye buster jammy focal"
for cname in $CODENAME; do reprepro -Vb $DATA_DIR/apt/$cname list $cname $PACKAGE; done
