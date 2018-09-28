#!/bin/bash

CN_URL="https://cnmaestro-url.com"
CN_USER="cnmaestro_on_premises"
CN_PASS="password"
DNS1="8.8.8.8"
DNS2="8.8.4.4"

for IP in `cat ips.txt`
do
	echo "***********************";
	echo "Logging into: ${IP}";
	echo "***********************";
	snmpset -c private -v 2c ${IP} 1.3.6.1.4.1.17713.21.3.4.7.7.0 a ${DNS1}
	snmpset -c private -v 2c ${IP} 1.3.6.1.4.1.17713.21.3.4.7.8.0 a ${DNS2}
	snmpset -c private -v 2c ${IP} 1.3.6.1.4.1.17713.21.3.20.1.0 i "1"
	snmpset -c private -v 2c ${IP} 1.3.6.1.4.1.17713.21.3.20.2.0 s ${CN_URL}
	snmpset -c private -v 2c ${IP} 1.3.6.1.4.1.17713.21.3.20.3.0 s ${CN_USER}
	snmpset -c private -v 2c ${IP} 1.3.6.1.4.1.17713.21.3.20.4.0 s ${CN_PASS}
	snmpset -c private -v 2c ${IP} 1.3.6.1.4.1.17713.21.4.3.0 i "1"
	snmpset -c private -v 2c ${IP} 1.3.6.1.4.1.17713.21.4.4.0 i "1"
done
