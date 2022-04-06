#!/bin/sh

DIRNAME="$1"
if test -z "$DIRNAME"; then
  echo "Usage: $0 dirname"
  exit 127
fi

if test -d "$DIRNAME"; then :; else
  echo "Error: $DIRNAME does not exist"
  exit 127
fi

if test -f "$DIRNAME".iso; then
  echo "Error: $DIRNAME.iso exists"
  exit 127
fi

(cd $DIRNAME && find . -name .DS_Store | xargs rm -f)
mkisofs -J -U -R -D -gid 0 -uid 0 -V "$DIRNAME" -o "$DIRNAME.iso" "$DIRNAME"
