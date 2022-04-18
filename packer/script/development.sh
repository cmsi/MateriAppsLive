#!/bin/bash -eux

echo "==> Install Editors"
apt-get -y install --no-install-recommends emacs vim mousepad

echo "==> Install Graphics Tools"
apt-get -y install --no-install-recommends evince gnuplot-x11
# apt-get -y install gifsicle graphviz imagemagick python-pygraphviz

echo "==> Install Network Tools"
apt-get -y install --no-install-recommends curl lftp wget

echo "==> Install Development Tools"
apt-get -y install --no-install-recommends gfortran cmake git liblapack-dev libopenblas-dev mpi-default-dev numactl

echo "==> Install Other Tools"
apt-get -y install --no-install-recommends enscript time tree zip bc xsel parallel
