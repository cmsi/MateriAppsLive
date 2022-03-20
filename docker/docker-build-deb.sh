#!/bin/sh

APP="$1"
VERSIONS="$2"

if [ -z ${MALIVE_DATA_DIR} ]; then
  echo "Error: environment variable MALIVE_DATA_DIR not defined"
  exit 127
fi

if [ -z ${APP} ]; then
  echo "Usage: $0 app [version]"
  exit 127
fi

if [ -z ${VERSIONS} ]; then
  VERSIONS="bullseye buster stretch jammy focal bionic"
fi

if [ -d "${HOME}/.ssh-docker" ]; then
  SSH_CONFIG="-v ${HOME}/.ssh-docker:/root/.ssh:ro"
elif [ -d "${HOME}/.ssh" ]; then
  SSH_CONFIG="-v ${HOME}/.ssh:/root/.ssh:ro"
fi

if [ -d "${HOME}/share" ]; then
  SHARE_CONFIG="-v ${HOME}/share:/mnt/share"
fi

if [ -d "${HOME}/.config/git" ]; then
  GIT_CONFIG="-v ${HOME}/.config/git:/root/.config/git:ro"
elif [ -f "${HOME}/.gitconfig" ]; then
  GIT_CONFIG="-v ${HOME}/.gitconfig:/root/.gitconfig:ro"
fi

for v in ${VERSIONS}; do
  echo "building ${APP} for ${v}..."
  IMAGE="malive/${v}"
  set -x
  docker run --rm --name ${v}.$$ ${SSH_CONFIG} ${SHARE_CONFIG} ${GIT_CONFIG} ${IMAGE} /bin/bash /root/build-deb.sh ${APP} ${MALIVE_DATA_DIR}
  set +x
done
