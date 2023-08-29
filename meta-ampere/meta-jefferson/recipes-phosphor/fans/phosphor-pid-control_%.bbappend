FILESEXTRAPATHS:prepend:= "${THISDIR}/${PN}:"

inherit obmc-phosphor-systemd

AMPERE_PID_POWEROFF = "ampere-pid-power-off.service"

SRC_URI:append = " file://${AMPERE_PID_POWEROFF} \
                   file://${PN}.service \
                "
FILES:${PN}:append = " ${systemd_system_unitdir}/${AMPERE_PID_POWEROFF} \
                     "
SYSTEMD_SERVICE:${PN}:append = " ${AMPERE_PID_POWEROFF} \
                               "

do_install:append() {
    install -m 644 ${WORKDIR}/${PN}.service ${D}${systemd_system_unitdir}
}

