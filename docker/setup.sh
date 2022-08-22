#!/bin/bash -eux

SCRIPT_DIR=$(cd "$(dirname $0)"; pwd)
echo "SCRIPT_DIR=$SCRIPT_DIR"

. $SCRIPT_DIR/../version.sh
echo "MA4_VERSION=$MA4_VERSION"

set -x
sed -e "s|@MA4_VERSION@|${MA4_VERSION}|g" \
      ${SCRIPT_DIR}/malive.in > malive
chmod +x malive
