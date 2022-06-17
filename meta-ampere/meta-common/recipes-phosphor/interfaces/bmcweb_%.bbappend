FILESEXTRAPATHS:append := "${THISDIR}/${PN}:"

EXTRA_OEMESON:append = " \
     -Dredfish-bmc-journal=enabled \
     -Dhttp-body-limit=65 \
     -Dredfish-dump-log=enabled \
     -Dredfish-allow-deprecated-power-thermal=disabled \
     "

SRC_URI += " \
            file://0001-support-BootProgress-OemLastState.patch \
            file://0002-LogService-Add-CPER-logs-crashdumps-to-FaultLog.patch \
            file://0003-LogService-Support-download-FaultLog-data-via-Additi.patch \
            file://0004-Support-Redfish-Hostinterface-schema.patch \
            file://0005-Support-HostInterface-privilege-role.patch \
            file://0006-Prevent-the-Operator-user-to-flash-the-firmware.patch \
            file://0007-Redfish-Add-message-registries-for-Ampere-events.patch\
            file://0008-chassis-Methods-to-PhysicalSecurity-s-properties.patch \
            file://0009-Support-remove-user-s-web-session.patch \
            file://0010-Enable-vm-nbdproxy-for-Redfish-Virtual-Media.patch \
            file://0011-Support-ProductionDate-report.patch \
            file://0012-Fix-for-Redfish-URI-Sensors-Chassis-Baseboard.patch \
            file://0013-Get-ApplyTime-from-Dbus.patch \
            file://0014-redfish-core-lib-managers-Ignore-AccumulateSetPoint.patch \
            file://0015-Increase-TaskTimer-in-Update-Service.patch \
           "
