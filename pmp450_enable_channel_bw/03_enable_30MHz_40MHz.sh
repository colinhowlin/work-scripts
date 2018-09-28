#!/bin/bash


#For PMP450 Firmware 15.1.3

for IP in `cat ips.txt`

do
	echo "Logging in to : ${IP}";

	snmpset -c Canopy -v 2c ${IP} 1.3.6.1.4.1.161.19.3.2.1.131.0 s "15 MHz, 20 MHz, 30 MHz, 40 MHz"  #Set channel bandwidth

done
