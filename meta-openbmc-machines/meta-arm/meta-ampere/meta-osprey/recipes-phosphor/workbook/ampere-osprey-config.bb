SUMMARY = "Ampere Osprey board wiring"
DESCRIPTION = "Board wiring information for the Ampere Osprey system."
PR = "r1"

inherit config-in-skeleton

S = "${WORKDIR}"
SRC_URI += "file://Ampere-osprey.py"
