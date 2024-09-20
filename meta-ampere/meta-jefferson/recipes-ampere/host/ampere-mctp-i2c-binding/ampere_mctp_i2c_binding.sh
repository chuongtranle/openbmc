#!/bin/bash
#ampere_platform_config.sh is platform configuration file

# shellcheck disable=SC2046
# shellcheck source=meta-ampere/meta-common/recipes-ampere/platform/ampere-utils/utils-lib.sh
source /usr/sbin/utils-lib.sh

function s0_mctp_ready()
{
    retVal="1"
    output=$(i2cget -f -y 3 0x4f 0)
    ret=$?
    if [ $ret -eq 0 ]; then
        retVal="0"
    fi
    echo "$ret"
}

function add_endpoints()
{
    cnt=20
    retVal="1"
    while [ $cnt -gt 0 ];
    do
        state=$(s0_mctp_ready)
        echo "add_endpoints s0_mctp_ready $state" >> /tmp/mctp_i2c_binding.log
        if [[ "$state" == "0" ]]; then
            output=$(busctl call au.com.codeconstruct.MCTP1 \
                /au/com/codeconstruct/mctp1/interfaces/mctpi2c3 au.com.codeconstruct.MCTP.BusOwner1 \
                SetupEndpoint ay 1 0x4f)
            ret=$?
            echo "add_endpoints create S0 MCTP DBus output $output ret $ret" >> /tmp/mctp_i2c_binding.log
            if [ $ret -eq 0 ]; then
                break;
            fi
        fi
        cnt=$(( cnt - 1 ))
        sleep 1
    done
}

function remove_endpoints()
{
    retVal="1"
    state=$(busctl call au.com.codeconstruct.MCTP1 \
            /au/com/codeconstruct/mctp1/networks/1/endpoints/20 \
            au.com.codeconstruct.MCTP.Endpoint1 Remove)
    ret=$?
    echo "remove_endpoints remove S0 MCTP DBus output $output ret $ret" >> /tmp/mctp_i2c_binding.log
    if [[ $ret -eq 0 ]]; then
        retVal="0"
    fi

    echo "$retVal"
}

if [ "$1" == "add_endpoints" ]; then
	echo "" >> /tmp/mctp_i2c_binding.log
	ret=$(add_endpoints)
elif [ "$1" == "remove_endpoints" ]; then
	ret=$(remove_endpoints)
fi

exit 0
