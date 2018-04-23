OBMC_MACHINE_FEATURES += "\
        obmc-inventory \
	obmc-phosphor-flash-mgmt \
	obmc-phosphor-chassis-mgmt \
	obmc-chassis-state-mgmt \
        obmc-bmc-state-mgmt \
	obmc-host-ipmi \
        "

PREFERRED_PROVIDER_virtual/obmc-flash-mgmt = "packagegroup-ampere-apps"
PREFERRED_PROVIDER_virtual/obmc-chassis-mgmt = "packagegroup-ampere-apps"
PREFERRED_PROVIDER_virtual/obmc-system-mgmt = "packagegroup-ampere-apps"
PREFERRED_PROVIDER_virtual/obmc-inventory-data ?= "${VIRTUAL-RUNTIME_skeleton_workbook}"
