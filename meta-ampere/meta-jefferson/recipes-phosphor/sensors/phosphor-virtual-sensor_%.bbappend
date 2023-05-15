FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

SRC_URI:append = " \
                  file://mtjefferson_virtual_sensor_config.json \
                 "

do_install:append() {
    install -m 0644 ${WORKDIR}/mtjefferson_virtual_sensor_config.json \
        ${D}${datadir}/phosphor-virtual-sensor/virtual_sensor_config.json
}

