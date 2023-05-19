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
# note: k8s neighbors are in system-generated-k8s.sh
set protocols bgp parameters router-id '192.168.1.1'
set protocols bgp system-as '64512'
