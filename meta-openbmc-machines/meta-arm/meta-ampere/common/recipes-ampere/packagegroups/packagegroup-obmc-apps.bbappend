RDEPENDS_${PN}-extrasdevtools += "obmc-pydevtools"

# Add the deprecated /org/openbmc inventory namespace providing
# obmc-mgr-inventory application to the inventory packagegroup
# until all applications have been updated to use the new,
# officially spec'ed xyz.openbmc_project.Inventory.Manager
# provider (VIRTUAL-RUNTIME_obmc-inventory-manager).
RDEPENDS_${PN}-inventory += "obmc-mgr-inventory"
