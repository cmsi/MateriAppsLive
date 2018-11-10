#!/bin/bash -eux

echo "==> Install Editors"
apt-get -y install emacs vim

echo "==> Install Graphics Tools"
apt-get -y install dx evince gnuplot-x11 paraview pymol rasmol vesta vmd-setup xcrysden
# apt-get -y install gifsicle graphviz imagemagick python-pygraphviz

echo "==> Install Network Tools"
apt-get -y install curl lftp wget

echo "==> Install Development Tools"
apt-get -y install cmake git h5utils liblapack-dev libopenblas-dev mpi-default-dev numactl

echo "==> Install Other Tools"
apt-get -y install enscript time tree

echo "==> Install MateriApps Applications/Tools"
apt-get -y install materiappslive
apt-get -y install bsa c-tools ermod quantum-espresso quantum-espresso-data feram fermisurfer hphi lammps mvmc respack smash xtapp xtapp-ps xtapp-util
apt-get -y install akaikkr alps-applications alps-tutorials
apt-get -y install gromacs gromacs-data gromacs-openmpi
apt-get -y install openmx openmx-data openmx-example
apt-get -y install dsqss
apt-get -y install gamess-setup
apt-get -y install tapioca
apt-get -y install triqs triqs-cthyb triqs-dfttools triqs-hubbardi dcore
apt-get -y install ddmrg
apt-get -y install salmon

echo "==> Copy desktop file(s)"
if [ -d /etc/skel/Desktop ]; then
  cp -frp /etc/skel/Desktop $HOME
fi
if [ -d /etc/skel/.config ]; then
  cp -frp /etc/skel/.config $HOME
fi
