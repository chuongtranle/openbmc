#!/bin/bash
#
# This is board specific script to control chassis power.
# For Osprey, chassis power is controlled by generating an level trigger
#  on BMC_GPIOC7_SYS_ATX_PSON_L (GPIOC7) to control ATX Power and pulling
#  BMC_GPIOG0_CPU_PWROK pin (GPIOG0) to determine the current chassis status.

if [ $# -lt 1 ]; then
	exit 1
fi

STATE=$1

check_power_ok () {
	GPIO_PWR_OK="$(gpioutil -p G0 -d in)"
	if [[ $GPIO_PWR_OK == 1 ]]; then
		CUR_STATE="on"
	else
		CUR_STATE="off"
	fi
}

# Trigger GPIO C7
check_power_ok
if [[ $STATE == "on" && $CUR_STATE == "off" ]]; then
	gpioutil -p C7 -d out -v 0
	sleep 5
elif [[ $STATE == "off" && $CUR_STATE == "on" ]]; then
	gpioutil -p C7 -d out -v 1
	sleep 5
else
	echo "Error: Can not power $STATE Chassis, current power state has been already $CUR_STATE"
	exit 1
fi

# Recheck current state after power on/off
check_power_ok
if [[ $STATE == "on" && $CUR_STATE == "on" ]] ||
	[[ $STATE == "off" && $CUR_STATE == "off" ]]; then
	echo "Power $STATE Chassis successfully"
else
	echo "Power $STATE Chassis failed !!!"
fi

exit 0
