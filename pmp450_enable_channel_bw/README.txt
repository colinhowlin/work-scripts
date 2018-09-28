1.3.6.1.4.1.161.19.3.2.1.62.0	- uplink data rate
1.3.6.1.4.1.161.19.3.2.1.63.0	- uplink limit
1.3.6.1.4.1.161.19.3.2.1.64.0	- downlink data rate
1.3.6.1.4.1.161.19.3.2.1.65.0	- downlink limit
1.3.6.1.4.1.161.19.3.2.1.129.0	- downlink burst??
1.3.6.1.4.1.161.19.3.2.1.128.0	- uplink burst??


CNMAESTRO:
snmpset -c Canopy -v 2c ${IP} 1.3.6.1.4.1.161.19.3.3.2.257.0 i 1
       
snmpset -c Canopy -v 2c ${IP} 1.3.6.1.4.1.161.19.3.3.2.258.0 s"https://cnmaestro.net.skytel.ie"
       
snmpset -c Canopy -v 2c ${IP} 1.3.6.1.4.1.161.19.3.3.2.259.0 s "cnmaestro_on_premises"
       
snmpset -c Canopy -v 2c ${IP} 1.3.6.1.4.1.161.19.3.3.2.260.0 s "montrea11l"
       
snmpset -c Canopy -v 2c ${IP} 1.3.6.1.4.1.161.19.3.3.13.2.0 a "93.92.8.3"
       
snmpset -c Canopy -v 2c ${IP} 1.3.6.1.4.1.161.19.3.3.13.3.0 a "93.92.8.4"
       
snmpset -c Canopy -v 2c ${IP} 1.3.6.1.4.1.161.19.3.3.3.2.0 i 1


1. Grab list of SM IP's from AP with get_ips.sh script
1.3.6.1.4.1.161.19.3.1.4.1.69.2 - start of SM IP's

2. Ensure SNMP read/write is enabled:Use version for correct firmware:
for IP in $(cat ips.txt);do ./02_enable_snmp_write.pl $IP fem50cTo;done

3. Run 03 script
