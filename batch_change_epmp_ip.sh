#!/bin/bash
IP_LIST=(192.168.2.54 192.168.2.58 192.168.2.64 192.168.2.70)
CN_URL="CNMAESTRO_URL"
CN_USER="cnmaestro_on_premises"
CN_PASS="CNMAESTRO_ONBOARDING_KEY"
DNS1="8.8.8.8"
DNS2="8.8.4.4"
SSHPASS="PASSWORD"
SSHCOMMAND="ssh -p 22 -T -o StrictHostKeyChecking=no -o BatchMode=no"
SSHACC="admin"
BRIDGE="INTEGER: 2"
IP_NET="192.168.5."
IP_HOST="10"
NEW_GW="192.168.5.1"

for IP in "${IP_LIST[@]}"
do
        echo "***********************";
        echo "Logging into: ${IP}";
        echo "***********************";
        NEW_IP=$IP_NET.$IP_HOST
        NETWORK_MODE=`snmpget -c private -v 2c -O v ${IP} 1.3.6.1.4.1.17713.21.1.4.4.0`
        snmpset -c private -v 2c ${IP} 1.3.6.1.4.1.17713.21.3.4.7.7.0 a ${DNS1}
        snmpset -c private -v 2c ${IP} 1.3.6.1.4.1.17713.21.3.4.7.8.0 a ${DNS2}
        snmpset -c private -v 2c ${IP} 1.3.6.1.4.1.17713.21.3.20.1.0 i "1"
        snmpset -c private -v 2c ${IP} 1.3.6.1.4.1.17713.21.3.20.2.0 s ${CN_URL}
        snmpset -c private -v 2c ${IP} 1.3.6.1.4.1.17713.21.3.20.3.0 s ${CN_USER}
        snmpset -c private -v 2c ${IP} 1.3.6.1.4.1.17713.21.3.20.4.0 s ${CN_PASS}

        if [ "$NETWORK_MODE" = "$BRIDGE" ]; then
                echo "Network Mode is Bridge"
                sshpass -p "$SSHPASS" $SSHCOMMAND $SSHACC@$IP <<-EOF
                config set networkBridgeIPAddr $NEW_IP
                config set networkBridgeGatewayIP $NEW_GW
                config save
                config apply
                EOF
        else
                echo "Network Mode is NAT"
                sshpass -p "$SSHPASS" $SSHCOMMAND $SSHACC@$IP <<-EOF
                config set mgmtIFIPAddr $NEW_IP
                config set mgmtIFGateway $NEW_GW
                config save
                config apply
                EOF
        fi
        ((IP_HOST++))
done