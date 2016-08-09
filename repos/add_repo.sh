#!/bin/sh

CODENAME=$(lsb_release -s -c)
set -x
reprepro --ask-passphrase -Vb /data/apt/$CODENAME include $CODENAME $1
