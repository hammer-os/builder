.PHONY: build run clean

all: build

build:
	docker build --tag hammer:busybox --file Dockerfile .

#	docker run --rm --name busybox-extractor hammer:busybox \
#		tar cC ./hammer/rootfs . | xz -z9 > busybox.tar.xz

run:
	docker run --rm -it --name busybox-builder \
			--volume $(CURDIR):/data \
		hammer:busybox /bin/sh

clean:
	rm -f busybox.tar.xz
