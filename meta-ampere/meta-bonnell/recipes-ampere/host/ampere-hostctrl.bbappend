FILESEXTRAPATHS:append := "${THISDIR}/${PN}:"

SRC_URI += " \
          file://ampere-chassis-poweroff.service \
          file://ampere-chassis-poweron.service \
          file://ampere-host-shutdown.service \
          "


SYSTEMD_PACKAGES = "${PN}"
SYSTEMD_SERVICE:${PN} += " \
        ampere-chassis-poweroff.service \
        ampere-chassis-poweron.service \
        ampere-host-shutdown.service \
        "
# host power control
# overwrite the host shutdown to graceful shutdown
HOST_SHUTDOWN_TMPL = "ampere-host-shutdown.service"
HOST_SHUTDOWN_TGTFMT = "obmc-host-shutdown@{0}.target"
HOST_SHUTDOWN_FMT = "../${HOST_SHUTDOWN_TMPL}:${HOST_SHUTDOWN_TGTFMT}.requires/${HOST_SHUTDOWN_TMPL}"
SYSTEMD_LINK:${PN} += "${@compose_list_zip(d, 'HOST_SHUTDOWN_FMT', 'OBMC_HOST_INSTANCES')}"

# chassis power control
CHASSIS_POWERON_SVC = "ampere-chassis-poweron.service"
CHASSIS_POWERON_TGTFMT = "obmc-chassis-poweron@{0}.target"
CHASSIS_POWERON_FMT = "../${CHASSIS_POWERON_SVC}:${CHASSIS_POWERON_TGTFMT}.requires/${CHASSIS_POWERON_SVC}"
SYSTEMD_LINK:${PN} += "${@compose_list_zip(d, 'CHASSIS_POWERON_FMT', 'OBMC_CHASSIS_INSTANCES')}"

CHASSIS_POWEROFF_SVC = "ampere-chassis-poweroff.service"
CHASSIS_POWEROFF_TGTFMT = "obmc-chassis-poweroff@{0}.target"
CHASSIS_POWEROFF_FMT = "../${CHASSIS_POWEROFF_SVC}:${CHASSIS_POWEROFF_TGTFMT}.requires/${CHASSIS_POWEROFF_SVC}"
SYSTEMD_LINK:${PN} += "${@compose_list_zip(d, 'CHASSIS_POWEROFF_FMT', 'OBMC_CHASSIS_INSTANCES')}"

