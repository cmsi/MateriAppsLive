#!/bin/sh

SCRIPT_DIR=$(cd "$(dirname $0)"; pwd)

SCRIPTS="build-debian11-amd64.sh build-debian12-amd64.sh"

for s in $SCRIPTS; do
  sh $SCRIPT_DIR/$s
done
