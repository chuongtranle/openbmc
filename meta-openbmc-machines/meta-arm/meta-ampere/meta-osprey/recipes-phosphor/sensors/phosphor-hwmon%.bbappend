FILESEXTRAPATHS_prepend_ampere-osprey := "${THISDIR}/${PN}:"

ITEMS = "iio-hwmon.conf"

ENVS = "obmc/hwmon/{0}"
SYSTEMD_ENVIRONMENT_FILE_${PN}_append_ampere-osprey += "${@compose_list(d, 'ENVS', 'ITEMS')}"
