#!/bin/sh

ROOT=https://exa.phys.s.u-tokyo.ac.jp/archive/MateriApps/apt
DEBIAN=$(lsb_release -c -s)
ARCH=$(dpkg --print-architecture)

rm -f /etc/apt/trusted.gpg.d/materiapps.gpg /etc/apt/trusted.gpg.d/MateriApps_LIVE_Repository.gpg 

cat << EOF > /etc/apt/sources.list.d/materiapps.list
# for MateriApps LIVE!
deb [arch=${ARCH} signed-by=/etc/apt/keyrings/materiapps.gpg] ${ROOT}/${DEBIAN} ${DEBIAN} main non-free contrib
deb-src [arch=${ARCH} signed-by=/etc/apt/keyrings/materiapps.gpg] ${ROOT}/${DEBIAN} ${DEBIAN} main non-free contrib
EOF
chmod 644 /etc/apt/sources.list.d/materiapps.list

curl -fksSL ${ROOT}/materiapps.gpg > /etc/apt/keyrings/materiapps.gpg
chmod 644 /etc/apt/keyrings/materiapps.gpg
