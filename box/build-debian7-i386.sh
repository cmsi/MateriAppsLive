#!/bin/sh

SCRIPT_DIR=$(cd "$(dirname $0)"; pwd)
. $SCRIPT_DIR/version.sh

if [ -e "http" ]; then :; else ln -s $SCRIPT_DIR/http; fi
if [ -e "script" ]; then :; else ln -s $SCRIPT_DIR/script; fi

BOX="box/virtualbox/debian7-i386-$DEBIAN7_VERSION.box"
if [ -f "$BOX" ]; then
    echo "Warning: $BOX exists. Skip to build box"
else
  sed -e "s|@DEBIAN7_VERSION@|${DEBIAN7_VERSION}|g" \
      -e "s|@DEBIAN7_CHECKSUM@|${DEBIAN7_I386_CHECKSUM}|g" \
      $SCRIPT_DIR/debian7-i386.json.in > debian7-i386.json
  mkdir -p log
  packer build -only=virtualbox-iso -var-file=debian7-i386.json $SCRIPT_DIR/debian.json 2>&1 | tee log/build-debian7-i386.log
fi
if [ -f "$BOX" ]; then
  CHECKSUM=$(md5sum $BOX | cut -d ' ' -f 1)
  sed -e "s|@DEBIAN7_VERSION@|${DEBIAN7_VERSION}|g" \
      -e "s|@CHECKSUM@|${CHECKSUM}|g" \
  $SCRIPT_DIR/debian7-i386.metadata.in > box/virtualbox/debian7-i386.json
fi
