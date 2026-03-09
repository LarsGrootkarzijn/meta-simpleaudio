LICENSE = "CLOSED"

FILESEXTRAPATHS:prepend := "${THISDIR}/files:"
PACKAGE_ARCH = "${MACHINE_ARCH}"

DEPENDS += "u-boot-tools-native"

MACHINE_NAME = "${MACHINE}"

SRC_URI += " \
    file://configs/${MACHINE_NAME}.cfg \
    file://device-trees/${MACHINE_NAME}.dts \
    file://patches/0001-add-${MACHINE_NAME}-dts.patch \
    file://patches/0002-davinci-mcasp-clock.patch \
"

KERNEL_CONFIG_FRAGMENTS += "${WORKDIR}/configs/${MACHINE_NAME}.cfg"
KERNEL_FEATURES += "initramfs"
INITRAMFS_IMAGE = "simpleaudio-initramfs-image"
INITRAMFS_IMAGE_NAME = "simpleaudio-initramfs-image-${MACHINE_NAME}.rootfs"

KERNEL_IMAGETYPE = "uImage"

do_configure:append(){
    cp ${WORKDIR}/device-trees/${MACHINE_NAME}.dts ${S}/arch/arm/boot/dts/ti/omap
}

do_deploy:append(){
    if [ -f ${DEPLOYDIR}/uImage ]; then
        cat ${DEPLOYDIR}/uImage \
            ${DEPLOYDIR}/${MACHINE_NAME}.dtb \
            > ${DEPLOYDIR}/uImage-${MACHINE_NAME}
    fi

    if [ -f ${DEPLOYDIR}/uImage-initramfs-${MACHINE_NAME}.bin ]; then
        cat ${DEPLOYDIR}/uImage-initramfs-${MACHINE_NAME}.bin \
            ${DEPLOYDIR}/${MACHINE_NAME}.dtb \
            > ${DEPLOYDIR}/uImage-initramfs-${MACHINE_NAME}
    fi
}