KBRANCH = "ampere-4.13-next"
SRCREV = "${AUTOREV}"
KSRC_remove = "git://github.com/openbmc/linux;protocol=git;branch=${KBRANCH}"
KSRC_prepend = "git://github.com/ampere-openbmc/linux;protocol=git;branch=${KBRANCH} "
