#!/bin/bash -eux

SCRIPT_DIR=$(cd "$(dirname $0)"; pwd)
echo "SCRIPT_DIR=$SCRIPT_DIR"

VB_VERSION=$(VBoxManage -v | cut -dr -f1)
echo "VB_VERSION=$VB_VERSION"

PACKER_VERSION=$(packer -v)
echo "PACKER_VERSION=$PACKER_VERSION"

. $SCRIPT_DIR/../config/version.sh
. $SCRIPT_DIR/../config/package.sh

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
  mkdir -p files script
  cp ${SCRIPT_DIR}/files/login-*-in.svg files/ > /dev/null 2>&1
  sh ${SCRIPT_DIR}/login-ma.sh ${DEBIAN11_VERSION} ${MA4_VERSION} ${VB_VERSION} ${PACKER_VERSION} files/login-ma4.svg
  sh ${SCRIPT_DIR}/login-ce.sh ${DEBIAN11_VERSION} ${CE4_VERSION} ${VB_VERSION} ${PACKER_VERSION} files/login-ce4.svg
  sed -e "s|@MA4_VERSION@|${MA4_VERSION}|g" ${SCRIPT_DIR}/build-ma4.sh.in > build-ma4.sh
  sed -e "s|@CE4_VERSION@|${CE4_VERSION}|g" ${SCRIPT_DIR}/build-ce4.sh.in > build-ce4.sh
  sed -e "s|@PACKAGES_DEVELOPMENT@|${PACKAGES_DEVELOPMENT}|g" \
      -e "s|@PACKAGES_PYTHON@|${PACKAGES_PYTHON}|g" \
      -e "s|@PACKAGES_APPLICATION@|${PACKAGES_APPLICATION}|g" \
      -e "s|@PACKAGES_APPLICATION_GUI@|${PACKAGES_APPLICATION_GUI}|g" \
      ${SCRIPT_DIR}/script/materiapps.sh.in > script/materiapps.sh
  sed -e "s|@PACKAGES_DEVELOPMENT@|${PACKAGES_DEVELOPMENT}|g" \
      -e "s|@PACKAGES_PYTHON@|${PACKAGES_PYTHON}|g" \
      ${SCRIPT_DIR}/script/ceenv.sh.in > script/ceenv.sh
  cp -frp ${SCRIPT_DIR}/script/* script/ > /dev/null 2>&1
  cp ${SCRIPT_DIR}/files/*.menu ${SCRIPT_DIR}/files/*.directory files/ > /dev/null 2>&1
  cp ${SCRIPT_DIR}/build-all.sh . > /dev/null 2>&1
fi

# version 5

iso="debian-${DEBIAN12_VERSION}-amd64-DVD-1.iso"
sha256sum="debian-${DEBIAN12_VERSION}-amd64-DVD-1.iso.sha256sum"
if [ -f "${iso}" ] && [ -f "${sha256sum}" ]; then
  echo "DEBIAN12_VERSION=$DEBIAN12_VERSION"
  echo "MA5_VERSION=$MA5_VERSION"
  echo "CE5_VERSION=$CE5_VERSION"
  sed -e "s|@MA5_VERSION@|${MA5_VERSION}|g" \
      -e "s|@DEBIAN12_VERSION@|${DEBIAN12_VERSION}|g" \
      ${SCRIPT_DIR}/ma4-amd64.json.in > ma4-amd64.json
  sed -e "s|@CE5_VERSION@|${CE5_VERSION}|g" \
      -e "s|@DEBIAN12_VERSION@|${DEBIAN12_VERSION}|g" \
      ${SCRIPT_DIR}/ce4-amd64.json.in > ce4-amd64.json
  cp -fp ${SCRIPT_DIR}/preseed-ma4.cfg . > /dev/null 2>&1
  cp -fp ${SCRIPT_DIR}/preseed-ce4.cfg . > /dev/null 2>&1
  mkdir -p files script
  cp ${SCRIPT_DIR}/files/login-*-in.svg files/ > /dev/null 2>&1
  sh ${SCRIPT_DIR}/login-ma.sh ${DEBIAN12_VERSION} ${MA5_VERSION} ${VB_VERSION} ${PACKER_VERSION} files/login-ma4.svg
  sh ${SCRIPT_DIR}/login-ce.sh ${DEBIAN12_VERSION} ${CE5_VERSION} ${VB_VERSION} ${PACKER_VERSION} files/login-ce4.svg
  sed -e "s|@MA5_VERSION@|${MA5_VERSION}|g" ${SCRIPT_DIR}/build-ma4.sh.in > build-ma4.sh
  sed -e "s|@CE5_VERSION@|${CE5_VERSION}|g" ${SCRIPT_DIR}/build-ce4.sh.in > build-ce4.sh
  sed -e "s|@PACKAGES_DEVELOPMENT@|${PACKAGES_DEVELOPMENT}|g" \
      -e "s|@PACKAGES_PYTHON@|${PACKAGES_PYTHON}|g" \
      -e "s|@PACKAGES_APPLICATION@|${PACKAGES_APPLICATION}|g" \
      -e "s|@PACKAGES_APPLICATION_GUI@|${PACKAGES_APPLICATION_GUI}|g" \
      ${SCRIPT_DIR}/script/materiapps.sh.in > script/materiapps.sh
  sed -e "s|@PACKAGES_DEVELOPMENT@|${PACKAGES_DEVELOPMENT}|g" \
      -e "s|@PACKAGES_PYTHON@|${PACKAGES_PYTHON}|g" \
      ${SCRIPT_DIR}/script/ceenv.sh.in > script/ceenv.sh
  cp -frp ${SCRIPT_DIR}/script/* script/ > /dev/null 2>&1
  cp ${SCRIPT_DIR}/files/*.menu ${SCRIPT_DIR}/files/*.directory files/ > /dev/null 2>&1
  cp ${SCRIPT_DIR}/build-all.sh . > /dev/null 2>&1
fi
