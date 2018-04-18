FILESEXTRAPATHS_prepend_ampere-osprey := "${THISDIR}/${PN}:"

ITEMS = "iio-hwmon.conf"

NAMES = " \
        i2c@1e78a000/i2c-bus@100/lm75@48 \
        i2c@1e78a000/i2c-bus@100/lm75@49 \
        i2c@1e78a000/i2c-bus@100/lm75@49 \
        i2c@1e78a000/i2c-bus@100/lm75@4a \
        i2c@1e78a000/i2c-bus@100/lm75@4b \
        i2c@1e78a000/i2c-bus@100/lm75@4c \
        i2c@1e78a000/i2c-bus@100/lm75@4d \
        i2c@1e78a000/i2c-bus@100/lm75@4e \
        i2c@1e78a000/i2c-bus@100/lm75@4f \
        i2c@1e78a000/i2c-bus@100/lm95241@19 \
        i2c@1e78a000/i2c-bus@100/mcp98243@1a \
        "

ITEMSFMT = "ahb/apb/{0}.conf"

ITEMS += "${@compose_list(d, 'ITEMSFMT', 'NAMES')}"

ENVS = "obmc/hwmon/{0}"
SYSTEMD_ENVIRONMENT_FILE_${PN}_append_ampere-osprey += "${@compose_list(d, 'ENVS', 'ITEMS')}"
