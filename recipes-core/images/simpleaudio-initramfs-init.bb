DESCRIPTION = "Custom init for Simpleaudio"
LICENSE = "CLOSED"

SRC_URI = "file://init"

S = "${WORKDIR}"

do_install() {
    install -d ${D}
    install -m 0755 ${WORKDIR}/init ${D}/init

    install -d ${D}/dev

    mknod -m 622 ${D}/dev/console c 5 1
}

FILES:${PN} = "/init /dev/console"