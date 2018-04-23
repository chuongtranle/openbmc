SUMMARY = "Ampere Computing LLC Chassis Control Implementation"
DESCRIPTION = "A chassis control implementation suitable for Ampere systems"
PR = "r1"

inherit systemd
inherit obmc-phosphor-license
inherit obmc-phosphor-systemd

DEPENDS = "systemd"
RDEPENDS_${PN} = "bash"

SYSTEMD_PACKAGES = "${PN}"
SYSTEMD_SERVICE_${PN} = " \
        ampere-chassis-poweron.service \
        ampere-chassis-poweroff.service \
        "

CHASSIS_POWERON_SVC = "ampere-chassis-poweron.service"
CHASSIS_POWERON_TGTFMT = "obmc-chassis-poweron@{0}.target"
CHASSIS_POWERON_FMT = "../${CHASSIS_POWERON_SVC}:${CHASSIS_POWERON_TGTFMT}.requires/${CHASSIS_POWERON_SVC}"
SYSTEMD_LINK_${PN} += "${@compose_list_zip(d, 'CHASSIS_POWERON_FMT', 'OBMC_CHASSIS_INSTANCES')}"

CHASSIS_POWEROFF_SVC = "ampere-chassis-poweroff.service"
CHASSIS_POWEROFF_TGTFMT = "obmc-chassis-poweroff@{0}.target"
CHASSIS_POWEROFF_FMT = "../${CHASSIS_POWEROFF_SVC}:${CHASSIS_POWEROFF_TGTFMT}.requires/${CHASSIS_POWEROFF_SVC}"
SYSTEMD_LINK_${PN} += "${@compose_list_zip(d, 'CHASSIS_POWEROFF_FMT', 'OBMC_CHASSIS_INSTANCES')}"

# Chassis On requires Host start also
HOST_START_SVC = "obmc-host-start@{0}.target"
HOST_START_TGTFMT = "obmc-chassis-poweron@{0}.target"
HOST_START_FMT = "../${HOST_START_SVC}:${HOST_START_TGTFMT}.requires/${HOST_START_SVC}"
SYSTEMD_LINK_${PN} += "${@compose_list_zip(d, 'HOST_START_FMT', 'OBMC_CHASSIS_INSTANCES')}"
