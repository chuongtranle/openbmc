PACKAGECONFIG:append = " smbios-ipmi-blob"
FILESEXTRAPATHS:append := "${THISDIR}/${PN}:"

SRC_URI:append = " \
                  file://0001_fix_failed_when_EDK2_update_SMBIOSver37.patch \
                 "
