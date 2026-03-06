SUMMARY = "RoomPlayer Plus Custom Image"
LICENSE = "MIT"

inherit image

WKS_FILE = "simpleaudio-image.wks"

IMAGE_INSTALL = " \
    kernel-modules \
" 

IMAGE_ROOTFS_SIZE = "3000000"

# Output image typ
IMAGE_FSTYPES = "wic.gz"