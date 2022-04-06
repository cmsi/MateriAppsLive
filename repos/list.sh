#!/bin/sh
PACKAGE="$1"
test -z $PACKAGE && exit 127

DATA_DIR=$HOME/malive/data
CODENAME="bullseye buster stretch jessie wheezy jammy focal bionic xenial"
for cname in $CODENAME; do reprepro -Vb $DATA_DIR/apt/$cname list $cname $PACKAGE; done
