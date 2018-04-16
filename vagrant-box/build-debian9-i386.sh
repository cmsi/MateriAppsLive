#!/bin/sh

. ./version.sh

BOX="box/virtualbox/debian9-i386-$DEBIAN9_VERSION.box"
if [ -f "$BOX" ]; then
    echo "Warning: $BOX exists. Skip to build box"
else
  sed -e "s|@DEBIAN9_VERSION@|${DEBIAN9_VERSION}|g" \
      -e "s|@DEBIAN9_CHECKSUM@|${DEBIAN9_I386_CHECKSUM}|g" \
      debian9-i386.json.in > debian9-i386.json
  mkdir -p log
  packer build -only=virtualbox-iso -var-file=debian9-i386.json debian.json 2>&1 | tee log/build-debian9-i386.log
fi
if [ -f "$BOX" ]; then
  CHECKSUM=$(md5sum $BOX | cut -d ' ' -f 1)
  sed -e "s|@DEBIAN9_VERSION@|${DEBIAN9_VERSION}|g" \
      -e "s|@CHECKSUM@|${CHECKSUM}|g" \
  debian9-i386.metadata.in > box/virtualbox/debian9-i386.json
fi
