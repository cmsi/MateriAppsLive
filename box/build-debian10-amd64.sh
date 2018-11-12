#!/bin/sh

. ./version.sh

BOX="box/virtualbox/debian10-amd64-$DEBIAN10_VERSION.box"
if [ -f "$BOX" ]; then
    echo "Warning: $BOX exists. Skip to build box"
else
  sed -e "s|@DEBIAN10_VERSION@|${DEBIAN10_VERSION}|g" \
      -e "s|@DEBIAN10_CHECKSUM@|${DEBIAN10_AMD64_CHECKSUM}|g" \
      debian10-amd64.json.in > debian10-amd64.json
  mkdir -p log
  packer build -only=virtualbox-iso -var-file=debian10-amd64.json debian.json 2>&1 | tee log/build-debian10-amd64.log
fi
if [ -f "$BOX" ]; then
  CHECKSUM=$(md5sum $BOX | cut -d ' ' -f 1)
  sed -e "s|@DEBIAN10_VERSION@|${DEBIAN10_VERSION}|g" \
      -e "s|@CHECKSUM@|${CHECKSUM}|g" \
  debian10-amd64.metadata.in > box/virtualbox/debian10-amd64.json
fi
