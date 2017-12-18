FROM alpine:3.6

RUN apk add --no-cache \
		coreutils \
		bzip2 \
		xz \
		curl \
		gcc \
		gnupg \
		linux-headers \
		make \
		musl-dev \
		ncurses \
		ncurses-dev \
		tzdata

RUN (gpg --keyserver ha.pool.sks-keyservers.net --recv-keys C9E9416F76E610DBD09D040F47B70C55ACC9965B \
	|| gpg --keyserver pgp.mit.edu --recv-keys C9E9416F76E610DBD09D040F47B70C55ACC9965B \
	|| gpg --keyserver keyserver.pgp.com --recv-keys C9E9416F76E610DBD09D040F47B70C55ACC9965B)

ENV BUSYBOX_VERSION 1.27.2

RUN set -ex; \
	tarball="busybox-${BUSYBOX_VERSION}.tar.bz2"; \
	curl -fL -o busybox.tar.bz2 "https://busybox.net/downloads/$tarball"; \
	curl -fL -o busybox.tar.bz2.sign "https://busybox.net/downloads/$tarball.sign"; \
	gpg --batch --decrypt --output busybox.tar.bz2.txt busybox.tar.bz2.sign; \
	awk '$1 == "SHA1:" && $2 ~ /^[0-9a-f]+$/ && $3 == "'"$tarball"'" { print $2, "*busybox.tar.bz2" }' \
		busybox.tar.bz2.txt > busybox.tar.bz2.sha1; \
	test -s busybox.tar.bz2.sha1; \
	sha1sum -c busybox.tar.bz2.sha1; \
	mkdir -p /usr/src/busybox; \
	tar -xf busybox.tar.bz2 -C /usr/src/busybox --strip-components 1; \
	rm busybox.tar.bz2*

ADD config /usr/src/busybox/.config

WORKDIR /usr/src/busybox

# https://www.mail-archive.com/toybox@lists.landley.net/msg02528.html
# https://www.mail-archive.com/toybox@lists.landley.net/msg02526.html
RUN sed -i 's/^struct kconf_id \*$/static &/g' scripts/kconfig/zconf.hash.c_shipped

RUN set -ex; \
	make -j "$(nproc)" busybox; \
	make -j "$(nproc)" install
