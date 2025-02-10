#!/bin/sh

SCRIPT_DIR=$(cd "$(dirname $0)"; pwd)
ARCH=$(arch)
if [ "$ARCH" != "x86_64" ]; then
  SCRIPTS="build-debian11-amd64.sh build-debian12-amd64.sh"
else
  SCRIPTS="build-debian11-arm64.sh build-debian12-arm64.sh"
fi

for s in $SCRIPTS; do
  sh $SCRIPT_DIR/$s
done
