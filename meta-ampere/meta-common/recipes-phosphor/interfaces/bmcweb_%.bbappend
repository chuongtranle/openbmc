FILESEXTRAPATHS:append := "${THISDIR}/${PN}:"

EXTRA_OEMESON:append = " \
     -Dredfish-bmc-journal=enabled \
     -Dhttp-body-limit=65 \
     -Dredfish-dump-log=enabled \
     -Dredfish-allow-deprecated-power-thermal=disabled \
     "

SRC_URI += " \
            file://0001-ampere-support-BootProgress-OemLastState.patch \
            file://0002-Support-Redfish-Hostinterface-schema.patch \
            file://0003-ampere-prevent-the-Operator-user-to-flash-the-firmwa.patch \
            file://0004-ampere-Add-OEM-message-registries.patch \
            file://0005-chassis-Methods-to-PhysicalSecurity-s-properties.patch \
            file://0006-Support-remove-user-s-web-session.patch \
            file://0007-ampere-enable-vm-nbdproxy-for-Redfish-Virtual-Media.patch \
            file://0008-Support-ProductionDate-report.patch \
            file://0009-Fix-for-Redfish-URI-Sensors-Chassis-Baseboard.patch \
            file://0010-LogService-Add-CPER-logs-crashdumps-to-FaultLog.patch \
            file://0011-LogService-Support-download-FaultLog-data-via-Additi.patch \
            file://0012-update-service-get-ApplyTime-from-Dbus.patch \
            file://0013-managers-pid-fan-Ignore-AccumulateSetPoint.patch \
            file://0014-Increase-TaskTimer-in-Update-Service.patch \
            file://0015-Don-t-delete-DefaultGateway-when-disabling-DHCP.patch \
           "
