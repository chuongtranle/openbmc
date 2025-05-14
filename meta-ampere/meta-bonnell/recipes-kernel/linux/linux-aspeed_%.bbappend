FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

SRC_URI += " \
            file://${MACHINE}.cfg \
            file://${KMACHINE}-bmc-ampere-${MACHINE}.dts \
            file://0300-aspeed-g6.dtsi-update-for-PWM-and-TACH-driver.patch \
           "


do_patch:append() {
    for DTB in "${KERNEL_DEVICETREE}"; do
        DT=`basename ${DTB} .dtb`
        if [ -r "${WORKDIR}/${DT}.dts" ]; then
            cp ${WORKDIR}/${DT}.dts \
                ${STAGING_KERNEL_DIR}/arch/${ARCH}/boot/dts/${KMACHINE}
        fi
    done
}
