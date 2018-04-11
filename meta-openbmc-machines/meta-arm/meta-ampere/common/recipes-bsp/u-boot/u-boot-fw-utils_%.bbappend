SRCREV = "${AUTOREV}"
UBRANCH = "ampere-next"
SRC_URI_remove = "git://git@github.com/openbmc/u-boot.git;branch=${UBRANCH};protocol=https" 
SRC_URI_prepend = "git://github.com/ampere-openbmc/u-boot.git;branch=${UBRANCH};protocol=git "
