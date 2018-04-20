KBRANCH = "ampere-next"
SRC_URI_remove = "git://github.com/openbmc/phosphor-host-ipmid"
SRC_URI_prepend = "git://github.com/ampere-openbmc/phosphor-host-ipmid;protocol=git;branch=${KBRANCH} "
SRCREV = "${AUTOREV}"

FILESEXTRAPATHS_append := ":${THISDIR}/${PN}"
SRC_URI += "file://dev_id.json"

RRECOMMENDS_${PN} += "phosphor-ipmi-tool"
