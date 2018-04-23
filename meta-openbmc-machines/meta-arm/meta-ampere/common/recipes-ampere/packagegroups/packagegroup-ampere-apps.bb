SUMMARY = "OpenBMC for Ampere - Applications"
PR = "r1"

inherit packagegroup
inherit obmc-phosphor-license

PROVIDES = "${PACKAGES}"
PACKAGES = " \
	${PN}-flash \
	${PN}-chassis \
        ${PN}-system \
        "

PROVIDES += "virtual/obmc-flash-mgmt"
PROVIDES += "virtual/obmc-chassis-mgmt"
PROVIDES += "virtual/obmc-system-mgmt"

RPROVIDES_${PN}-flash += "virtual-obmc-flash-mgmt"
RPROVIDES_${PN}-chassis += "virtual-obmc-chassis-mgmt"
RPROVIDES_${PN}-system += "virtual-obmc-system-mgmt"

SUMMARY_${PN}-flash = "Ampere Flash"
RDEPENDS_${PN}-flash = " \
	obmc-flash-bmc \
	obmc-mgr-download \
	obmc-control-bmc \
	"

SUMMARY_${PN}-chassis = "Ampere Chassis"
RDEPENDS_${PN}-chassis = " \
	obmc-button-power \
	obmc-button-reset \
	obmc-control-chassis \
	ampere-powerctrl \
	"

SUMMARY_${PN}-system = "Ampere System"
RDEPENDS_${PN}-system = " \
        obmc-mgr-system \
        "
