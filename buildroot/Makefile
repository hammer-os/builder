include ../hammer.mk

.PHONY: build build-amd64 build-arm run-amd64 run-arm clean

all: build

build: build-amd64 build-arm

build-amd64: Dockerfile buildroot-amd64.config busybox.config
	@docker build --tag hammer-os/buildroot-base:amd64-$(VERSION) \
		--build-arg HAMMER_ARCH=amd64 .

build-arm: Dockerfile buildroot-arm.config busybox.config
	@docker build --tag hammer-os/buildroot-base:arm-$(VERSION) \
		--build-arg HAMMER_ARCH=arm .

run-amd64:
	@docker run --interactive --tty --name buildroot-base-amd64 \
		--rm --volume $(CURDIR):/data \
		hammer-os/buildroot-base:amd64-$(VERSION) /bin/bash

run-arm:
	@docker run --interactive --tty --name buildroot-base-arm \
		--rm --volume $(CURDIR):/data \
		hammer-os/buildroot-base:arm-$(VERSION) /bin/bash

clean:
	@echo -n
