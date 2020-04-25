#!/bin/bash -eux
  
SCRIPT_DIR=$(cd "$(dirname $0)"; pwd)
echo "SCRIPT_DIR=$SCRIPT_DIR"

. $SCRIPT_DIR/version.sh

echo "DEBIAN9_VERSION=$DEBIAN9_VERSION"
ARCHITECTURES="amd64"
for arch in ${ARCHITECTURES}; do
  ISO="debian-${DEBIAN9_VERSION}-${arch}-DVD-1.iso"
  URL="http://cdimage.debian.org/cdimage/archive/${DEBIAN9_VERSION}/${arch}/iso-dvd/${ISO}"
  if [ -f "${ISO}" ]; then
    echo "Waning: ${ISO} exists. Skip."
  else
    echo "Downloading ${URL}"
    wget ${URL}
  fi
done

echo "DEBIAN10_VERSION=$DEBIAN10_VERSION"
ARCHITECTURES="amd64 i386"
for arch in ${ARCHITECTURES}; do
  ISO="debian-${DEBIAN10_VERSION}-${arch}-DVD-1.iso"
  URL="http://cdimage.debian.org/cdimage/release/${DEBIAN10_VERSION}/${arch}/iso-dvd/${ISO}"
  if [ -f "${ISO}" ]; then
    echo "Waning: ${ISO} exists. Skip."
  else
    echo "Downloading ${URL}"
    wget ${URL}
  fi
done
