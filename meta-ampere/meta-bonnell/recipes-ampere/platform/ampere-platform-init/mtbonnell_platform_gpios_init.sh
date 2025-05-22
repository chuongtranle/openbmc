#!/bin/bash
set -x

# NOTE: WIP

function pre-platform-init() {
    echo "Do pre platform init"
}


function post-platform-init() {
    echo "Do post platform init"
    gpioset $(gpiofind bmc-ready-n)=0
    gpioset $(gpiofind bmc-s0-mem-efgh-sel)=1
    gpioset $(gpiofind bmc-s0-mem-abcd-sel)=1
    gpioset $(gpiofind bmc-vbat-sen-en)=0 # Enable for sense Battery voltage

}

export output_high_gpios_in_ac=(
    # add device enable, mux setting, device select gpios
    "bmc-i2c4-en"
    "host-online-en"
    "host0-shd-req-n"
    "host0-sysreset-n"
    "i2c-backup-sel"
)

export output_low_gpios_in_ac=(
    # add device enable, mux setting, device select gpios
    "spi0-program-sel"
    "spi0-backup-sel"
    "s0-rtc-lock"
    "host0-special-boot"
)

export input_gpios_in_ac=(
    # add device enable, mux setting, device select gpios
)

export output_high_gpios_in_bmc_reboot=(
    # "bmc-vga-en-n"
    "bmc-s0-mem-abcd-sel"
    "bmc-s0-mem-efgh-sel"
    "s0-vr1-pmbus-sel"
    "s0-vr0-pmbus-sel"
)

export output_low_gpios_in_bmc_reboot=(
    "spi0-program-sel"
    "spi0-backup-sel"
    "uart1-mode1"
    "uart2-mode1"
    "uart3-mode1"
)

export input_gpios_in_bmc_reboot=(
    # "s0-i2c9-alert-n"
    # "s0-vr-hot-n"
    # "psu0-work"
    # "psu1-work"
)
