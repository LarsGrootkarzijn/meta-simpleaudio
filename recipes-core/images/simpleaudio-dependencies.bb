SUMMARY = "Simpleaudio dependencies"
LICENSE = "CLOSED"

SRC_URI = "file://simpleaudio-hifiberry-installed"

do_install() {
    install -d ${D}/
    install -m 0444 ${WORKDIR}/simpleaudio-hifiberry-installed ${D}/simpleaudio-hifiberry-installed
}

FILES:${PN} = "/simpleaudio-hifiberry-installed"