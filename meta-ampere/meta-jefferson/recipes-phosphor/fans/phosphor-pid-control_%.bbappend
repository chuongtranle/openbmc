FILESEXTRAPATHS:prepend:= "${THISDIR}/${PN}:"

inherit obmc-phosphor-systemd

SRC_URI:append = " \
                  file://${PN}.service \
                  file://0001-Append-to-MissingIsAcceptable-handling.patch \
                 "

do_install:append() {
    install -m 644 ${WORKDIR}/${PN}.service ${D}${systemd_system_unitdir}
}
