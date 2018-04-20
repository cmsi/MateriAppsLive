#!/bin/bash -eux

set -x 

SCRIPT_DIR=$(cd "$(dirname $0)"; pwd)
echo "SCRIPT_DIR=$SCRIPT_DIR"

. $SCRIPT_DIR/version.sh
echo "DEBIAN_VERSION=$DEBIAN_VERSION"

MA_VERSION=$(cat $SCRIPT_DIR/../live/materiapps_version-stretch)
echo "MA_VERSION=$MA_VERSION"

ARCHITECTURES="amd64 i386"
for arch in $ARCHITECTURES; do
    iso="debian-$DEBIAN_VERSION-$arch-DVD-1.iso"
    md5="debian-$DEBIAN_VERSION-$arch-DVD-1.md5"
    if [ -f "$iso" ]; then
	if [ -f "$md5" ]; then :; else
            if [ $(type md5 > /dev/null 2>&1; echo $?) -eq 0 ]; then
		md5 "$iso" | awk '{print $4}' > "$md5"
            else
		md5sum "$iso" | awk '{print $1}' > "$md5"
            fi
	fi
	DEBIAN_CHECKSUM=$(cat "$md5")
	echo "DEBIAN_VERSION=$DEBIAN_CHECKSUM"
	sed -e "s|@MA_VERSION@|${MA_VERSION}|g" \
	    -e "s|@DEBIAN_VERSION@|${DEBIAN_VERSION}|g" \
	    -e "s|@DEBIAN_CHECKSUM@|${DEBIAN_CHECKSUM}|g" \
	    $SCRIPT_DIR/malive-$arch.json.in > malive-$arch.json
    fi
done

cp -fp $SCRIPT_DIR/preseed.cfg .
cp -frp $SCRIPT_DIR/script .
