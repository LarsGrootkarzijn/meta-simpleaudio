DESCRIPTION = "Simpleaudio initramfs"
LICENSE = "CLOSED"

IMAGE_FSTYPES = "${INITRAMFS_FSTYPES}"

inherit core-image
inherit extrausers

IMAGE_INSTALL = " \
    busybox \
    base-files \
    simpleaudio-initramfs-init \
    dropbear \
    monkey \
"

#printf "%q" $(mkpasswd -m sha256crypt SambaPig)
ROOT_PASSWORD="\$5\$zd4n0aKOcAmpDc1M\$t6NtybMUpF5frpxXroo6XdDM9KOXTxFgmUxGWPUUWKA"

EXTRA_USERS_PARAMS = "\
usermod -p '${ROOT_PASSWORD}' root; \
"