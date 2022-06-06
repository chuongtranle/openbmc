FILESEXTRAPATHS:prepend := "${THISDIR}/files:"

RDEPENDS:${PN} += "bash libcper"

SRC_URI = "git://github.com/ampere-openbmc/pldm;protocol=https;branch=ampere \
           file://host_eid \
          "
SRCREV = "ae040658e9792f591e0a5a9cfceacb7014f5a411"

SYSTEMD_SERVICE:${PN}:remove = " \
                                pldmSoftPowerOff.service \
                               "
SRC_URI:remove = "file://pldm-softpoweroff"

EXTRA_OEMESON:append = " \
                        -Dampere=enabled \
                       "

do_install:append() {
    install -d ${D}/${datadir}/pldm
    install ${WORKDIR}/host_eid ${D}/${datadir}/pldm/
    LINK="${D}${systemd_unitdir}/obmc-host-shutdown@0.target.wants/pldmSoftPowerOff.service"
    rm -f $LINK
    LINK="${D}${systemd_unitdir}/obmc-host-warm-reboot@0.target.wants/pldmSoftPowerOff.service"
    rm -f $LINK
    rm -f ${D}${systemd_unitdir}/system/pldmSoftPowerOff.service
    rm -rf ${D}/${bindir}/pldm-softpoweroff
}
