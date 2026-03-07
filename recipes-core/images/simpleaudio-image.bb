SUMMARY = "Roomplayer Custom Image"
LICENSE = "MIT"

inherit image

SPDX_OUTPUT = "0"
INSANE_SKIP_${PN} += "spdx"

WKS_FILE = "simpleaudio-image.wks"

IMAGE_INSTALL = " \
    kernel-modules \
    simpleaudio-dependencies \
"

INSANE_SKIP_${PN} += "spdx"

IMAGE_ROOTFS_SIZE = "3000000"

# Output image typ
IMAGE_FSTYPES = "wic.gz"