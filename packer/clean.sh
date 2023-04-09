#!/bin/bash -eux

rm -f *.md5 *.json *.log
rm -rf output-virtualbox-iso packer_cache
rm -f *.ova

if [ -f .gitignore ]; then
  rm -f build-ce?.sh build-ma?.sh
  rm -f files/login-ce?.svg files/login-ma?.svg
else
  rm -f build*.sh preseed*.cfg
  rm -rf files script
fi
