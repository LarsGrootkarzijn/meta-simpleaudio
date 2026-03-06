# meta-simpleaudio/recipes-kernel/linux/linux-ti-staging_%.bbappend

FILESEXTRAPATHS:prepend := "${THISDIR}/files:"
PACKAGE_ARCH = "${MACHINE_ARCH}"

# DTS en kernel config fragment
SRC_URI += " \
    file://configs/am335x-roomplayer-plus.cfg \
    file://device-trees/am335x-roomplayer-plus.dts \
    file://patches/0001-add-roomplayer-plus-dts.patch \
    file://patches/0002-davinci-mcasp-clock.patch \
"

KERNEL_CONFIG_FRAGMENTS += "${WORKDIR}/configs/am335x-roomplayer-plus.cfg"
KERNEL_FEATURES += "initramfs"
INITRAMFS_IMAGE = "simpleaudio-initramfs-image"
INITRAMFS_IMAGE_NAME = "simpleaudio-initramfs-image-roomplayer-plus.rootfs"

KERNEL_IMAGETYPE = "uImage"

do_configure:append(){
    cp ${WORKDIR}/*.dts ${S}/arch/arm/boot/dts/ti/omap
}

do_deploy:append() {
    if [ -f ${DEPLOYDIR}/uImage ]; then
        cat ${DEPLOYDIR}/uImage \
            ${DEPLOYDIR}/am335x-roomplayer-plus.dtb \
            > ${DEPLOYDIR}/uImage-roomplayer-plus
    fi

    if [ -f ${DEPLOYDIR}/uImage-initramfs-roomplayer-plus.bin ]; then
        cat ${DEPLOYDIR}/uImage-initramfs-roomplayer-plus.bin \
            ${DEPLOYDIR}/am335x-roomplayer-plus.dtb \
            > ${DEPLOYDIR}/uImage-initramfs-roomplayer-plus
    fi
}