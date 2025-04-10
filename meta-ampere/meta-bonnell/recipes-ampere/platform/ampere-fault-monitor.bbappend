FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

RDEPENDS:${PN} = "bash"

SRC_URI += " \
            file://ampere_check_gpio_fault.sh \
            file://ampere_fault_monitor.sh \
           "

do_install:append() {
    install -d ${D}/${sbindir}
    install -m 755 ${WORKDIR}/ampere_check_gpio_fault.sh ${D}/${sbindir}/
    install -m 755 ${WORKDIR}/ampere_fault_monitor.sh ${D}/${sbindir}/
}
