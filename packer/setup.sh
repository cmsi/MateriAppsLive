#!/bin/bash -eux

SCRIPT_DIR=$(cd "$(dirname $0)"; pwd)
echo "SCRIPT_DIR=$SCRIPT_DIR"

VB_VERSION=$(VBoxManage -v | cut -dr -f1)
echo "VB_VERSION=$VB_VERSION"

PACKER_VERSION=$(packer -v)
echo "PACKER_VERSION=$PACKER_VERSION"

. $SCRIPT_DIR/version.sh

echo "DEBIAN9_VERSION=$DEBIAN9_VERSION"
echo "MA2_VERSION=$MA2_VERSION"
ARCHITECTURES="amd64 i386"
for arch in $ARCHITECTURES; do
    iso="debian-${DEBIAN9_VERSION}-${arch}-DVD-1.iso"
    md5="debian-${DEBIAN9_VERSION}-${arch}-DVD-1.md5"
    if [ -f "$iso" ]; then
	if [ -f "$md5" ]; then :; else
            if [ $(type md5 > /dev/null 2>&1; echo $?) -eq 0 ]; then
		md5 "$iso" | awk '{print $4}' > "$md5"
            else
		md5sum "$iso" | awk '{print $1}' > "$md5"
            fi
	fi
	DEBIAN9_CHECKSUM=$(cat "$md5")
	echo "$iso: $DEBIAN9_CHECKSUM"
	sed -e "s|@MA2_VERSION@|${MA2_VERSION}|g" \
	    -e "s|@DEBIAN9_VERSION@|${DEBIAN9_VERSION}|g" \
	    -e "s|@DEBIAN9_CHECKSUM@|${DEBIAN9_CHECKSUM}|g" \
	    ${SCRIPT_DIR}/ma2-${arch}.json.in > ma2-${arch}.json
    fi
done
cp -fp ${SCRIPT_DIR}/preseed-ma2.cfg .

echo "DEBIAN10_VERSION=$DEBIAN10_VERSION"
echo "CE3_VERSION=$CE3_VERSION"
ARCHITECTURES="amd64 i386"
for arch in $ARCHITECTURES; do
    iso="debian-${DEBIAN10_VERSION}-${arch}-DVD-1.iso"
    md5="debian-${DEBIAN10_VERSION}-${arch}-DVD-1.md5"
    if [ -f "$iso" ]; then
	if [ -f "$md5" ]; then :; else
            if [ $(type md5 > /dev/null 2>&1; echo $?) -eq 0 ]; then
		md5 "$iso" | awk '{print $4}' > "$md5"
            else
		md5sum "$iso" | awk '{print $1}' > "$md5"
            fi
	fi
	DEBIAN10_CHECKSUM=$(cat "$md5")
	echo "$iso: $DEBIAN10_CHECKSUM"
	sed -e "s|@CE3_VERSION@|${CE3_VERSION}|g" \
	    -e "s|@DEBIAN10_VERSION@|${DEBIAN10_VERSION}|g" \
	    -e "s|@DEBIAN10_CHECKSUM@|${DEBIAN10_CHECKSUM}|g" \
	    ${SCRIPT_DIR}/ce3-${arch}.json.in > ce3-${arch}.json
    fi
done
cp -fp ${SCRIPT_DIR}/preseed-ce3.cfg .

echo "DEBIAN10_VERSION=$DEBIAN10_VERSION"
echo "MA3_VERSION=$MA3_VERSION"
ARCHITECTURES="amd64 i386"
for arch in $ARCHITECTURES; do
    iso="debian-${DEBIAN10_VERSION}-${arch}-DVD-1.iso"
    md5="debian-${DEBIAN10_VERSION}-${arch}-DVD-1.md5"
    if [ -f "$iso" ]; then
	if [ -f "$md5" ]; then :; else
            if [ $(type md5 > /dev/null 2>&1; echo $?) -eq 0 ]; then
		md5 "$iso" | awk '{print $4}' > "$md5"
            else
		md5sum "$iso" | awk '{print $1}' > "$md5"
            fi
	fi
	DEBIAN10_CHECKSUM=$(cat "$md5")
	echo "$iso: $DEBIAN10_CHECKSUM"
	sed -e "s|@MA3_VERSION@|${MA3_VERSION}|g" \
	    -e "s|@DEBIAN10_VERSION@|${DEBIAN10_VERSION}|g" \
	    -e "s|@DEBIAN10_CHECKSUM@|${DEBIAN10_CHECKSUM}|g" \
	    ${SCRIPT_DIR}/ma3-${arch}.json.in > ma3-${arch}.json
    fi
done
cp -fp ${SCRIPT_DIR}/preseed-ma3.cfg .

cp -frp ${SCRIPT_DIR}/script .

mkdir -p files
sh ${SCRIPT_DIR}/login-ma2.sh ${DEBIAN9_VERSION} ${MA2_VERSION} ${VB_VERSION} ${PACKER_VERSION} files/login-ma2.svg
sh ${SCRIPT_DIR}/login-ma3.sh ${DEBIAN10_VERSION} ${MA3_VERSION} ${VB_VERSION} ${PACKER_VERSION} files/login-ma3.svg
sh ${SCRIPT_DIR}/login-ce3.sh ${DEBIAN10_VERSION} ${CE3_VERSION} ${VB_VERSION} ${PACKER_VERSION} files/login-ce3.svg
cp ${SCRIPT_DIR}/files/*.menu ${SCRIPT_DIR}/files/*.directory files/

cp ${SCRIPT_DIR}/build-all.sh .
sed -e "s|@MA2_VERSION@|${MA2_VERSION}|g" ${SCRIPT_DIR}/build-ma2.sh.in > build-ma2.sh
sed -e "s|@MA3_VERSION@|${MA3_VERSION}|g" ${SCRIPT_DIR}/build-ma3.sh.in > build-ma3.sh
sed -e "s|@CE3_VERSION@|${CE3_VERSION}|g" ${SCRIPT_DIR}/build-ce3.sh.in > build-ce3.sh
