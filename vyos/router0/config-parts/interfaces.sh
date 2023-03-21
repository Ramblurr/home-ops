#!/bin/vbash

echo "setting wan"
set interfaces ethernet eth0 description 'WAN'
set interfaces ethernet eth0 hw-id "${SECRET_ETH0_MAC}"
set interfaces ethernet eth0 address "${SECRET_STATIC_WAN_CIDR}"

echo "setting lan"
# eth3 is the right most SFP+ port
set interfaces ethernet eth3 address '192.168.1.1/24'
set interfaces ethernet eth3 description 'LAN'
set interfaces ethernet eth3 hw-id "${SECRET_ETH1_MAC}"
set interfaces ethernet eth3 mtu 9000
set interfaces ethernet eth3 vif 3 address '10.8.3.1/24'
set interfaces ethernet eth3 vif 3 description 'GUEST'
set interfaces ethernet eth3 vif 3 mtu 1500
set interfaces ethernet eth3 vif 4 address '10.9.4.1/22'
set interfaces ethernet eth3 vif 4 description 'PRIMARY'
set interfaces ethernet eth3 vif 4 mtu 1500
set interfaces ethernet eth3 vif 9 address '10.9.8.1/23'
set interfaces ethernet eth3 vif 9 description 'MGMT'
set interfaces ethernet eth3 vif 9 mtu 1500
set interfaces ethernet eth3 vif 11 address '10.9.10.1/23'
set interfaces ethernet eth3 vif 11 description 'DATA'
set interfaces ethernet eth3 vif 11 mtu 9000
set interfaces ethernet eth3 vif 50 address '10.8.50.1/23'
set interfaces ethernet eth3 vif 50 description 'IOT'
set interfaces ethernet eth3 vif 50 mtu 1500
set interfaces ethernet eth3 vif 60 address '10.8.60.1/23'
set interfaces ethernet eth3 vif 60 description 'NOT'
set interfaces ethernet eth3 vif 60 mtu 1500
#set interfaces ethernet eth3 vif 4040 address '10.255.253.1/24'
#set interfaces ethernet eth3 vif 4040 description 'INTER-VLAN-ROUTING'

echo "setting eth1"
# eth1 is the left most SFP+ port
#set interfaces ethernet eth1 address '192.168.1.0/24'
set interfaces ethernet eth1 description 'LAN2'
set interfaces ethernet eth1 hw-id "${SECRET_ETH3_MAC}"
