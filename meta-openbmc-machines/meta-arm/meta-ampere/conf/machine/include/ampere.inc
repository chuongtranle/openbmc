OBMC_MACHINE_FEATURES += "\
        obmc-inventory \
        obmc-bmc-state-mgmt \
        "

PREFERRED_PROVIDER_virtual/obmc-system-mgmt = "packagegroup-ampere-apps"
PREFERRED_PROVIDER_virtual/obmc-inventory-data ?= "${VIRTUAL-RUNTIME_skeleton_workbook}"
