#!/bin/sh

SCRIPT_DIR=$(cd "$(dirname $0)"; pwd)
DEBIAN_VERSION="$1"
MA_VERSION="$2"
VB_VERSION="$3"
PACKER_VERSION="$4"
OUTPUT="$5"
if [ -z ${OUTPUT} ]; then
    echo "Error: $0 debian_version ma_version vb_version packer_version filename"
    exit 127
fi
PROJECT="Debian GNU/Linux ${DEBIAN_VERSION} (buster)"
YEAR="$(date +%Y)"
MONTH="$(date +%m)"
DAY="$(date +%d)"
HOUR="$(date +%H)"
MINUTE="$(date +%M)"
SECOND="$(date +%S)"
sed -e "s|@MA_VERSION@|${MA_VERSION}|g" \
    -e "s|@PROJECT@|${PROJECT}|g" \
    -e "s|@VB_VERSION@|${VB_VERSION}|g" \
    -e "s|@PACKER_VERSION@|${PACKER_VERSION}|g" \
    -e "s|@DATE@|${DATE}|g" \
    -e "s|@YEAR@|${YEAR}|g" \
    -e "s|@MONTH@|${MONTH}|g" \
    -e "s|@DAY@|${DAY}|g" \
    -e "s|@HOUR@|${HOUR}|g" \
    -e "s|@MINUTE@|${MINUTE}|g" \
    -e "s|@SECOND@|${SECOND}|g" \
${SCRIPT_DIR}/files/login-ma-in.svg > ${OUTPUT}
