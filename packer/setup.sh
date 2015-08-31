#!/bin/sh

SCRIPT_DIR=$(cd "$(dirname $0)"; pwd)
MA_VERSION=$1
TARGET_DIR=$2

if [ -z "$TARGET_DIR" ]; then
    echo "Usage: $0 version target_dir"
    exit 127
fi

echo "MA_VERSION=$MA_VERSION"
echo "SCRIPT_DIR=$SCRIPT_DIR"
echo "TARGET_DIR=$TARGET_DIR"

ARCHITECTURES="x86_64 i386"
for arch in $ARCHITECTURES; do
    iso="$TARGET_DIR/MateriAppsLive-$MA_VERSION-$arch.hybrid.iso"
    if [ -f "$iso" ]; then
	MA_CHECKSUM=$(md5 "$iso" | awk '{print $4}')
	echo "CHECKSUM ($arch) : $MA_CHECKSUM"
	sed -e "s|@MA_VERSION@|${MA_VERSION}|g" \
	    -e "s|@MA_CHECKSUM@|${MA_CHECKSUM}|g" \
	    $SCRIPT_DIR/malive-$arch.json > $TARGET_DIR/malive-$arch.json
	sed -e "s|@MA_VERSION@|${MA_VERSION}|g" \
	    -e "s|@MA_CHECKSUM@|${MA_CHECKSUM}|g" \
	    $SCRIPT_DIR/malive-ltx-$arch.json > $TARGET_DIR/malive-ltx-$arch.json
    fi
done

cp -fp $SCRIPT_DIR/preseed.cfg $TARGET_DIR
