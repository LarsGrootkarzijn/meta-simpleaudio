SUMMARY = "RoomPlayer Plus Custom Image"
LICENSE = "CLOSED"

SRC_URI = "file://rfspart \
           file://bootargs"

S = "${WORKDIR}"

do_deploy() {
    install -d ${DEPLOY_DIR}/images/${MACHINE}
    install -m 0644 ${WORKDIR}/rfspart ${DEPLOY_DIR}/images/${MACHINE}/
    install -m 0644 ${WORKDIR}/bootargs ${DEPLOY_DIR}/images/${MACHINE}/
}

# Zorg dat do_deploy wordt uitgevoerd als dependency van do_image
do_image[dirs] += "${DEPLOY_DIR}/images/${MACHINE}"
addtask deploy after do_install before do_package