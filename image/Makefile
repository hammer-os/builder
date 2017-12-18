.PHONY: build run clean

all: build

build:
	docker build --tag hammer:image --file Dockerfile .

run:
	docker run --rm -it --name image-builder \
			--volume $(CURDIR):/data \
		hammer:image /bin/sh

clean:
	@echo -n
