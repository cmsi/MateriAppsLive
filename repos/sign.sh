#!/bin/sh
PACKAGE="$1"
test -z $PACKAGE && exit 127
echo "PACKAGE: $PACKAGE"

debsign $HOME/data/pkg/*/${PACKAGE}_${VERSION}*.changes

