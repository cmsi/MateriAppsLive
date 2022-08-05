#!/bin/bash -eux

SCRIPT_DIR=$(cd "$(dirname $0)"; pwd)
echo "SCRIPT_DIR=$SCRIPT_DIR"

VB_VERSION=$(VBoxManage -v | cut -dr -f1)
echo "VB_VERSION=$VB_VERSION"

PACKER_VERSION=$(packer -v)
echo "PACKER_VERSION=$PACKER_VERSION"

. $SCRIPT_DIR/version.sh

# version 3

iso="debian-${DEBIAN10_VERSION}-amd64-DVD-1.iso"
sha256sum="debian-${DEBIAN10_VERSION}-amd64-DVD-1.iso.sha256sum"
if [ -f "${iso}" ] && [ -f "${sha256sum}" ]; then
  echo "DEBIAN10_VERSION=$DEBIAN10_VERSION"
  echo "MA3_VERSION=$MA3_VERSION"
  echo "CE3_VERSION=$CE3_VERSION"
  sed -e "s|@MA3_VERSION@|${MA3_VERSION}|g" \
      -e "s|@DEBIAN10_VERSION@|${DEBIAN10_VERSION}|g" \
      ${SCRIPT_DIR}/ma3-amd64.json.in > ma3-amd64.json
  sed -e "s|@CE3_VERSION@|${CE3_VERSION}|g" \
      -e "s|@DEBIAN10_VERSION@|${DEBIAN10_VERSION}|g" \
      ${SCRIPT_DIR}/ce3-amd64.json.in > ce3-amd64.json
  cp -fp ${SCRIPT_DIR}/preseed-ma3.cfg . > /dev/null 2>&1
  cp -fp ${SCRIPT_DIR}/preseed-ce3.cfg . > /dev/null 2>&1
  mkdir -p files
  cp ${SCRIPT_DIR}/files/login-*-in.svg files/ > /dev/null 2>&1
  sh ${SCRIPT_DIR}/login-ma.sh ${DEBIAN10_VERSION} ${MA3_VERSION} ${VB_VERSION} ${PACKER_VERSION} files/login-ma3.svg
  sh ${SCRIPT_DIR}/login-ce.sh ${DEBIAN10_VERSION} ${CE3_VERSION} ${VB_VERSION} ${PACKER_VERSION} files/login-ce3.svg
  sed -e "s|@MA3_VERSION@|${MA3_VERSION}|g" ${SCRIPT_DIR}/build-ma3.sh.in > build-ma3.sh
  sed -e "s|@CE3_VERSION@|${CE3_VERSION}|g" ${SCRIPT_DIR}/build-ce3.sh.in > build-ce3.sh
fi

# version 4

iso="debian-${DEBIAN11_VERSION}-amd64-DVD-1.iso"
sha256sum="debian-${DEBIAN11_VERSION}-amd64-DVD-1.iso.sha256sum"
if [ -f "${iso}" ] && [ -f "${sha256sum}" ]; then
  echo "DEBIAN11_VERSION=$DEBIAN11_VERSION"
  echo "MA4_VERSION=$MA4_VERSION"
  echo "CE4_VERSION=$CE4_VERSION"
  sed -e "s|@MA4_VERSION@|${MA4_VERSION}|g" \
      -e "s|@DEBIAN11_VERSION@|${DEBIAN11_VERSION}|g" \
      ${SCRIPT_DIR}/ma4-amd64.json.in > ma4-amd64.json
  sed -e "s|@CE4_VERSION@|${CE4_VERSION}|g" \
      -e "s|@DEBIAN11_VERSION@|${DEBIAN11_VERSION}|g" \
      ${SCRIPT_DIR}/ce4-amd64.json.in > ce4-amd64.json
  cp -fp ${SCRIPT_DIR}/preseed-ma4.cfg . > /dev/null 2>&1
  cp -fp ${SCRIPT_DIR}/preseed-ce4.cfg . > /dev/null 2>&1
  mkdir -p files
  cp ${SCRIPT_DIR}/files/login-*-in.svg files/ > /dev/null 2>&1
  sh ${SCRIPT_DIR}/login-ma.sh ${DEBIAN11_VERSION} ${MA4_VERSION} ${VB_VERSION} ${PACKER_VERSION} files/login-ma4.svg
  sh ${SCRIPT_DIR}/login-ce.sh ${DEBIAN11_VERSION} ${CE4_VERSION} ${VB_VERSION} ${PACKER_VERSION} files/login-ce4.svg
  sed -e "s|@MA4_VERSION@|${MA4_VERSION}|g" ${SCRIPT_DIR}/build-ma4.sh.in > build-ma4.sh
  sed -e "s|@CE4_VERSION@|${CE4_VERSION}|g" ${SCRIPT_DIR}/build-ce4.sh.in > build-ce4.sh
fi

if [ -f ma3-amd64.json ] || [ -f ma4-amd64.json ]; then
  mkdir -p script
  cp -frp ${SCRIPT_DIR}/script/* script/ > /dev/null 2>&1
  cp ${SCRIPT_DIR}/files/*.menu ${SCRIPT_DIR}/files/*.directory files/ > /dev/null 2>&1
  cp ${SCRIPT_DIR}/build-all.sh . > /dev/null 2>&1
fi
