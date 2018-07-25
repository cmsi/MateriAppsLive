#!/bin/sh

SCRIPT_DIR=$(cd "$(dirname $0)"; pwd)
VERSION="$1"
OUTPUT="$2"
if [ -z ${OUTPUT} ]; then
    echo "Error: $0 version filename"
    exit 127
fi
PROJECT="Debian GNU/Linux 9 (stretch)"
YEAR="$(date +%Y)"
MONTH="$(date +%m)"
DAY="$(date +%d)"
HOUR="$(date +%H)"
MINUTE="$(date +%M)"
SECOND="$(date +%S)"
sed -e "s|@MA_VERSION@|${VERSION}|g" \
    -e "s|@PROJECT@|${PROJECT}|g" \
    -e "s|@DATE@|${DATE}|g" \
    -e "s|@YEAR@|${YEAR}|g" \
    -e "s|@MONTH@|${MONTH}|g" \
    -e "s|@DAY@|${DAY}|g" \
    -e "s|@HOUR@|${HOUR}|g" \
    -e "s|@MINUTE@|${MINUTE}|g" \
    -e "s|@SECOND@|${SECOND}|g" \
${SCRIPT_DIR}/login-in.svg > ${OUTPUT}
