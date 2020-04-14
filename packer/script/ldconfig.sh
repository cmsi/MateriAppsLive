#!/bin/sh

echo "==> Add /usr/local/lib to library search path"

echo "/usr/local/lib" > /etc/ld.so.conf.d/local.conf
ldconfig
