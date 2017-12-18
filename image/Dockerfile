FROM hammer:busybox
FROM hammer:kernel

FROM alpine:3.6

RUN apk add --no-cache \
		xz \
		xorriso

RUN set -ex; mkdir -p /usr/src/image/rootfs
WORKDIR /usr/src/image/rootfs

COPY --from=0 /usr/src/busybox/hammer/rootfs .
COPY etc etc
COPY init init
RUN chmod 755 init

RUN set -ex; \
	mkdir -p dev mnt proc root run sys tmp usr var; \
	find . | cpio -R root:root -H newc -o | \
	xz -9 --check=none > /usr/src/image/rootfs.xz; \
	rm -r /usr/src/image/rootfs

#COPY rootfs.xz /usr/src/image/

WORKDIR /usr/src/image

COPY --from=1 /usr/src/linux/arch/x86/boot/bzImage kernel.xz

COPY syslinux.cfg .
COPY isolinux.bin .
COPY ldlinux.c32 .

RUN xorriso \
	-as mkisofs \
	-R \
	-r \
	-o /hammer-os.iso \
	-b isolinux.bin \
	-c boot.cat \
	-input-charset UTF-8 \
	-no-emul-boot \
	-boot-load-size 4 \
	-boot-info-table \
	/usr/src/image
