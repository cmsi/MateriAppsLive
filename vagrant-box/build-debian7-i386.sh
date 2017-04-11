#!/bin/sh

. ./version.sh

BOX="box/virtualbox/debian7-i386-$DEBIAN7_VERSION.box"
if [ -f "$BOX" ]; then
    echo "Error: $BOX exists. Exit"
    exit 127
fi

sed -e "s|@DEBIAN7_VERSION@|${DEBIAN7_VERSION}|g" \
    -e "s|@DEBIAN7_CHECKSUM@|${DEBIAN7_I386_CHECKSUM}|g" \
    debian7-i386.json.in > debian7-i386.json

mkdir -p log
packer build -only=virtualbox-iso -var-file=debian7-i386.json debian.json 2>&1 | tee log/build-debian7-i386.log
