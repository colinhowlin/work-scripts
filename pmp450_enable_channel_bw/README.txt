IP 1.3.6.1.4.1.161.19.3.2.1.11.0
snmpset - c Canopy -v 2c ${IP} 1.3.6.1.4.1.161.19.3.2.1.11.0 

GW 1.3.6.1.4.1.161.19.3.2.1.5.0

CNMAESTRO OID's:
1. Enable cnMaestro
snmpset -c Canopy -v 2c ${IP} 1.3.6.1.4.1.161.19.3.3.2.257.0 i 1

2. cnMaestro URL       
snmpset -c Canopy -v 2c ${IP} 1.3.6.1.4.1.161.19.3.3.2.258.0 s "cnMaestro URL"

3. cnMaestro OnBoarding name       
snmpset -c Canopy -v 2c ${IP} 1.3.6.1.4.1.161.19.3.3.2.259.0 s "cnmaestro_on_premises"

4. cnMaestro Password       
snmpset -c Canopy -v 2c ${IP} 1.3.6.1.4.1.161.19.3.3.2.260.0 s "cnMaestro Pasword"

5. DNS1       
snmpset -c Canopy -v 2c ${IP} 1.3.6.1.4.1.161.19.3.3.13.2.0 a "DNS1"

6. DNS2       
snmpset -c Canopy -v 2c ${IP} 1.3.6.1.4.1.161.19.3.3.13.3.0 a "DNS2"

7. Reboot device       
snmpset -c Canopy -v 2c ${IP} 1.3.6.1.4.1.161.19.3.3.3.2.0 i 1

STEPS TO RUN SCRIPTS
1. Grab list of SM IP's from AP'S with get_ips.sh script:
	bash 01_get_ips.sh > ips.txt

2. Ensure SNMP read/write is enabled. Use version for correct firmware:
for IP in $(cat ips.txt);do ./02_enable_snmp_write.pl $IP $devicePassword;done

3. Run script to change channel bandwidth:
	bash 03_enable_30MHz_40MHz.sh
