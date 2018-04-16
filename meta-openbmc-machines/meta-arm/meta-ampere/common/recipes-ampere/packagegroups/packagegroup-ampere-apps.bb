SUMMARY = "OpenBMC for Ampere - Applications"
PR = "r1"

inherit packagegroup
inherit obmc-phosphor-license

PROVIDES = "${PACKAGES}"
PACKAGES = " \
        ${PN}-system \
        "

PROVIDES += "virtual/obmc-system-mgmt"

RPROVIDES_${PN}-system += "virtual-obmc-system-mgmt"

SUMMARY_${PN}-system = "Ampere System"
RDEPENDS_${PN}-system = " \
        obmc-mgr-system \
        "
