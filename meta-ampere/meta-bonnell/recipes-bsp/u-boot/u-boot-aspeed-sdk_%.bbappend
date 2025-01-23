FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

SRC_URI += " \
            file://ampere.cfg \
            file://ast2600-ampere.dts \
           "

do_configure:append (){
     cp -r "${UNPACKDIR}/ast2600-ampere.dts" "${S}/arch/arm/dts"
}


