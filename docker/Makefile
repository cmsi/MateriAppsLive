TARGETS = stretch/Dockerfile buster/Dockerfile bullseye/Dockerfile bionic/Dockerfile focal/Dockerfile 

default: $(TARGETS)

stretch/Dockerfile: skel/Dockerfile.in
	echo "FROM debian:9" > $@
	cat skel/Dockerfile.in >> $@

buster/Dockerfile: skel/Dockerfile.in
	echo "FROM debian:10" > $@
	cat skel/Dockerfile.in >> $@

bullseye/Dockerfile: skel/Dockerfile.in
	echo "FROM debian:11" > $@
	cat skel/Dockerfile.in >> $@

bionic/Dockerfile: skel/Dockerfile.in
	echo "FROM ubuntu:18.04" > $@
	cat skel/Dockerfile.in >> $@

focal/Dockerfile: skel/Dockerfile.in
	echo "FROM ubuntu:20.04" > $@
	cat skel/Dockerfile.in >> $@
