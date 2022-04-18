#!/bin/bash -eux
  
SCRIPT_DIR=$(cd "$(dirname $0)"; pwd)
echo "SCRIPT_DIR=$SCRIPT_DIR"

. $SCRIPT_DIR/version.sh

echo "DEBIAN11_VERSION=$DEBIAN11_VERSION"
ARCHITECTURES="amd64"
for arch in ${ARCHITECTURES}; do
  ISO="debian-${DEBIAN11_VERSION}-${arch}-DVD-1.iso"
  URL="http://cdimage.debian.org/cdimage/release/${DEBIAN11_VERSION}/${arch}/iso-dvd/${ISO}"
  if [ -f "${ISO}" ]; then
    echo "Waning: ${ISO} exists. Skip."
  else
    echo "Downloading ${URL}"
    wget ${URL}
  fi
done