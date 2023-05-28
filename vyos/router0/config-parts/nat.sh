#!/bin/vbash
# shellcheck shell=bash

# Forward HTTP(S) to ingress
# set nat destination rule 100 description 'HTTPS'
# set nat destination rule 100 destination port '443'
# set nat destination rule 100 inbound-interface 'eth0'
# set nat destination rule 100 protocol 'tcp'
# set nat destination rule 100 translation address "10.10.12.1"
# set nat destination rule 100 translation port '443'
#
# set nat destination rule 101 description 'HTTP'
# set nat destination rule 101 destination port '80'
# set nat destination rule 101 inbound-interface 'eth0'
# set nat destination rule 101 protocol 'tcp'
# set nat destination rule 101 translation address "10.10.12.1"
# set nat destination rule 101 translation port '80'


# Force DNS
set nat destination rule 102 description 'Force DNS for IoT'
set nat destination rule 102 destination address '!10.8.50.1'
set nat destination rule 102 destination port '53'
set nat destination rule 102 inbound-interface 'eth3.50'
set nat destination rule 102 protocol 'tcp_udp'
set nat destination rule 102 translation address '10.5.0.4'
set nat destination rule 102 translation port '53'

set nat destination rule 103 description 'Force DNS for NoT'
set nat destination rule 103 destination address '!10.8.60.1'
set nat destination rule 103 destination port '53'
set nat destination rule 103 inbound-interface 'eth3.60'
set nat destination rule 103 protocol 'tcp_udp'
set nat destination rule 103 translation address '10.5.0.4'
set nat destination rule 103 translation port '53'


# Force NTP
set nat destination rule 104 description 'Force NTP for LAN'
set nat destination rule 104 destination address '!192.168.1.1'
set nat destination rule 104 destination port '123'
set nat destination rule 104 inbound-interface 'eth3'
set nat destination rule 104 protocol 'udp'
set nat destination rule 104 translation address '192.168.1.1'
set nat destination rule 104 translation port '123'

set nat destination rule 105 description 'Force NTP for PRIMARY'
set nat destination rule 105 destination address '!10.9.4.1'
set nat destination rule 105 destination port '123'
set nat destination rule 105 inbound-interface 'eth3.4'
set nat destination rule 105 protocol 'udp'
set nat destination rule 105 translation address '10.9.4.1'
set nat destination rule 105 translation port '123'

set nat destination rule 106 description 'Force NTP for MGMT'
set nat destination rule 106 destination address '!10.9.8.1'
set nat destination rule 106 destination port '123'
set nat destination rule 106 inbound-interface 'eth3.9'
set nat destination rule 106 protocol 'udp'
set nat destination rule 106 translation address '10.9.8.1'
set nat destination rule 106 translation port '123'

set nat destination rule 107 description 'Force NTP for DATA'
set nat destination rule 107 destination address '!10.9.10.1'
set nat destination rule 107 destination port '123'
set nat destination rule 107 inbound-interface 'eth3.11'
set nat destination rule 107 protocol 'udp'
set nat destination rule 107 translation address '10.9.10.1'
set nat destination rule 107 translation port '123'

set nat destination rule 108 description 'Force NTP for IOT'
set nat destination rule 108 destination address '!10.8.50.1'
set nat destination rule 108 destination port '123'
set nat destination rule 108 inbound-interface 'eth3.50'
set nat destination rule 108 protocol 'udp'
set nat destination rule 108 translation address '10.8.50.1'
set nat destination rule 108 translation port '123'

set nat destination rule 109 description 'Force NTP for NOT'
set nat destination rule 109 destination address '!10.8.60.1'
set nat destination rule 109 destination port '123'
set nat destination rule 109 inbound-interface 'eth3.60'
set nat destination rule 109 protocol 'udp'
set nat destination rule 109 translation address '10.8.60.1'
set nat destination rule 109 translation port '123'

set nat destination rule 110 description 'Force NTP for NOT'
set nat destination rule 110 destination address '!10.8.3.1'
set nat destination rule 110 destination port '123'
set nat destination rule 110 inbound-interface 'eth3.3'
set nat destination rule 110 protocol 'udp'
set nat destination rule 110 translation address '10.8.3.1'
set nat destination rule 110 translation port '123'

# Forward Roon ARC to Rock
set nat destination rule 111 description 'Roon ARC TCP'
set nat destination rule 111 destination port '33399'
set nat destination rule 111 inbound-interface 'eth0'
set nat destination rule 111 protocol 'tcp'
set nat destination rule 111 translation address '10.9.6.23'
set nat destination rule 111 translation port '33399'

set nat destination rule 112 description 'Roon ARC UDP'
set nat destination rule 112 destination port '33399'
set nat destination rule 112 inbound-interface 'eth0'
set nat destination rule 112 protocol 'udp'
set nat destination rule 112 translation address '10.9.6.23'
set nat destination rule 112 translation port '33399'

# Mali zrepl replication
set nat destination rule 113 description 'mali zrepl replication'
set nat destination rule 113 destination port '3478'
set nat destination rule 113 inbound-interface 'eth0'
set nat destination rule 113 protocol 'tcp'
set nat destination rule 113 translation address '10.9.10.10'
#set nat destination rule 113 translation address '10.9.10.17'
set nat destination rule 113 translation port '3478'

# LAN -> WAN masquerade
set nat source rule 100 description 'LAN -> WAN'
set nat source rule 100 destination address '0.0.0.0/0'
set nat source rule 100 outbound-interface 'eth0'
set nat source rule 100 translation address 'masquerade'
