SUMMARY = "Simpleaudio dependencies"
LICENSE = "CLOSED"

SRCREV = "${AUTOREV}"
BPV = "0.1.0"
PV = "${BPV}+gitr${SRCPV}"

SRC_URI = "git://github.com/LarsGrootkarzijn/meta-simpleaudio;branch=scarthgap;name=meta-simpleaudio;protocol=https \
           file://simpleaudio-port-installed \
           file://00-default.network"

do_install() {
    # Basis directories
    install -d ${D}/bin
    install -d ${D}/etc
    install -d ${D}${sysconfdir}/systemd/network

    ln -sf /bin/true ${D}/bin/sh

    install -m 0444 ${WORKDIR}/simpleaudio-port-installed ${D}/simpleaudio-port-installed

    echo "${MACHINE}" > ${D}/etc/hostname
    chmod 0644 ${D}/etc/hostname

    install -m 0644 ${WORKDIR}/00-default.network ${D}/etc/systemd/network/00-default.network
}

FILES:${PN} = "/simpleaudio-port-installed /bin/sh /etc/hostname etc/systemd/network/00-default.network"