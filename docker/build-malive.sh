#!/bin/sh

SCRIPT_DIR=$(cd "$(dirname $0)"; pwd)
echo "SCRIPT_DIR=$SCRIPT_DIR"

. $SCRIPT_DIR/../version.sh
CODENAMES=${MA4_CODENAME}
VERSION=${MA4_VERSION}

echo "generating malive script..."
sed -e "s|@MA4_VERSION@|${MA4_VERSION}|g" \
      ${SCRIPT_DIR}/malive.in > malive
chmod +x malive

for c in ${CODENAMES}; do
  for v in ${DEBIAN_VERSIONS}; do
    if [ ${c} = $(echo ${v} | cut -d/ -f1) ]; then
      BASE=$(echo ${v} | cut -d/ -f2)
      IMAGE="malive/malive:${VERSION}"
      echo "building image ${IMAGE} from ${BASE}..."
      docker build -t ${IMAGE} - <<EOF
FROM ${BASE}
ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get -y upgrade \
 && apt-get -y install --no-install-recommends \
      sudo lsb-release \
      less vim \
      evince gnuplot-x11 \
      curl lftp wget \
      time tree zip bc xsel parallel \
      python3-pip python3-venv jupyter-notebook python3-numpy python3-scipy python3-matplotlib \
 && curl -L https://sourceforge.net/projects/materiappslive/files/Debian/sources/setup.sh/download | /bin/sh \
 && apt-get update \
 && echo "unalias ls" >> /etc/skel/.bashrc \
 && echo "export LIBGL_ALWAYS_INDIRECT=1" >> /etc/skel/.bashrc

RUN apt-get update \
 && apt-get -y install --no-install-recommends materiappslive \
        quantum-espresso quantum-espresso-data
EOF
    fi
  done
done
docker images
docker system df
