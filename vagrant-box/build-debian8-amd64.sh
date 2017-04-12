#!/bin/sh

. ./version.sh

BOX="box/virtualbox/debian8-amd64-$DEBIAN8_VERSION.box"
if [ -f "$BOX" ]; then
    echo "Warning: $BOX exists. Skip to build box"
else
  sed -e "s|@DEBIAN8_VERSION@|${DEBIAN8_VERSION}|g" \
      -e "s|@DEBIAN8_CHECKSUM@|${DEBIAN8_AMD64_CHECKSUM}|g" \
      debian8-amd64.json.in > debian8-amd64.json
  mkdir -p log
  packer build -only=virtualbox-iso -var-file=debian8-amd64.json debian.json 2>&1 | tee log/build-debian8-amd64.log
fi
if [ -f "$BOX" ]; then
  CHECKSUM=$(md5sum $BOX | cut -d ' ' -f 1)
  sed -e "s|@DEBIAN8_VERSION@|${DEBIAN8_VERSION}|g" \
      -e "s|@CHECKSUM@|${CHECKSUM}|g" \
  debian8-amd64.metadata.in > box/virtualbox/debian8-amd64.json
fi
