FILESEXTRAPATHS:append := "${THISDIR}/${PN}:"

SRC_URI += " \
            file://power_limit.json \
            file://sensor_filter.json \
           "

FILES:${PN} += " \
                ${datadir}/ipmi-providers/power_limit.json \
                ${datadir}/ipmi-providers/sensor_filter.json \
               "

do_install:append() {
    install -m 0644 -D ${WORKDIR}/power_limit.json \
        ${D}${datadir}/ipmi-providers/power_limit.json
    install -m 0644 -D ${WORKDIR}/sensor_filter.json \
        ${D}${datadir}/ipmi-providers/sensor_filter.json
    # The default dummy data provided for this file causes breakage in
    # Get SDR commands. Clearing out the provided entity-map entirely
    # avoids the issue.
    echo "[]" > ${D}${datadir}/ipmi-providers/entity-map.json
}