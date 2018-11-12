#!/bin/sh

. ./version.sh

BOX="box/virtualbox/debian10-i386-$DEBIAN10_VERSION.box"
if [ -f "$BOX" ]; then
    echo "Warning: $BOX exists. Skip to build box"
else
  sed -e "s|@DEBIAN10_VERSION@|${DEBIAN10_VERSION}|g" \
      -e "s|@DEBIAN10_CHECKSUM@|${DEBIAN10_I386_CHECKSUM}|g" \
      debian10-i386.json.in > debian10-i386.json
  mkdir -p log
  packer build -only=virtualbox-iso -var-file=debian10-i386.json debian.json 2>&1 | tee log/build-debian10-i386.log
fi
if [ -f "$BOX" ]; then
  CHECKSUM=$(md5sum $BOX | cut -d ' ' -f 1)
  sed -e "s|@DEBIAN10_VERSION@|${DEBIAN10_VERSION}|g" \
      -e "s|@CHECKSUM@|${CHECKSUM}|g" \
  debian10-i386.metadata.in > box/virtualbox/debian10-i386.json
fi
