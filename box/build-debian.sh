#!/bin/sh

SCRIPTS="build-debian7-amd64.sh build-debian7-i386.sh build-debian8-amd64.sh build-debian8-i386.sh build-debian9-amd64.sh build-debian9-i386.sh build-debian10-amd64.sh build-debian10-i386.sh"

for s in $SCRIPTS; do
  sh $s
done
