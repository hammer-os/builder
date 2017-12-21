include ../hammer.mk

.PHONY: build build-amd64 build-arm run-amd64 run-arm clean

all: build

build: build-amd64 build-arm

build-amd64: Dockerfile.amd64
	@docker build --tag hammer-os/buildroot-image:amd64-$(VERSION) \
		--build-arg HAMMER_ARCH=amd64 --file Dockerfile.amd64 .

build-arm: Dockerfile.arm
	@docker build --tag hammer-os/buildroot-image:arm-$(VERSION) \
		--build-arg HAMMER_ARCH=arm --file Dockerfile.arm .

run-amd64:
	@docker run --interactive --tty --name buildroot-image-amd64 \
		--rm --volume $(CURDIR):/data \
		hammer-os/buildroot-image:amd64-$(VERSION) /bin/bash

run-arm:
	@docker run --interactive --tty --name buildroot-image-arm \
		--rm --volume $(CURDIR):/data \
		hammer-os/buildroot-image:arm-$(VERSION) /bin/bash

clean:
	@echo -n
