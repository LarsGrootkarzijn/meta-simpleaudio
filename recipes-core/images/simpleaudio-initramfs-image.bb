DESCRIPTION = "Minimal initramfs for BeagleBone"
LICENSE = "MIT"
IMAGE_FSTYPES = "${INITRAMFS_FSTYPES}"

inherit core-image

IMAGE_INSTALL = " \
    busybox \
    base-files \
    simpleaudio-initramfs-scripts \
    simpleaudio-initramfs-init \
"