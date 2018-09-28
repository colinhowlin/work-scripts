#!/bin/bash

BASE_OID=1.3.6.1.4.1.161.19.3.1.4.1.69
SM_PART=2

IP_LIST=(10.94.51.2 10.94.52.2 10.94.54.2 10.94.55.2 10.94.100.2 10.94.101.2 10.94.102.2)

for IP in "${IP_LIST[@]}"

do
	while [ $SM_PART -lt 150 ]; do
		SM_IP=`snmpget -c sky73L*2016 -v 2c -O qv ${IP} $BASE_OID.$SM_PART`
		if [[ $SM_IP != "No Such Instance currently exists at this OID" ]]; then
			echo $SM_IP
		fi
		((SM_PART++))
	done
	
	SM_PART=2;
done

