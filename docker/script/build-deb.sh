#!/bin/sh

APP="$1"
DATA_DIR="$2"

if [ -z ${DATA_DIR} ]; then
  echo "Usage: $0 app data_dir"
  exit 127
fi

GITHUB="git@github.com:cmsi/ma-${APP}.git"
export DATA_DIR

echo "github: ${GITHUB}"
echo "target directory: ${TARGET_DIR}"

echo "building ${APP}..."
cd $HOME
rm -rf ma-${APP}
git clone ${GITHUB}
cd ma-${APP}
sh ./setup.sh
sh ./build.sh
