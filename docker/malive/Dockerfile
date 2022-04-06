FROM debian:11.2
LABEL maintainer="Synge Todo"
ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && \
  apt-get install -y vim wget && \
  wget -O /etc/apt/sources.list.d/materiapps-bullseye.list http://jaist.dl.sourceforge.net/project/materiappslive/Debian/sources/materiapps-bullseye.list && \
  apt-get -o Acquire::AllowInsecureRepositories=true update && \
  apt-get -y --allow-unauthenticated install materiapps-keyring && \
  apt-get update && \
  apt-get -y upgrade

RUN apt-get install -y hphi gnuplot
