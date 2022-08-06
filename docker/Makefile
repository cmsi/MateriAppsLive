TARGETS = buster/Dockerfile bullseye/Dockerfile bionic/Dockerfile focal/Dockerfile jammy/Dockerfile

BUSTER_VERSION = 10.12
BULLSEYE_VERSION = 11.4
BIONIC_VERSION = 18.04
FOCAL_VERSION = 20.04
JAMMY_VERSION = 22.04

default: $(TARGETS)

$(TARGETS): Makefile

buster/Dockerfile: skel/Dockerfile.in
	sed -e "s|@BASE_IMAGE@|debian:$(BUSTER_VERSION)|g" -e "s|@VERSION@|buster|g" skel/Dockerfile.in > $@

bullseye/Dockerfile: skel/Dockerfile.in
	sed -e "s|@BASE_IMAGE@|debian:$(BULLSEYE_VERSION)|g" -e "s|@VERSION@|bullseye|g" skel/Dockerfile.in > $@

bionic/Dockerfile: skel/Dockerfile.in
	sed -e "s|@BASE_IMAGE@|ubuntu:$(BIONIC_VERSION)|g" -e "s|@VERSION@|bionic|g" skel/Dockerfile.in > $@

focal/Dockerfile: skel/Dockerfile.in
	sed -e "s|@BASE_IMAGE@|ubuntu:$(FOCAL_VERSION)|g" -e "s|@VERSION@|focal|g" skel/Dockerfile.in > $@

jammy/Dockerfile: skel/Dockerfile.in
	sed -e "s|@BASE_IMAGE@|ubuntu:$(JAMMY_VERSION)|g" -e "s|@VERSION@|jammy|g" skel/Dockerfile.in > $@
