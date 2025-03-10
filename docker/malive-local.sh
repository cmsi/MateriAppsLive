#!/bin/sh

CONTAINER_BASE="malive-dev"
CONTAINER="malive-local"
CONTAINER_NAME="MateriApps LIVE!"

get_timezone () {
  TZ=$(basename $(dirname $(readlink /etc/localtime)))/$(basename $(readlink /etc/localtime))
}

# check docker daemon
RES=$(docker images > /dev/null 2>&1; echo $?)
if [ ${RES} = 0 ]; then :; else
  echo "Error: docker daemon is not running."
  exit 1
fi

COMMAND=
if [ -z ${COMMAND} ]; then
  BUILD_IMAGE=0
  # check installed versions
  RES=$(docker images --format "{{.Tag}}" ${CONTAINER} | /usr/bin/head -1)
  if [ -z ${RES} ]; then
    BUILD_IMAGE=1
    RES=$(docker images --format "{{.Tag}}" ${CONTAINER_BASE} | /usr/bin/head -1)
    if [ -z ${RES} ]; then
      echo "Error: base image ${CONTAINER_BASE} is not found."
      exit 1
    fi
    VERSION=${RES}
  else
    BUILD_IMAGE=0
    VERSION=${RES}
  fi
fi

echo "Starting ${CONTAINER_NAME} version ${VERSION}..."

# check X server
X_CONFIG=""
if [ -x /opt/X11/bin/xlsclients ]; then
  echo "Starting Xquartz..."
  xlsclients > /dev/null
  xhost + localhost > /dev/null
  X_CONFIG="--env DISPLAY=host.docker.internal:0"
elif [ -x /mnt/wslg ]; then
  echo "Using WSLg"
  X_CONFIG="--volume /tmp/.X11-unix:/tmp/.X11-unix --volume /mnt/wslg:/mnt/wslg \
    --env DISPLAY=${DISPLAY} --env WAYLAND_DISPLAY=${WAYLAND_DISPLAY} \
    --env XDG_RUNTIME_DIR=${XDG_RUNTIME_DIR} --env PULSE_SERVER=${PULSE_SERVER}"
  # Check for nVidia GPU
  if command -v nvidia-smi &> /dev/null; then
    echo "nVidia GPU available"
    GPU_CONFIG="--volume /usr/lib/wsl:/usr/lib/wsl --env LD_LIBRARY_PATH=/usr/lib/wsl/lib \
    		--device=/dev/dxg --device /dev/dri/card0 --device /dev/dri/renderD128 --gpus all"
  else
    GPU_CONFIG=""
  fi
else
  echo "Warning: X server not available"
fi

IMAGE="${CONTAINER}:${VERSION}"
DOCKER_USERNAME=user
DOCKER_HOME=/home/${DOCKER_USERNAME}
DOCKER_UID=$(id -u)
DOCKER_GID=$(id -g)
DOCKER_HOSTNAME="${CONTAINER}"

# build image
if [ "${BUILD_IMAGE}" = 1 ]; then
  BASE="${CONTAINER_BASE}:${VERSION}"
  get_timezone
  echo "Building building image ${IMAGE} from ${BASE}..."
  docker build -t ${IMAGE} - <<EOF
FROM ${BASE}
ARG USERNAME=${DOCKER_USERNAME}
ARG GROUPNAME=${DOCKER_USERNAME}
ARG UID=${DOCKER_UID}
ARG GID=${DOCKER_GID}
RUN groupadd -f -g \$GID \$GROUPNAME \
 && useradd -m -s /bin/bash -u \$UID -g \$GID -G sudo \$USERNAME \
 && echo \$USERNAME:live | chpasswd \
 && echo "\$USERNAME ALL=(ALL) ALL" >> /etc/sudoers \
 && ln -sf /usr/share/zoneinfo/${TZ} /etc/localtime \
 && sudo usermod -a -G audio,video \$USERNAME 
USER \$USERNAME
WORKDIR /home/\$USERNAME/
EOF
fi

IMAGE_ID=$(docker images --format "{{.ID}}" ${IMAGE})
echo "Docker image: ${IMAGE} (${IMAGE_ID})"

# start container
CONTAINER="${CONTAINER}-${VERSION}"
CONTAINER_ID=$(docker ps --all --filter "name=${CONTAINER}" --format "{{.ID}}")
if [ -z ${CONTAINER_ID} ]; then
  echo "Starting container ${CONTAINER}..."
  if [ -d "${HOME}/share" ]; then
    SHARE_CONFIG="--volume ${HOME}/share:${DOCKER_HOME}/share"
  fi
  docker run -it --detach-keys='ctrl-e,e' --name "${CONTAINER}" --hostname ${DOCKER_HOSTNAME} --volume ${CONTAINER}-vol:/home/user ${SHARE_CONFIG} ${X_CONFIG} ${GPU_CONFIG} --user ${DOCKER_UID}:${DOCKER_GID} --publish 8888:8888 ${IMAGE} /bin/bash
else
  echo "Docker container: ${CONTAINER} (${CONTAINER_ID})"
  docker restart ${CONTAINER_ID} > /dev/null
  docker attach --detach-keys='ctrl-e,e' ${CONTAINER_ID}
fi
