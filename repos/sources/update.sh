#!/bin/sh

rm -f /etc/apt/trusted.gpg.d/materiapps.gpg /etc/apt/trusted.gpg.d/MateriApps_LIVE_Repository.gpg 
curl -fsSL https://exa.phys.s.u-tokyo.ac.jp/archive/MateriApps/keys/materiapps.gpg > /etc/apt/trusted.gpg.d/materiapps.gpg
chmod 644 /etc/apt/trusted.gpg.d/materiapps.gpg
apt-get update
apt-get -y install materiapps-keyring
