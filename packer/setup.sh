#!/bin/bash -eux

SCRIPT_DIR=$(cd "$(dirname $0)"; pwd)
echo "SCRIPT_DIR=$SCRIPT_DIR"

VB_VERSION=$(VBoxManage -v | cut -dr -f1)
echo "VB_VERSION=$VB_VERSION"

PACKER_VERSION=$(packer -v)
echo "PACKER_VERSION=$PACKER_VERSION"

. $SCRIPT_DIR/version.sh

# version 3

echo "DEBIAN10_VERSION=$DEBIAN10_VERSION"
echo "CE3_VERSION=$CE3_VERSION"
ARCHITECTURES="amd64"
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
cp -fp ${SCRIPT_DIR}/preseed-ce3.cfg . > /dev/null 2>&1

echo "DEBIAN10_VERSION=$DEBIAN10_VERSION"
echo "MA3_VERSION=$MA3_VERSION"
ARCHITECTURES="amd64"
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
cp -fp ${SCRIPT_DIR}/preseed-ma3.cfg . > /dev/null 2>&1

# version 4

echo "DEBIAN11_VERSION=$DEBIAN11_VERSION"
echo "CE4_VERSION=$CE4_VERSION"
ARCHITECTURES="amd64"
for arch in $ARCHITECTURES; do
    iso="debian-${DEBIAN11_VERSION}-${arch}-DVD-1.iso"
    md5="debian-${DEBIAN11_VERSION}-${arch}-DVD-1.md5"
    if [ -f "$iso" ]; then
	if [ -f "$md5" ]; then :; else
            if [ $(type md5 > /dev/null 2>&1; echo $?) -eq 0 ]; then
		md5 "$iso" | awk '{print $4}' > "$md5"
            else
		md5sum "$iso" | awk '{print $1}' > "$md5"
            fi
	fi
	DEBIAN11_CHECKSUM=$(cat "$md5")
	echo "$iso: $DEBIAN11_CHECKSUM"
	sed -e "s|@CE4_VERSION@|${CE4_VERSION}|g" \
	    -e "s|@DEBIAN11_VERSION@|${DEBIAN11_VERSION}|g" \
	    -e "s|@DEBIAN11_CHECKSUM@|${DEBIAN11_CHECKSUM}|g" \
	    ${SCRIPT_DIR}/ce4-${arch}.json.in > ce4-${arch}.json
    fi
done
cp -fp ${SCRIPT_DIR}/preseed-ce4.cfg . > /dev/null 2>&1

echo "DEBIAN11_VERSION=$DEBIAN11_VERSION"
echo "MA4_VERSION=$MA4_VERSION"
ARCHITECTURES="amd64"
for arch in $ARCHITECTURES; do
    iso="debian-${DEBIAN11_VERSION}-${arch}-DVD-1.iso"
    md5="debian-${DEBIAN11_VERSION}-${arch}-DVD-1.md5"
    if [ -f "$iso" ]; then
	if [ -f "$md5" ]; then :; else
            if [ $(type md5 > /dev/null 2>&1; echo $?) -eq 0 ]; then
		md5 "$iso" | awk '{print $4}' > "$md5"
            else
		md5sum "$iso" | awk '{print $1}' > "$md5"
            fi
	fi
	DEBIAN11_CHECKSUM=$(cat "$md5")
	echo "$iso: $DEBIAN11_CHECKSUM"
	sed -e "s|@MA4_VERSION@|${MA4_VERSION}|g" \
	    -e "s|@DEBIAN11_VERSION@|${DEBIAN11_VERSION}|g" \
	    -e "s|@DEBIAN11_CHECKSUM@|${DEBIAN11_CHECKSUM}|g" \
	    ${SCRIPT_DIR}/ma4-${arch}.json.in > ma4-${arch}.json
    fi
done
cp -fp ${SCRIPT_DIR}/preseed-ma4.cfg . > /dev/null 2>&1

mkdir -p script
cp -frp ${SCRIPT_DIR}/script/* script/ > /dev/null 2>&1

mkdir -p files
sh ${SCRIPT_DIR}/login-ma.sh ${DEBIAN10_VERSION} ${MA3_VERSION} ${VB_VERSION} ${PACKER_VERSION} files/login-ma3.svg
sh ${SCRIPT_DIR}/login-ce.sh ${DEBIAN10_VERSION} ${CE3_VERSION} ${VB_VERSION} ${PACKER_VERSION} files/login-ce3.svg
sh ${SCRIPT_DIR}/login-ma.sh ${DEBIAN11_VERSION} ${MA4_VERSION} ${VB_VERSION} ${PACKER_VERSION} files/login-ma4.svg
sh ${SCRIPT_DIR}/login-ce.sh ${DEBIAN11_VERSION} ${CE4_VERSION} ${VB_VERSION} ${PACKER_VERSION} files/login-ce4.svg
cp ${SCRIPT_DIR}/files/*.menu ${SCRIPT_DIR}/files/*.directory files/ > /dev/null 2>&1

cp ${SCRIPT_DIR}/build-all.sh . > /dev/null 2>&1
sed -e "s|@MA3_VERSION@|${MA3_VERSION}|g" ${SCRIPT_DIR}/build-ma3.sh.in > build-ma3.sh
sed -e "s|@CE3_VERSION@|${CE3_VERSION}|g" ${SCRIPT_DIR}/build-ce3.sh.in > build-ce3.sh
sed -e "s|@MA4_VERSION@|${MA4_VERSION}|g" ${SCRIPT_DIR}/build-ma4.sh.in > build-ma4.sh
sed -e "s|@CE4_VERSION@|${CE4_VERSION}|g" ${SCRIPT_DIR}/build-ce4.sh.in > build-ce4.sh
