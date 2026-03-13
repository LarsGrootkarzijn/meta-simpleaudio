DESCRIPTION = "Configure root user in Yocto image"
LICENSE = "CLOSED"
inherit extrausers

EXTRA_USERS_PARAMS = "\
    usermod -p 'SambaPig' root; \
    usermod -a -G wheel,sudo root; \
    usermod -s /bin/bash root; \
"