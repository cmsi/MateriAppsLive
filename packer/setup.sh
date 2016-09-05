#!/bin/sh

SCRIPT_DIR=$(cd "$(dirname $0)"; pwd)
MA_VERSION=$1

if [ -z "$MA_VERSION" ]; then
    echo "Usage: $0 version"
    exit 127
fi

echo "MA_VERSION=$MA_VERSION"
echo "SCRIPT_DIR=$SCRIPT_DIR"

ARCHITECTURES="amd64 i386"
for arch in $ARCHITECTURES; do
    iso="MateriAppsLive-$MA_VERSION-$arch.hybrid.iso"
    if [ -f "$iso" ]; then
        if [ $(type md5 > /dev/null 2>&1; echo $?) -eq 0 ]; then
            MA_CHECKSUM=$(md5 "$iso" | awk '{print $4}')
        else
            MA_CHECKSUM=$(md5sum "$iso" | awk '{print $1}')
        fi
	echo "CHECKSUM ($arch) : $MA_CHECKSUM"
	sed -e "s|@MA_VERSION@|${MA_VERSION}|g" \
	    -e "s|@MA_CHECKSUM@|${MA_CHECKSUM}|g" \
	    $SCRIPT_DIR/malive-$arch.json > malive-$arch.json
	sed -e "s|@MA_VERSION@|${MA_VERSION}|g" \
	    -e "s|@MA_CHECKSUM@|${MA_CHECKSUM}|g" \
	    $SCRIPT_DIR/malive-ltx-$arch.json > malive-ltx-$arch.json
    fi
done

cp -fp $SCRIPT_DIR/preseed.cfg .
