#!/bin/sh

NAMESPACE="malive"
CONTAINER="ceenv"
CONTAINER_DEV="ceenv-dev"
CONTAINER_NAME="ceenv"

get_version_list () {
  TAGS=$(/usr/bin/curl -s https://registry.hub.docker.com/v2/repositories/${NAMESPACE}/${CONTAINER}/tags | /usr/bin/sed 's/,/\'$'\n/g' | /usr/bin/grep \"name\": | /usr/bin/cut -d '"' -f 4 | /usr/bin/sort -r -V)
  CONTAINER_VERSIONS=
  for t in ${TAGS}; do
    if [ "$t" = latest ]; then :; else
      if [ -z "$CONTAINER_VERSIONS" ]; then
      	CONTAINER_VERSIONS="$t"
      else
      	CONTAINER_VERSIONS="$CONTAINER_VERSIONS $t"
      fi
    fi
  done
  CONTAINER_VERSION_LATEST=$(echo "$CONTAINER_VERSIONS" | /usr/bin/cut -d ' ' -f 1)

  TAGS=$(/usr/bin/curl -s https://registry.hub.docker.com/v2/repositories/${NAMESPACE}/${CONTAINER_DEV}/tags | /usr/bin/sed 's/,/\'$'\n/g' | /usr/bin/grep \"name\": | /usr/bin/cut -d '"' -f 4 | /usr/bin/sort -r -V)
  CONTAINER_DEV_VERSIONS=
  for t in ${TAGS}; do
    if [ "$t" = latest ]; then :; else
      if [ -z "${CONTAINER_DEV_VERSIONS}" ]; then
      	CONTAINER_DEV_VERSIONS="$t"
      else
      	CONTAINER_DEV_VERSIONS="$CONTAINER_DEV_VERSIONS $t"
      fi
    fi
  done
}

get_timezone () {
  TZ=$(basename $(dirname $(readlink /etc/localtime)))/$(basename "$(readlink /etc/localtime)")
}

# check docker daemon
RES=$(docker images > /dev/null 2>&1; echo $?)
if [ "$RES" = 0 ]; then :; else
  echo "Error: docker daemon is not running."
  exit 1
fi

COMMAND="$1"
if [ -z "$COMMAND" ]; then
  VERSION=
  CHECK_VERSION=0
  BUILD_IMAGE=0
  DEV=0
  # check installed versions
  RES=$(docker images --format "{{.Tag}}" ${CONTAINER} | /usr/bin/head -1)
  if [ -z "$RES" ]; then
    CHECK_VERSION=1
    BUILD_IMAGE=1
  else
    VERSION="$RES"
  fi
  # check version list
  if [ ${CHECK_VERSION} = 1 ]; then
    get_version_list
    if [ ${BUILD_IMAGE} = 1 ]; then
       VERSION=${CONTAINER_VERSION_LATEST}
    fi
  fi
else
  if [ "$COMMAND" = remove ]; then
    VERSION="$2"
    if [ -z "$VERSION" ]; then
      echo "Error: $0 remove VERSION"
      exit 1
    fi
    get_version_list
    VERSION_CHECKED=0
    for v in ${CONTAINER_VERSIONS} ${CONTAINER_DEV_VERSIONS}; do
      if [ "$VERSION" = "$v" ]; then
        VERSION_CHECKED=1
        break
      fi
    done
    if [ "$VERSION_CHECKED" = 1 ]; then :;
    else
      echo "Error: version ${VERSION} is not found."
      exit 1
    fi
    printf "Really want to remove %s version %s? (y/N): " "${CONTAINER_NAME}" "${VERSION}"
    read -r yn
    case "$yn" in [yY]*)
      printf "Removing %s version %s..." "$CONTAINER_NAME" "$VERSION"
      IMAGE="${CONTAINER}:${VERSION}"
      CONTAINER="${CONTAINER}-${VERSION}"
      docker stop "$CONTAINER" > /dev/null
      docker rm "$CONTAINER" > /dev/null
      docker rmi "$IMAGE" > /dev/null
      exit 0;;
    *)
      exit 0;;
    esac
  elif [ "$COMMAND" = update ]; then
    get_version_list
    VERSION=$(docker images --format "{{.Tag}}" ${CONTAINER} | /usr/bin/head -1)
    if [ -z "${VERSION}" ]; then :;
    else
      echo "Latest version: ${CONTAINER_VERSION_LATEST}"
      echo "Installed version: ${VERSION}"
      if [ "$VERSION" = "$CONTAINER_VERSION_LATEST" ]; then :; else
        printf "Really want to update to %s version %s? (y/N): " "$CONTAINER_NAME" "$CONTAINER_VERSION_LATEST"
        read -r yn
        case "$yn" in [yY]*)
          echo "Removing ${CONTAINER_NAME} version ${VERSION}..."
          IMAGE="${CONTAINER}:${VERSION}"
          CONTAINER="${CONTAINER}-${VERSION}"
          docker stop "$CONTAINER" > /dev/null
          docker rm "$CONTAINER" > /dev/null
          docker rmi "$IMAGE" > /dev/null;;
        *)
          exit 0;;
        esac
      fi
    fi
  elif [ "$COMMAND" = list ]; then
    get_version_list
    echo "Available versions: ${CONTAINER_VERSIONS}"
    echo "Available beta versions: ${CONTAINER_DEV_VERSIONS}"
    VERSIONS=$(docker images --format "{{.Tag}}" ${CONTAINER})
    VERSION_LIST=
    for v in ${VERSIONS}; do
      if [ -z "${VERSION_LIST}" ]; then
      	VERSION_LIST="${v}"
      else
      	VERSION_LIST="${VERSION_LIST} ${v}"
      fi
    done
    echo "Installed versions: ${VERSION_LIST}"
    exit 0
  elif [ "$COMMAND" = version ]; then
    VERSION="$2"
    if [ -z "$VERSION" ]; then
      echo "Error: $0 version VERSION"
      exit 1
    fi
    get_version_list
    VERSION_CHECKED=0
    DEV=0
    for v in ${CONTAINER_VERSIONS}; do
      if [ "$VERSION" = "$v" ]; then
        VERSION_CHECKED=1
        break
      fi
    done
    for v in ${CONTAINER_DEV_VERSIONS}; do
      if [ "$VERSION" = "$v" ]; then
        VERSION_CHECKED=1
        DEV=1
        break
      fi
    done
    if [ "$VERSION_CHECKED" = 1 ]; then :;
    else
      echo "Error: version ${VERSION} is not available."
      exit 1
    fi
    BUILD_IMAGE=1
  else
    echo "Error: $0 [remove | list | update | version]"
    exit 1
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
  RES=$(nvidia-smi > /dev/null 2>&1; echo $?)
  if [ "$RES" = 0 ]; then
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
DOCKER_HOME="/home/$DOCKER_USERNAME"
DOCKER_UID=$(id -u)
DOCKER_GID=$(id -g)
DOCKER_HOSTNAME="$CONTAINER"

# build image
if [ "$BUILD_IMAGE" = 1 ]; then
  BASE="${NAMESPACE}/${CONTAINER}:${VERSION}"
  if [ "$DEV" = 1 ]; then
    BASE="${NAMESPACE}/${CONTAINER_DEV}:${VERSION}"
  fi
  get_timezone
  echo "Building building image ${IMAGE} from ${BASE}..."
  docker build -t "$IMAGE" - <<EOF
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
  docker run -it --detach-keys='ctrl-e,e' --name "$CONTAINER" --hostname "$DOCKER_HOSTNAME" --volume "$CONTAINER"-vol:/home/user ${SHARE_CONFIG} ${X_CONFIG} ${GPU_CONFIG} --user "$DOCKER_UID":"$DOCKER_GID" --publish 8888:8888 "$IMAGE" /bin/bash
else
  echo "Docker container: $CONTAINER ($CONTAINER_ID)"
  docker restart "$CONTAINER_ID" > /dev/null
  docker attach --detach-keys='ctrl-e,e' "$CONTAINER_ID"
fi
