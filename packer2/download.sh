#!/bin/bash -eux
  
SCRIPT_DIR=$(cd "$(dirname $0)"; pwd)
echo "SCRIPT_DIR=$SCRIPT_DIR"

. $SCRIPT_DIR/version.sh
echo "DEBIAN_VERSION=$DEBIAN_VERSION"

ISO="debian-${DEBIAN_VERSION}-amd64-DVD-1.iso"
URL="http://ftp.jaist.ac.jp/debian-cd/${DEBIAN_VERSION}/amd64/iso-dvd/${ISO}"

if [ -f "${ISO}" ]; then
  echo "Error: ${ISO} exists. Stop."
  exit 127
fi

echo "Downloading ${URL}"
wget ${URL}
