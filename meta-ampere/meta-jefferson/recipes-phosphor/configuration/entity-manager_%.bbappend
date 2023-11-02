FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"
SRC_URI += " \
            file://mtjefferson_cbp2980.json \
            file://blacklist.json \
           "

do_install:append() {
    install -d ${D}${datadir}/${PN}
    install -m 0444 ${WORKDIR}/blacklist.json ${D}${datadir}/${PN}
    install -d ${D}${datadir}/${PN}/configurations
    install -m 0444 ${WORKDIR}/mtjefferson_cbp2980.json ${D}${datadir}/${PN}/configurations
}
