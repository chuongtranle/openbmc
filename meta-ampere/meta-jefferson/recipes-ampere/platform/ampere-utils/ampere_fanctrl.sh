#!/bin/bash

# shellcheck disable=SC2004

fan_ctrl_bus=0x08
fan_ctrl_addr=0x5c

adt7462_reg_cfg1=0x01
adt7462_reg_cfg2=0x02
adt7462_reg_tach_enable=0x07
adt7462_reg_pwm_cfg=0x21
adt7462_reg_max_pwm=0x2c

adt7462_high_freq_mode=0x04
adt7462_setup_complete=0x20
adt7462_bhvr_manual_mode=0xe0
adt7462_tach_enable=0xff
adt7462_max_pwm=0xff
fan_nums=4

fan_hwmon_num=$(ls /sys/bus/i2c/drivers/adt7462/8-005c/hwmon)
fan_hwmon_path="/sys/class/hwmon/$fan_hwmon_num/"
adt7462_bus_addr="8-005c"

phosphor_fan_service=("phosphor-fan-control@0.service"
                      "phosphor-fan-monitor@0.service"
                      "phosphor-fan-presence-tach@0.service"
                      "phosphor-pid-control.service")

function stop_phosphor_fan_services() {
	for service in "${phosphor_fan_service[@]}"
	do
		systemctl stop "$service"
		busctl call org.freedesktop.systemd1 /org/freedesktop/systemd1 org.freedesktop.systemd1.Manager MaskUnitFiles asbb 1 "$service" true true
	done
	systemctl daemon-reload
}

function start_phosphor_fan_services() {
	for service in "${phosphor_fan_service[@]}"
	do
		busctl call org.freedesktop.systemd1 /org/freedesktop/systemd1 org.freedesktop.systemd1.Manager UnmaskUnitFiles asb 1 "$service" true
	done

	systemctl daemon-reload

	for service in "${phosphor_fan_service[@]}"
	do
		if [ "$service" == "phosphor-pid-control.service" ] &&
		[ "$(obmcutil chassisstate | awk -F. '{print $NF}')" == 'Off' ]; then
			continue
		fi
		systemctl start "$service"
	done
}

function fan_controller_init() {
	# Check the ADT7462 driver binded before
	ADT7462=/sys/bus/i2c/drivers/adt7462/"$adt7462_bus_addr"
	if [ -d "$ADT7462" ]; then
		echo "Unbind the ADT7462 driver"
		echo "$adt7462_bus_addr" > /sys/bus/i2c/drivers/adt7462/unbind
		sleep 1
	fi

	# Set Maximum PWM duty cycle
	i2cset -f -y $fan_ctrl_bus $fan_ctrl_addr $adt7462_reg_max_pwm $adt7462_max_pwm

	# Set High frequency mode
	val=$(i2cget -f -y $fan_ctrl_bus $fan_ctrl_addr $adt7462_reg_cfg2)
	val=$(($val | $adt7462_high_freq_mode))
	i2cset -f -y $fan_ctrl_bus $fan_ctrl_addr $adt7462_reg_cfg2 $val

	# Enable TACH
	i2cset -f -y $fan_ctrl_bus $fan_ctrl_addr $adt7462_reg_tach_enable $adt7462_tach_enable

	# Set PWM Manual mode
	for i in $(seq 0 $((fan_nums - 1)))
	do
		reg_pwm_cfg=$(($adt7462_reg_pwm_cfg + $i))
		val=$(i2cget -f -y $fan_ctrl_bus $fan_ctrl_addr $reg_pwm_cfg)
		val=$(($val | $adt7462_bhvr_manual_mode))
		i2cset -f -y $fan_ctrl_bus $fan_ctrl_addr $reg_pwm_cfg $val
	done

	# Setup complete
	val=$(i2cget -f -y $fan_ctrl_bus $fan_ctrl_addr $adt7462_reg_cfg1)
	val=$(($val | $adt7462_setup_complete))
	i2cset -f -y $fan_ctrl_bus $fan_ctrl_addr $adt7462_reg_cfg1 $val

	# Bind ADT7462 driver
	echo "Bind the ADT7462 driver"
	echo "$adt7462_bus_addr" > /sys/bus/i2c/drivers/adt7462/bind
}

function read_speed() {
	fan_tach=$(cat "${fan_hwmon_path}$2")
	ret=$?
	if [ $ret != 0 ]; then
		echo "Error: get fan speed failed!"
		exit 1
	fi

	fan_pwm=$(cat "${fan_hwmon_path}$3")
	ret=$?
	if [ $ret != 0 ]; then
		echo "Error: get fan pwm duty cycle failed!"
		exit 1
	fi

	# Convert Fan PWM to Duty cycle, adding 127 for rounding.
	pwm_duty_cyle=$(((("$fan_pwm" * 100) + 127) / 255))

	echo "FAN$1, PWM: $fan_pwm, Duty cycle: $pwm_duty_cyle%, Speed(RPM): $fan_tach"
}

function set_pwm() {
	# Convert Fan Duty cycle to PWM, adding 50 for rounding.
	fan_pwm=$(((($2 * 255) + 50) / 100))
	echo "$fan_pwm" > "${fan_hwmon_path}$1"
	ret=$?
	if [ $ret != 0 ]; then
		echo "Error: set fan pwm duty cycle failed!"
		exit 255
	fi
}

function getstatus() {
    fan_ctl_stt=$(systemctl is-active phosphor-fan-control@0.service | grep inactive)
    fan_monitor_stt=$(systemctl is-active phosphor-fan-monitor@0.service | grep inactive)
    if [[ -z "$fan_ctl_stt" && -z "$fan_monitor_stt" ]]; then
        echo "Thermal Control operational status: Enabled"
        exit 0
    else
        echo "Thermal Control operational status: Disabled"
        exit 1
    fi
}

function setstatus() {
    if [ "$1" == 0 ]; then
        # Enable fan services
        start_phosphor_fan_services
    else
        # Disable fan services
        stop_phosphor_fan_services
    fi
}

function setspeed() {
	# Get Fan PWM value of the fan
	case "$1" in
	0) fan_pwm=pwm1
	;;
	1) fan_pwm=pwm2
	;;
	2) fan_pwm=pwm3
	;;
	3) fan_pwm=pwm4
	;;
	*) echo "Error: fan $1 doesn't exit"
		exit 1
	;;
	esac

	set_pwm "$fan_pwm" "$2"
	exit 0
}

function getspeed() {
	# Mapping fan number to TACH and PWM index
	case "$1" in
	0) fan_tach=fan1_input
	 fan_pwm=pwm1
	;;
	1) fan_tach=fan3_input
	 fan_pwm=pwm2
	;;
	2) fan_tach=fan5_input
	 fan_pwm=pwm3
	;;
	3) fan_tach=fan7_input
	 fan_pwm=pwm4
	;;
	*) echo "Error: fan $1 doesn't exit"
		exit 1
	;;
	esac

	# Get fan speed
	read_speed "$1" "$fan_tach" "$fan_pwm"

	exit 0
}

# Usage of this utility
function usage() {
	echo "Usage:"
	echo "  ampere_fanctrl.sh [getstatus] [setstatus <0|1>] [setspeed <fan> <duty>] [getspeed <fan>]"
	echo "  fan: 0-3"
	echo "  duty: 1-100"
}

if [ "$1" == "getstatus" ]; then
    getstatus
elif [ "$1" == "setstatus" ]; then
    setstatus "$2"
elif [ "$1" == "setspeed" ]; then
	setspeed "$2" "$3"
elif [ "$1" == "getspeed" ]; then
	getspeed "$2"
else
	usage
fi
