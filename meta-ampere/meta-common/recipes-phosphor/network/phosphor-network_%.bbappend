FILESEXTRAPATHS:append := "${THISDIR}/${PN}:"

PACKAGECONFIG:append = " sync-mac"
EXTRA_OEMESON:append = " -Dforce-sync-mac=false"

SRC_URI:append = " file://60-phosphor-networkd-default.network.in \
                 "

do_configure:prepend () {
    cp ${WORKDIR}/60-phosphor-networkd-default.network.in ${S}/60-phosphor-networkd-default.network.in
}
