#!/bin/sh

. ./version.sh

BOX="box/virtualbox/debian8-amd64-$DEBIAN8_VERSION.box"
if [ -f "$BOX" ]; then
    echo "Error: $BOX exists. Exit"
    exit 127
fi

sed -e "s|@DEBIAN8_VERSION@|${DEBIAN8_VERSION}|g" \
    -e "s|@DEBIAN8_CHECKSUM@|${DEBIAN8_AMD64_CHECKSUM}|g" \
    debian8-amd64.json.in > debian8-amd64.json

mkdir -p log
packer build -only=virtualbox-iso -var-file=debian8-amd64.json debian.json 2>&1 | tee log/build-debian8-amd64.log
