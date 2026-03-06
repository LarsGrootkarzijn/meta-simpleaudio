DESCRIPTION = "Custom init scripts for SimpleAudio initramfs"
LICENSE = "CLOSED"

SRC_URI = "file://S99_upgrade.sh"

S = "${WORKDIR}"

do_install() {
    install -d ${D}/etc/init.d
    install -m 0755 ${WORKDIR}/S99_upgrade.sh ${D}/etc/init.d/
}