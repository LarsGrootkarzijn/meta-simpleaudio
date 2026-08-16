SUMMARY = "Simpleaudio Bootfiles"
LICENSE = "CLOSED"

SRC_URI = "file://rfspart \
           file://bootargs \
           file://firmware"

S = "${WORKDIR}"

DEPLOY_DIR_TI = "${TOPDIR}/deploy-ti/images/${MACHINE}"

do_deploy() {
    install -d ${DEPLOY_DIR}/images/${MACHINE}
    install -m 0644 ${WORKDIR}/rfspart ${DEPLOY_DIR_TI}/
    install -m 0644 ${WORKDIR}/bootargs ${DEPLOY_DIR_TI}/

    cp -a ${WORKDIR}/firmware/ ${DEPLOY_DIR_TI}/
}

do_image[dirs] += "${DEPLOY_DIR_TI}"
addtask deploy after do_install before do_package