FILESEXTRAPATHS:append := "${THISDIR}/${PN}:"

FILES:${PN} += "${systemd_system_unitdir}/ssifbridge.service.d"
# Workaround remove ssifbridge-override.conf because can not find `bmc-ok` gpio.
do_install:append() {
    rm -rf ${D}${systemd_system_unitdir}/ssifbridge.service.d
}
