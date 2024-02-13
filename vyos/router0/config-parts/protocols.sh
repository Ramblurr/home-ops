#!/bin/vbash
# shellcheck shell=bash

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
set protocols bgp parameters router-id '192.168.1.1'
set protocols bgp system-as '64512'

# k8s nodes that do BGP
set protocols bgp neighbor 10.9.8.21 address-family ipv4-unicast
set protocols bgp neighbor 10.9.8.21 description 'debord'
set protocols bgp neighbor 10.9.8.21 remote-as '64512'

set protocols bgp neighbor 10.9.8.14 address-family ipv4-unicast
set protocols bgp neighbor 10.9.8.14 description 'dewey'
set protocols bgp neighbor 10.9.8.14 remote-as '64512'

set protocols bgp neighbor 10.9.8.13 address-family ipv4-unicast
set protocols bgp neighbor 10.9.8.13 description 'mill'
set protocols bgp neighbor 10.9.8.13 remote-as '64512'

set protocols bgp neighbor 10.9.8.16 address-family ipv4-unicast
set protocols bgp neighbor 10.9.8.16 description 'ibnsina'
set protocols bgp neighbor 10.9.8.16 remote-as '64512'

set protocols bgp neighbor 10.9.8.18 address-family ipv4-unicast
set protocols bgp neighbor 10.9.8.18 description 'peirce'
set protocols bgp neighbor 10.9.8.18 remote-as '64512'
