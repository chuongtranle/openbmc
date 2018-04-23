FILESEXTRAPATHS_append := "${THISDIR}/files:"

SRC_URI += "file://osprey_power_ctrl.sh"

do_install_append() {
    install -d ${D}/usr/sbin
    install -m 0755 ${WORKDIR}/osprey_power_ctrl.sh ${D}/${sbindir}/ampere_power_ctrl.sh
}
