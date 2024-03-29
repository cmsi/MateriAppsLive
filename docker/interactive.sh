#!/bin/sh

SCRIPT_DIR=$(cd "$(dirname $0)"; pwd)

CODENAME="$1"
if [ -z ${CODENAME} ]; then
  CODENAME="bullseye"
fi

D_USERNAME=$(id -un)
D_HOME=/home/${D_USERNAME}

if [ -d "${HOME}/.ssh-docker" ]; then
  SSH_CONFIG="-v ${HOME}/.ssh-docker:${D_HOME}/.ssh:ro"
elif [ -d "${HOME}/.ssh" ]; then
  SSH_CONFIG="-v ${HOME}/.ssh:${D_HOME}/.ssh:ro"
fi

if [ -d "${HOME}/share" ]; then
  SHARE_CONFIG="-v ${HOME}/share:${D_HOME}/share"
fi

if [ -d "${HOME}/development/ma" ]; then
  DEV_CONFIG="-v ${HOME}/development/ma:${D_HOME}/development/ma"
fi

if [ -d "${HOME}/.config/git" ]; then
  GIT_CONFIG="-v ${HOME}/.config/git:${D_HOME}/.config/git:ro"
elif [ -f "${HOME}/.gitconfig" ]; then
  GIT_CONFIG="-v ${HOME}/.gitconfig:${D_HOME}/.gitconfig:ro"
fi

if [ -f "${SCRIPT_DIR}/dot.quiltrc" ]; then
  QUILT_CONFIG="-v ${SCRIPT_DIR}/dot.quiltrc:${D_HOME}/.quiltrc:ro"
fi

if [ -n "${MALIVE_DATA_DIR}" ]; then
  DATA_CONFIG="-e DATA_DIR=${MALIVE_DATA_DIR}"
fi

echo "starting ${CODENAME}"
IMAGE="madev/${CODENAME}"
ID_U=$(id -u)
ID_G=$(id -g)
set -x
docker run --rm -it --name $CODENAME.$$ --user ${ID_U}:${ID_G} -e DISPLAY=host.docker.internal:0 -v madev-vol:${D_HOME} ${DATA_CONFIG} ${SSH_CONFIG} ${SHARE_CONFIG} ${DEV_CONFIG} ${GIT_CONFIG} ${QUILT_CONFIG} madev/${CODENAME} /bin/bash
