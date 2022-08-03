TARGETS = buster/Dockerfile bullseye/Dockerfile bionic/Dockerfile focal/Dockerfile jammy/Dockerfile

default: $(TARGETS)

$(TARGETS): Makefile

buster/Dockerfile: skel/Dockerfile.in
	sed -e "s|@BASE_IMAGE@|debian:buster|g" -e "s|@VERSION@|buster|g" skel/Dockerfile.in > $@

bullseye/Dockerfile: skel/Dockerfile.in
	sed -e "s|@BASE_IMAGE@|debian:bullseye|g" -e "s|@VERSION@|bullseye|g" skel/Dockerfile.in > $@

bionic/Dockerfile: skel/Dockerfile.in
	sed -e "s|@BASE_IMAGE@|ubuntu:bionic|g" -e "s|@VERSION@|bionic|g" skel/Dockerfile.in > $@

focal/Dockerfile: skel/Dockerfile.in
	sed -e "s|@BASE_IMAGE@|ubuntu:focal|g" -e "s|@VERSION@|focal|g" skel/Dockerfile.in > $@

jammy/Dockerfile: skel/Dockerfile.in
	sed -e "s|@BASE_IMAGE@|ubuntu:jammy|g" -e "s|@VERSION@|jammy|g" skel/Dockerfile.in > $@
