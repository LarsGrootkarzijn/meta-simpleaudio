DESCRIPTION = "Temporary workaround for /bin/sh dependency"
LICENSE = "CLOSED"

RPROVIDES_${PN} = "sh /bin/sh"

do_install() {
    install -d ${D}/bin
    ln -sf /bin/true ${D}/bin/sh
}