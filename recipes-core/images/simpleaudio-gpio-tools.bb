SUMMARY = "Simpleaudio GPIO tools"
LICENSE = "CLOSED"

inherit systemd

SRC_URI = "file://getgpio \
           file://setgpio \
           file://initgpio \
           file://simpleaudio-gpio-init.service"

S = "${WORKDIR}"


do_install() {
    install -d ${D}${bindir}
    install -m 0755 ${WORKDIR}/setgpio ${D}${bindir}
    install -m 0755 ${WORKDIR}/getgpio ${D}${bindir}
    install -m 0755 ${WORKDIR}/initgpio ${D}${bindir}

    install -d ${D}${systemd_system_unitdir}
    install -m 0644 ${WORKDIR}/simpleaudio-gpio-init.service ${D}${systemd_system_unitdir}/simpleaudio-gpio-init.service
}

SYSTEMD_SERVICE:${PN} = "simpleaudio-gpio-init.service"

FILES:${PN} += "${bindir} ${systemd_system_unitdir}/simpleaudio-gpio-init.service"