.PHONY: build run clean

all: build

build:
	docker build --tag hammer:kernel --file Dockerfile .

#	docker run --rm --name kernel-extractor \
#			--volume $(CURDIR):/data \
#			hammer:kernel \
#		cp arch/x86/boot/bzImage /data/kernel.xz

run:
	docker run --rm -it --name kernel-builder \
			--volume $(CURDIR):/data \
		hammer:kernel /bin/sh

clean:
	rm -f kernel.xz
