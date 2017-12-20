.PHONY: build run clean

all: build

build: Dockerfile buildroot.config busybox.config
	docker build --tag hammer:buildroot --file Dockerfile .

run:
	docker run --rm -it --name buildroot-builder \
			--volume $(CURDIR):/data \
		hammer:buildroot /bin/bash

clean:
	@echo -n
