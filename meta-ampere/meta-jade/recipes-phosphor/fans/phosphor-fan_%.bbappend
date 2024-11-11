FILESEXTRAPATHS:append := "${THISDIR}/${PN}:"

RDEPENDS:${PN}-monitor += "bash"

PACKAGECONFIG:append = " json"

SRC_URI:append = " file://events.json \
                  file://fans.json \
                  file://groups.json \
                  file://zones.json \
                  file://monitor.json \
                  file://presence.json \
                "

do_configure:prepend() {
        mkdir -p ${S}/control/config_files/${MACHINE}
        cp ${WORKDIR}/events.json ${S}/control/config_files/${MACHINE}/events.json
        cp ${WORKDIR}/fans.json ${S}/control/config_files/${MACHINE}/fans.json
        cp ${WORKDIR}/groups.json ${S}/control/config_files/${MACHINE}/groups.json
        cp ${WORKDIR}/zones.json ${S}/control/config_files/${MACHINE}/zones.json

        mkdir -p ${S}/monitor/config_files/${MACHINE}
        cp ${WORKDIR}/monitor.json ${S}/monitor/config_files/${MACHINE}/config.json

        mkdir -p ${S}/presence/config_files/${MACHINE}
        cp ${WORKDIR}/presence.json ${S}/presence/config_files/${MACHINE}/config.json
}



