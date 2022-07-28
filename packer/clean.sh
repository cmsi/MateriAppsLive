#!/bin/bash -eux

rm -f *.iso *.json *.log *.md5
rm -rf output-virtualbox-iso packer_cache
rm -f *.ova

if [ -f .gitignore ]; then
  rm -f build-ce3.sh build-ma3.sh
  files/login-ce3.svg files/login-ma3.svg
else
  rm -f build*.sh preseed*.cfg
  rm -rf files script
fi
