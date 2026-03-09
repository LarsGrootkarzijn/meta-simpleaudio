SUMMARY = "Simpleaudio dependencies"
LICENSE = "CLOSED"

SRCREV = "${AUTOREV}"
BPV = "0.1.0"
PV = "${BPV}+gitr${SRCPV}" 

SRC_URI = "git://github.com/LarsGrootkarzijn/meta-simpleaudio;branch=scarthgap;name=meta-simpleaudio;protocol=https \
           file://simpleaudio-hifiberry-installed"

do_install() {
    install -d ${D}/
    install -m 0444 ${WORKDIR}/simpleaudio-hifiberry-installed ${D}/simpleaudio-hifiberry-installed

    install -d ${D}/bin
    ln -sf /bin/true ${D}/bin/sh

    install -d ${D}/etc

    echo "${MACHINE}" > ${D}/etc/hostname
    chmod 0644 ${D}/etc/hostname
}

FILES:${PN} = "/simpleaudio-hifiberry-installed /bin/sh /etc/hostname"