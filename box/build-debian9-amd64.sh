#!/bin/sh

SCRIPT_DIR=$(cd "$(dirname $0)"; pwd)
. $SCRIPT_DIR/version.sh

if [ -e "http" ]; then :; else ln -s $SCRIPT_DIR/http; fi
if [ -e "script" ]; then :; else ln -s $SCRIPT_DIR/script; fi

BOX="box/virtualbox/debian9-amd64-$DEBIAN9_VERSION.box"
if [ -f "$BOX" ]; then
    echo "Warning: $BOX exists. Skip to build box"
else
  sed -e "s|@DEBIAN9_VERSION@|${DEBIAN9_VERSION}|g" \
      -e "s|@DEBIAN9_CHECKSUM@|${DEBIAN9_AMD64_CHECKSUM}|g" \
      $SCRIPT_DIR/debian9-amd64.json.in > debian9-amd64.json
  mkdir -p log
  packer build -only=virtualbox-iso -var-file=debian9-amd64.json $SCRIPT_DIR/debian.json 2>&1 | tee log/build-debian9-amd64.log
fi
if [ -f "$BOX" ]; then
  CHECKSUM=$(md5sum $BOX | cut -d ' ' -f 1)
  sed -e "s|@DEBIAN9_VERSION@|${DEBIAN9_VERSION}|g" \
      -e "s|@CHECKSUM@|${CHECKSUM}|g" \
  $SCRIPT_DIR/debian9-amd64.metadata.in > box/virtualbox/debian9-amd64.json
fi
