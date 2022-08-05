#!/bin/bash -eux

rm -f *.md5 *.json *.log
rm -rf output-virtualbox-iso packer_cache
rm -f *.ova

if [ -f .gitignore ]; then
  rm -f build-ce3.sh build-ma3.sh
  rm -f files/login-ce3.svg files/login-ma3.svg
else
  rm -f build*.sh preseed*.cfg
  rm -rf files script
fi
