FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

SRC_URI += " \
            file://mtjade.json \
            file://mtjade_psu.json \
            file://blacklist.json \
           "

do_install:append() {
     install -d ${D}${datadir}/${PN}/configurations
     install -m 0444 ${WORKDIR}/mtjade.json ${D}${datadir}/${PN}/configurations
     install -m 0444 ${WORKDIR}/mtjade_psu.json ${D}${datadir}/${PN}/configurations
     find ${D}${datadir}/${PN}/configurations -maxdepth 1 -type f ! -name "mtjade*" -delete

     install -d ${D}${datadir}/${PN}
     install -m 0444 ${WORKDIR}/blacklist.json ${D}${datadir}/${PN}
}
