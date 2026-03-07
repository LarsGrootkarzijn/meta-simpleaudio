SUMMARY = "Dependencies rootfs"
LICENSE = "CLOSED"

SRC_URI = "file://simpleaudio-hifiberry-installed"

# Plaats de file in de root van je image
do_install() {
    install -d ${D}/
    install -m 0444 ${WORKDIR}/simpleaudio-hifiberry-installed ${D}/simpleaudio-hifiberry-installed
}

FILES:${PN} = "/simpleaudio-hifiberry-installed"