FROM alpine:3.6

RUN apk add --no-cache \
		coreutils \
		bc \
		xz \
		perl \
		curl \
		gcc \
		gnupg \
		linux-headers \
		make \
		musl-dev \
		openssl \
		openssl-dev \
		ncurses \
		ncurses-dev \
		tzdata

RUN (gpg --keyserver hkp://keys.gnupg.net --recv-keys 38DBBDC86092693E \
	|| gpg --keyserver ha.pool.sks-keyservers.net --recv-keys 38DBBDC86092693E \
	|| gpg --keyserver keyserver.pgp.com --recv-keys 38DBBDC86092693E)

ENV LINUX_VERSION 4.9.67

RUN set -ex; \
	tarball="linux-${LINUX_VERSION}.tar.xz"; \
	curl -fL -o linux.tar.sign "https://cdn.kernel.org/pub/linux/kernel/v4.x/linux-${LINUX_VERSION}.tar.sign"; \
	curl -fL -o linux.tar.xz "https://cdn.kernel.org/pub/linux/kernel/v4.x/linux-${LINUX_VERSION}.tar.xz"; \
	unxz linux.tar.xz; \
	gpg --verify linux.tar.sign; \
	mkdir -p /usr/src/linux; \
	tar -xf linux.tar -C /usr/src/linux --strip-components 1; \
	rm linux.tar linux.tar.sign

ADD config /usr/src/linux/.config

WORKDIR /usr/src/linux

RUN set -ex; make -j "$(nproc)" bzImage
