FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

SRC_URI = "\
           git://github.com/ampere-openbmc/linux;protocol=https;branch=ampere \
           file://defconfig \
          "

SRCREV="606a66d7a7ad773e418d6220ddb571695b3dc523"
LINUX_VERSION = "6.6.60"
KERNEL_VERSION_SANITY_SKIP = "1"

SRC_URI += " \
            file://${MACHINE}.cfg \
            file://${KMACHINE}-bmc-ampere-${MACHINE}.dts \
           "


do_patch:append() {
    for DTB in "${KERNEL_DEVICETREE}"; do
        DT=`basename ${DTB} .dtb`
        if [ -r "${UNPACKDIR}/${DT}.dts" ]; then
            cp ${UNPACKDIR}/${DT}.dts \
                ${STAGING_KERNEL_DIR}/arch/${ARCH}/boot/dts/${KMACHINE}
        fi
    done
}
