FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

SRC_URI += "file://0001-dbus-sensors-Add-support-for-PSU-channels-controlled.patch \
            file://0002-fansensor-support-pwm-fan-mode-pwm_enable-signal.patch \
            "

