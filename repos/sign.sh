#!/bin/sh
PACKAGE="$1"
test -z $PACKAGE && exit 127
echo "PACKAGE: $PACKAGE"
DATA_DIR=$HOME/malive/data

debsign $DATA_DIR/pkg/*/${PACKAGE}_${VERSION}*.changes
