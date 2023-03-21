#!/bin/vbash

# ISP WAN
set protocols static route 0.0.0.0/0 next-hop "${SECRET_STATIC_WAN_GATEWAY}"

# Inter VLAN routing
# NOT
#set protocols static route 10.8.60.0/23 next-hop 10.255.253.2
# IOT
#set protocols static route 10.8.50.0/23 next-hop 10.255.253.2
# GUEST
#set protocols static route 10.8.3.0/24 next-hop 10.255.253.2

# Tailscale to offsite A
set protocols static route 192.168.8.0/22 next-hop 10.9.4.27

# Tailscale routing
set protocols static route 100.64.0.0/10 next-hop 10.9.4.27

# BGP configuration
#set protocols bgp neighbor 10.1.1.31 address-family ipv4-unicast
#set protocols bgp neighbor 10.1.1.31 description 'delta'
#set protocols bgp neighbor 10.1.1.31 remote-as '64512'
#set protocols bgp neighbor 10.1.1.32 address-family ipv4-unicast
#set protocols bgp neighbor 10.1.1.32 description 'enigma'
#set protocols bgp neighbor 10.1.1.32 remote-as '64512'
#set protocols bgp neighbor 10.1.1.33 address-family ipv4-unicast
#set protocols bgp neighbor 10.1.1.33 description 'felix'
#set protocols bgp neighbor 10.1.1.33 remote-as '64512'
#set protocols bgp parameters router-id '10.1.0.1'
#set protocols bgp system-as '64512'
