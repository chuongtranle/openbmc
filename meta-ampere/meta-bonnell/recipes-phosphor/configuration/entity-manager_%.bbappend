FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

SRC_URI += " \
            file://blacklist.json \
            file://${MACHINE}.json \
           "

do_install:append() {
     install -d ${D}${datadir}/${PN}/configurations
     install -m 0444 ${UNPACKDIR}/${MACHINE}.json ${D}${datadir}/${PN}/configurations
     install -d ${D}${datadir}/${PN}
     install -m 0444 ${UNPACKDIR}/blacklist.json ${D}${datadir}/${PN}
}
