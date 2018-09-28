#!/bin/bash

BASE_OID=1.3.6.1.4.1.161.19.3.1.4.1.69
SM_PART=2
COMMUNITY="SNMP_COMMUNITY_STRING"

IP_LIST=(192.168.1.2 192.168.2.2 192.168.3.2)

for IP in "${IP_LIST[@]}"

do
	while [ $SM_PART -lt 150 ]; do
		SM_IP=`snmpget -c $COMMUNITY -v 2c -O qv ${IP} $BASE_OID.$SM_PART`
		if [[ $SM_IP != "No Such Instance currently exists at this OID" ]]; then
			echo $SM_IP
		fi
		((SM_PART++))
	done
	
	SM_PART=2;
done

