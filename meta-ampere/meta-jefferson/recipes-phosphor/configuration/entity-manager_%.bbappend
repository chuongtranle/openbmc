FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"
SRC_URI += " \
            file://mtjefferson_mb.json \
            file://mtjefferson_bmc.json \
            file://mtjefferson_psu.json \
            file://blacklist.json \
           "

do_install:append() {
    install -d ${D}${datadir}/${PN}
    install -m 0444 ${WORKDIR}/blacklist.json ${D}${datadir}/${PN}
    install -d ${D}${datadir}/${PN}/configurations
    install -m 0444 ${WORKDIR}/mtjefferson_mb.json ${D}${datadir}/${PN}/configurations
    install -m 0444 ${WORKDIR}/mtjefferson_bmc.json ${D}${datadir}/${PN}/configurations
    install -m 0444 ${WORKDIR}/mtjefferson_psu.json ${D}${datadir}/${PN}/configurations
}
