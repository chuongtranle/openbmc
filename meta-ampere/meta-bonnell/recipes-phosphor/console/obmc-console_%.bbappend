FILESEXTRAPATHS:append := "${THISDIR}/${PN}:"
RDEPENDS:${PN} += "bash"

# Declare port spcific config files
OBMC_CONSOLE_TTYS = "ttyS0 ttyS1 ttyS2"
CONSOLE_CLIENT = "2200 2201 2202"

SRC_URI += " \
             file://0001-Increase-dropbear-timeout-to-60s.patch \
             ${@compose_list(d, 'CONSOLE_SERVER_CONF_FMT', 'OBMC_CONSOLE_TTYS')} \
             ${@compose_list(d, 'CONSOLE_CLIENT_CONF_FMT', 'CONSOLE_CLIENT')} \
           "

SYSTEMD_SERVICE:${PN}:append = " \
                                  ${@compose_list(d, 'CONSOLE_CLIENT_SERVICE_FMT', 'CONSOLE_CLIENT')} \
                                "

do_install:append() {
    # Install the console client configurations
    install -m 0644 ${UNPACKDIR}/client.*.conf ${D}${sysconfdir}/${BPN}
}
