FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

SRC_URI += " \
             file://firmware_update.sh \
             file://turn_on_host_after_flash.sh \
             file://allow-reboot-actions.service \
             file://prevent-reboot-actions.service \
             file://turn-on-the-host-after-flash@.service \
             file://0001-BMC-Updater-Support-update-on-BMC-Alternate-device.patch \
           "

PACKAGECONFIG:append = " flash_bios static-dual-image"

SYSTEMD_SERVICE:${PN}:updater += "${@bb.utils.contains('PACKAGECONFIG', 'flash_bios', 'allow-reboot-actions.service', '', d)}"
SYSTEMD_SERVICE:${PN}:updater += "${@bb.utils.contains('PACKAGECONFIG', 'flash_bios', 'prevent-reboot-actions.service', '', d)}"
SYSTEMD_SERVICE:${PN}:updater += "${@bb.utils.contains('PACKAGECONFIG', 'flash_bios', 'turn-on-the-host-after-flash@.service', '', d)}"

FILES:${PN} += "${@bb.utils.contains('PACKAGECONFIG', 'flash_bios', '${systemd_unitdir}/system/allow-reboot-actions.service', '', d)}"
FILES:${PN} += "${@bb.utils.contains('PACKAGECONFIG', 'flash_bios', '${systemd_unitdir}/system/prevent-reboot-actions.service', '', d)}"
FILES:${PN} += "${@bb.utils.contains('PACKAGECONFIG', 'flash_bios', '${systemd_unitdir}/system/turn-on-the-host-after-flash@.service', '', d)}"

RDEPENDS:${PN} += "bash"

do_install:append() {
    install -d ${D}/usr/sbin
    install -m 0755 ${WORKDIR}/firmware_update.sh ${D}/usr/sbin/firmware_update.sh
    install -m 0755 ${WORKDIR}/turn_on_host_after_flash.sh ${D}/usr/sbin/turn_on_host_after_flash.sh

    install -m 0644 ${WORKDIR}/allow-reboot-actions.service ${D}${systemd_unitdir}/system/allow-reboot-actions.service
    install -m 0644 ${WORKDIR}/prevent-reboot-actions.service ${D}${systemd_unitdir}/system/prevent-reboot-actions.service
    install -m 0644 ${WORKDIR}/turn-on-the-host-after-flash@.service ${D}${systemd_unitdir}/system/turn-on-the-host-after-flash@.service
}
