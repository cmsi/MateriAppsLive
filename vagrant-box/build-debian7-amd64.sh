#!/bin/sh

. ./version.sh

BOX="box/virtualbox/debian7-amd64-$DEBIAN7_VERSION.box"
if [ -f "$BOX" ]; then
    echo "Error: $BOX exists. Exit"
    exit 127
fi

sed -e "s|@DEBIAN7_VERSION@|${DEBIAN7_VERSION}|g" \
    -e "s|@DEBIAN7_CHECKSUM@|${DEBIAN7_AMD64_CHECKSUM}|g" \
    debian7-amd64.json.in > debian7-amd64.json

mkdir -p log
packer build -only=virtualbox-iso -var-file=debian7-amd64.json debian.json 2>&1 | tee log/build-debian7-amd64.log
