FROM debian:stretch-slim

ARG BUILDROOT_STABLE_VERSION=2017.11
ARG BUILDROOT_STABLE_PACKAGE=buildroot-${BUILDROOT_STABLE_VERSION}.tar.bz2

#ARG BUILDROOT_LTS_VERSION=2017.02.8
#ARG BUILDROOT_LTS_PACKAGE=buildroot-${BUILDROOT_LTS_VERSION}.tar.bz2

ARG HAMMER_ARCH

RUN apt-get update && apt-get install -y --no-install-suggests \
		build-essential \
		binutils \
		libncurses5-dev \
		git \
		wget \
		curl \
		bc \
		cpio \
		python \
		rsync \
		unzip \
    && rm -rf /var/lib/apt/lists/*

RUN (gpg --keyserver ha.pool.sks-keyservers.net --recv-keys AB07D806D2CE741FB886EE50B025BA8B59C36319 \
	|| gpg --keyserver pgp.mit.edu --recv-keys AB07D806D2CE741FB886EE50B025BA8B59C36319 \
	|| gpg --keyserver keyserver.pgp.com --recv-keys AB07D806D2CE741FB886EE50B025BA8B59C36319)

RUN set -ex; \
	tarball=${BUILDROOT_STABLE_PACKAGE}; \
	curl -fL -o buildroot.tar.bz2.sign "https://buildroot.net/downloads/$tarball.sign"; \
	curl -fL -o buildroot.tar.bz2 "https://buildroot.net/downloads/$tarball"; \
	gpg --batch --decrypt --output buildroot.tar.bz2.txt buildroot.tar.bz2.sign; \
	awk '$1 == "SHA1:" && $2 ~ /^[0-9a-f]+$/ && $3 == "'"$tarball"'" {print $2, "*buildroot.tar.bz2"}' \
		buildroot.tar.bz2.txt > buildroot.tar.bz2.sha1; \
	test -s buildroot.tar.bz2.sha1; \
	sha1sum -c buildroot.tar.bz2.sha1; \
	mkdir -p /usr/src/buildroot; \
	tar -xf buildroot.tar.bz2 -C /usr/src/buildroot --strip-components 1; \
	rm buildroot.tar.bz2*

RUN mkdir -p /usr/src/buildroot/board/hammer-os/${HAMMER_ARCH}

COPY buildroot-${HAMMER_ARCH}.config /usr/src/buildroot/.config
COPY busybox.config /usr/src/buildroot/package/busybox/custom.config
COPY kernel-${HAMMER_ARCH}.config /usr/src/buildroot/board/hammer-os/${HAMMER_ARCH}/.config

WORKDIR /usr/src/buildroot

RUN make source

RUN make toolchain
