FILESEXTRAPATHS:append := "${THISDIR}/${PN}:"

SRC_URI += "\
            file://0001-Add-show-info-about-password-Ampere-policy.patch \
            file://0002-Update-Server-status-in-Server-power-operations-page.patch \
            file://0003-Change-to-display-1000-last-event-logs.patch \
            file://0004-Add-default-Target-to-MultipartHttpPush.patch \
           "

SRCREV = "e2c716a91f3cf130427600c26ae58de0f9750f2a"
