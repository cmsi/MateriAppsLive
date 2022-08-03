FROM ubuntu:jammy
LABEL maintainer="Synge Todo"
ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && \
  apt-get install -y build-essential vim wget cdbs devscripts quilt git cmake && \
  wget -O /etc/apt/sources.list.d/materiapps-jammy.list http://jaist.dl.sourceforge.net/project/materiappslive/Debian/sources/materiapps-jammy.list && \
  apt-get -o Acquire::AllowInsecureRepositories=true update && \
  apt-get -y --allow-unauthenticated install materiapps-keyring && \
  apt-get update && \
  apt-get -y upgrade

RUN apt-get install -y gfortran mpi-default-dev liblapack-dev

COPY script/build-deb.sh /root/
COPY script/.quiltrc /root/
