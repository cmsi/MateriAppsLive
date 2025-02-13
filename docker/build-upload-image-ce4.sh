#!/bin/sh

PROJECT="ceenv"

SCRIPT_DIR=$(cd "$(dirname "$0")" || exit; pwd)
echo "SCRIPT_DIR=$SCRIPT_DIR"

. "$SCRIPT_DIR"/../config/version.sh
. "$SCRIPT_DIR"/../config/package.sh

CODENAMES=${CE4_CODENAME}
VERSION=${CE4_VERSION}
LOG=build-upload-image-ce4.log

DEV=0
case "$VERSION" in
  *a*) DEV=1 ;;
  *b*) DEV=1 ;;
esac

docker login 2>&1 | tee -a ${LOG}
docker buildx create --use --name multi-arch 2>&1 | tee -a ${LOG}
docker buildx inspect --builder multi-arch --bootstrap 2>&1 | tee -a ${LOG}

for c in ${CODENAMES}; do
  for v in ${DEBIAN_VERSIONS}; do
    if [ ${c} = $(echo "${v}" | cut -d/ -f1) ]; then
      BASE=$(echo ${v} | cut -d/ -f2)
      TARGET="-t malive/${PROJECT}:${VERSION} -t malive/${PROJECT}:latest"
      if [ ${DEV} -eq 1 ]; then
        TARGET="-t malive/${PROJECT}-dev:${VERSION}"
      fi
      echo "building and uploading ${PROJECT} images version ${VERSION} from ${BASE}..." 2>&1 | tee -a ${LOG}
      docker buildx build --platform linux/amd64,linux/arm64 --push ${TARGET} - <<EOF 2>&1 | tee -a ${LOG}
FROM ${BASE}
ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update -qq \
 && apt-get -y upgrade \
 && apt-get -y install --no-install-recommends ${PACKAGES_DEVELOPMENT} ${PACKAGES_PYTHON} \
 \
 && curl -L https://exa.phys.s.u-tokyo.ac.jp/archive/MateriApps/apt/setup.sh | /bin/sh \
 && apt-get update -qq \
 && apt-get -y install --no-install-recommends ceenv \
 \
 && echo "export PATH=\$HOME/bin:\$PATH" >> /etc/skel/.bashrc \
 && echo "export OMP_NUM_THREADS=1" >> /etc/skel/.bashrc \
 && echo "export OMPI_MCA_btl_vader_single_copy_mechanism=none" >> /etc/skel/.bashrc \
 && echo "export LIBGL_ALWAYS_INDIRECT=1" >> /etc/skel/.bashrc \
 && echo "unalias ls" >> /etc/skel/.bashrc \
 \
 && echo "syntax off" > /etc/skel/.vimrc \
 && mkdir -p /etc/skel/.emacs.d \
 && echo "(setq inhibit-startup-screen t)" > /etc/skel/.emacs.d/init.el \
 && echo "(setq default-frame-alist '((height . 24)))" >> /etc/skel/.emacs.d/init.el \
 && echo ${VERSION} > /etc/${PROJECT}_version
EOF
    fi
  done
done
docker images 2>&1 | tee -a ${LOG}
docker system df 2>&1 | tee -a ${LOG}
