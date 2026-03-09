DESCRIPTION = "Simpleaudio initramfs"
LICENSE = "CLOSED"

IMAGE_FSTYPES = "${INITRAMFS_FSTYPES}"

inherit core-image

IMAGE_INSTALL = " \
    busybox \
    base-files \
    simpleaudio-initramfs-init \
"