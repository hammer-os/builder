.PHONY: build build-amd64 build-arm clean

all: build

build: build-amd64 build-arm

build-amd64:
	@make -C builroot build-amd64
	@make -C image build-amd64

build-arm:
	@make -C builroot build-arm
	@make -C image build-arm

clean:
	@make -C buildroot clean
	@make -C image clean
