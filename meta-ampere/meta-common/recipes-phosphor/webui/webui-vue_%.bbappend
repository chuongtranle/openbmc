FILESEXTRAPATHS:append := "${THISDIR}/${PN}:"

SRC_URI += "\
            file://0001-Add-show-info-about-password-Ampere-policy.patch \
            file://0002-Update-Server-status-in-Server-power-operations-page.patch \
            file://0003-Change-to-display-1000-last-event-logs.patch \
            file://0004-Set-ApplyTime-to-Immediate.patch \
	    file://0005-Fix-the-KVM-terminal-screen-not-displaying.patch \
	    file://0006-Use-the-createWebHashHistory-method-to-avoid-404-err.patch \
            file://0007-Parsing-string-arguments-for-Account-policy-settings.patch \
            file://0008-Fix-date-time-format-regex-check.patch \
            file://0009-Bios-Option-Remove-oneTimeBootEnabled-check.patch \
           "
