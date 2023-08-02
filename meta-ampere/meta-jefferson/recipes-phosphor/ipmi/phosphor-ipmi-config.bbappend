FILESEXTRAPATHS:append := "${THISDIR}/${PN}:"

SRC_URI += " \
             file://fru_id.json \
             file://power_limit.json \
           "

FILES:${PN} += " \
                 ${datadir}/ipmi-providers/fru_id.json \
                 ${datadir}/ipmi-providers/power_limit.json \
               "

do_install:append() {
    install -m 0644 -D ${WORKDIR}/fru_id.json \
        ${D}${datadir}/ipmi-providers/fru_id.json
    install -m 0644 -D ${WORKDIR}/power_limit.json \
        ${D}${datadir}/ipmi-providers/power_limit.json
    # The default dummy data provided for this file causes breakage in
    # Get SDR commands. Clearing out the provided entity-map entirely
    # avoids the issue.
    echo "[]" > ${D}${datadir}/ipmi-providers/entity-map.json
}
