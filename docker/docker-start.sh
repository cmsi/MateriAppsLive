#!/bin/sh

VERSION="$1"

if [ -z ${VERSION} ]; then
  echo "Usage: $0 version"
  exit 127
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

echo "starting ${VERSION}"
IMAGE="malive/${VERSION}"
set -x
docker run -it -d --name $VERSION ${SSH_CONFIG} ${SHARE_CONFIG} ${GIT_CONFIG} malive/${VERSION}
