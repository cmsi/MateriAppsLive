#!/bin/bash -eux
  
SCRIPT_DIR=$(cd "$(dirname $0)"; pwd)
echo "SCRIPT_DIR=$SCRIPT_DIR"

. $SCRIPT_DIR/../config/version.sh

echo "DEBIAN10_VERSION=$DEBIAN10_VERSION"
ARCHITECTURES="amd64"
for arch in ${ARCHITECTURES}; do
  ISO="debian-${DEBIAN10_VERSION}-${arch}-DVD-1.iso"
  if [ -f "${ISO}" ]; then
    echo "Waning: ${ISO} exists. Skip."
  else
    echo "Downloading ${ISO}"
    RELEASE="release archive"
    for rel in ${RELEASE}; do
      URL="http://cdimage.debian.org/cdimage/${rel}/${DEBIAN10_VERSION}/${arch}/iso-dvd"
      RES=$(curl -v -L ${URL}/SHA256SUMS 2>&1 1>/dev/null | awk '{if ($2~"HTTP") print $3}' | tail -1)
      if [ ${RES} = 200 ]; then
	curl -L ${URL}/SHA256SUMS | grep ${ISO} > ${ISO}.sha256sum
	curl -L -O ${URL}/${ISO}
      fi
    done
  fi
done
