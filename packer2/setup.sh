#!/bin/bash -eux

SCRIPT_DIR=$(cd "$(dirname $0)"; pwd)
echo "SCRIPT_DIR=$SCRIPT_DIR"

. $SCRIPT_DIR/version.sh
echo "DEBIAN_VERSION=$DEBIAN_VERSION"
echo "MA_VERSION=$MA_VERSION"

VB_VERSION=$(VBoxManage -v | cut -dr -f1)
echo "VB_VERSION=$VB_VERSION"

PACKER_VERSION=$(packer -v)
echo "PACKER_VERSION=$PACKER_VERSION"

ARCHITECTURES="amd64 i386"
for arch in $ARCHITECTURES; do
    iso="debian-${DEBIAN_VERSION}-${arch}-DVD-1.iso"
    md5="debian-${DEBIAN_VERSION}-${arch}-DVD-1.md5"
    if [ -f "$iso" ]; then
	if [ -f "$md5" ]; then :; else
            if [ $(type md5 > /dev/null 2>&1; echo $?) -eq 0 ]; then
		md5 "$iso" | awk '{print $4}' > "$md5"
            else
		md5sum "$iso" | awk '{print $1}' > "$md5"
            fi
	fi
	DEBIAN_CHECKSUM=$(cat "$md5")
	echo "$iso: $DEBIAN_CHECKSUM"
	sed -e "s|@MA_VERSION@|${MA_VERSION}|g" \
	    -e "s|@DEBIAN_VERSION@|${DEBIAN_VERSION}|g" \
	    -e "s|@DEBIAN_CHECKSUM@|${DEBIAN_CHECKSUM}|g" \
	    ${SCRIPT_DIR}/malive-${arch}.json.in > malive-${arch}.json
    fi
done

cp -fp ${SCRIPT_DIR}/preseed.cfg .
cp -frp ${SCRIPT_DIR}/script .

mkdir -p files
sh ${SCRIPT_DIR}/login.sh ${DEBIAN_VERSION} ${MA_VERSION} ${VB_VERSION} ${PACKER_VERSION} files/login.svg
cp ${SCRIPT_DIR}/files/*.menu ${SCRIPT_DIR}/files/*.directory files/

sed -e "s|@MA_VERSION@|${MA_VERSION}|g" ${SCRIPT_DIR}/build.sh.in > build.sh
