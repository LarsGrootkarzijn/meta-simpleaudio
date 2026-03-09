SUMMARY = "Roomplayer Custom Image"
LICENSE = "MIT"

inherit image

SRC_URI += "file://debian-${DEBIAN_RELEASE}-${MACHINE}.tar.gz"

WKS_FILE = "simpleaudio-image.wks"

IMAGE_LINGUAS = ""
IMAGE_FEATURES = ""
EXTRA_IMAGE_FEATURES = ""

IMAGE_INSTALL = " \
    kernel-modules \
    simpleaudio-gpio-tools \
    simpleaudio-dependencies \
"

PACKAGE_INSTALL = "${IMAGE_INSTALL}"

#Figure out real storage some day
IMAGE_ROOTFS_SIZE = "3500000"

IMAGE_FSTYPES = "wic.gz"

ROOTFS_PREPROCESS_COMMAND += "install_debian_overlay;"

install_debian_overlay () {
    tar --numeric-owner -xzf ${THISDIR}/files/debian-${DEBIAN_RELEASE}-${MACHINE}.tar.gz -C ${IMAGE_ROOTFS}
}