SUMMARY = "Simpleaudio GPIO tools"
LICENSE = "CLOSED"

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

    install -d ${D}/lib/systemd/system/
    install -d ${D}/etc/systemd/system/multi-user.target.wants/
    install -m 0644 ${THISDIR}/files/simpleaudio-gpio-init.service ${D}/lib/systemd/system/simpleaudio-gpio-init.service
    ln -sf ../../../../lib/systemd/system/simpleaudio-gpio-init.service \
        ${D}/etc/systemd/system/multi-user.target.wants/simpleaudio-gpio-init.service
}

SYSTEMD_SERVICE:${PN} = "simpleaudio-gpio-init.service"

FILES:${PN} += "${bindir} ${systemd_system_unitdir}/simpleaudio-gpio-init.service"