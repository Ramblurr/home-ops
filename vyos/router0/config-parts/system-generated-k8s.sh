#!/bin/vbash
#
# Ansible managed: system-generated-k8s.sh.j2 modified on 2023-05-26 13:05:29 by ramblurr on quine
#
# shellcheck shell=bash

## cluster-test

set service dhcp-server shared-network-name DATA subnet 10.9.10.0/23 static-mapping cluster-test-cp0-data ip-address '10.9.10.101'
set service dhcp-server shared-network-name DATA subnet 10.9.10.0/23 static-mapping cluster-test-cp0-data mac-address '1a:10:50:00:00:00'
set service dhcp-server shared-network-name MGMT subnet 10.9.8.0/23 static-mapping cluster-test-cp0-mgmt ip-address '10.9.9.101'
set service dhcp-server shared-network-name MGMT subnet 10.9.8.0/23 static-mapping cluster-test-cp0-mgmt mac-address '1a:10:50:00:10:00'

set protocols bgp neighbor 10.9.9.101 address-family ipv4-unicast
set protocols bgp neighbor 10.9.9.101 description 'cluster-test-cp0'
set protocols bgp neighbor 10.9.9.101 remote-as '64512'


set service dhcp-server shared-network-name DATA subnet 10.9.10.0/23 static-mapping cluster-test-cp1-data ip-address '10.9.10.102'
set service dhcp-server shared-network-name DATA subnet 10.9.10.0/23 static-mapping cluster-test-cp1-data mac-address '1a:10:50:00:00:01'
set service dhcp-server shared-network-name MGMT subnet 10.9.8.0/23 static-mapping cluster-test-cp1-mgmt ip-address '10.9.9.102'
set service dhcp-server shared-network-name MGMT subnet 10.9.8.0/23 static-mapping cluster-test-cp1-mgmt mac-address '1a:10:50:00:10:01'

set protocols bgp neighbor 10.9.9.102 address-family ipv4-unicast
set protocols bgp neighbor 10.9.9.102 description 'cluster-test-cp1'
set protocols bgp neighbor 10.9.9.102 remote-as '64512'


set service dhcp-server shared-network-name DATA subnet 10.9.10.0/23 static-mapping cluster-test-cp2-data ip-address '10.9.10.103'
set service dhcp-server shared-network-name DATA subnet 10.9.10.0/23 static-mapping cluster-test-cp2-data mac-address '1a:10:50:00:00:02'
set service dhcp-server shared-network-name MGMT subnet 10.9.8.0/23 static-mapping cluster-test-cp2-mgmt ip-address '10.9.9.103'
set service dhcp-server shared-network-name MGMT subnet 10.9.8.0/23 static-mapping cluster-test-cp2-mgmt mac-address '1a:10:50:00:10:02'

set protocols bgp neighbor 10.9.9.103 address-family ipv4-unicast
set protocols bgp neighbor 10.9.9.103 description 'cluster-test-cp2'
set protocols bgp neighbor 10.9.9.103 remote-as '64512'

## k8s-prod

set service dhcp-server shared-network-name DATA subnet 10.9.10.0/23 static-mapping k8s-prod-cp0-data ip-address '10.9.10.121'
set service dhcp-server shared-network-name DATA subnet 10.9.10.0/23 static-mapping k8s-prod-cp0-data mac-address '1a:10:50:00:01:00'
set service dhcp-server shared-network-name MGMT subnet 10.9.8.0/23 static-mapping k8s-prod-cp0-mgmt ip-address '10.9.9.121'
set service dhcp-server shared-network-name MGMT subnet 10.9.8.0/23 static-mapping k8s-prod-cp0-mgmt mac-address '1a:10:50:00:11:00'

set protocols bgp neighbor 10.9.9.121 address-family ipv4-unicast
set protocols bgp neighbor 10.9.9.121 description 'k8s-prod-cp0'
set protocols bgp neighbor 10.9.9.121 remote-as '64512'


set service dhcp-server shared-network-name DATA subnet 10.9.10.0/23 static-mapping k8s-prod-cp1-data ip-address '10.9.10.122'
set service dhcp-server shared-network-name DATA subnet 10.9.10.0/23 static-mapping k8s-prod-cp1-data mac-address '1a:10:50:00:01:01'
set service dhcp-server shared-network-name MGMT subnet 10.9.8.0/23 static-mapping k8s-prod-cp1-mgmt ip-address '10.9.9.122'
set service dhcp-server shared-network-name MGMT subnet 10.9.8.0/23 static-mapping k8s-prod-cp1-mgmt mac-address '1a:10:50:00:11:01'

set protocols bgp neighbor 10.9.9.122 address-family ipv4-unicast
set protocols bgp neighbor 10.9.9.122 description 'k8s-prod-cp1'
set protocols bgp neighbor 10.9.9.122 remote-as '64512'


set service dhcp-server shared-network-name DATA subnet 10.9.10.0/23 static-mapping k8s-prod-cp2-data ip-address '10.9.10.123'
set service dhcp-server shared-network-name DATA subnet 10.9.10.0/23 static-mapping k8s-prod-cp2-data mac-address '1a:10:50:00:01:02'
set service dhcp-server shared-network-name MGMT subnet 10.9.8.0/23 static-mapping k8s-prod-cp2-mgmt ip-address '10.9.9.123'
set service dhcp-server shared-network-name MGMT subnet 10.9.8.0/23 static-mapping k8s-prod-cp2-mgmt mac-address '1a:10:50:00:11:02'

set protocols bgp neighbor 10.9.9.123 address-family ipv4-unicast
set protocols bgp neighbor 10.9.9.123 description 'k8s-prod-cp2'
set protocols bgp neighbor 10.9.9.123 remote-as '64512'


set service dhcp-server shared-network-name DATA subnet 10.9.10.0/23 static-mapping k8s-prod-cp3-data ip-address '10.9.10.124'
set service dhcp-server shared-network-name DATA subnet 10.9.10.0/23 static-mapping k8s-prod-cp3-data mac-address '1a:10:50:00:01:03'
set service dhcp-server shared-network-name MGMT subnet 10.9.8.0/23 static-mapping k8s-prod-cp3-mgmt ip-address '10.9.9.124'
set service dhcp-server shared-network-name MGMT subnet 10.9.8.0/23 static-mapping k8s-prod-cp3-mgmt mac-address '1a:10:50:00:11:03'

set protocols bgp neighbor 10.9.9.124 address-family ipv4-unicast
set protocols bgp neighbor 10.9.9.124 description 'k8s-prod-cp3'
set protocols bgp neighbor 10.9.9.124 remote-as '64512'


set service dhcp-server shared-network-name DATA subnet 10.9.10.0/23 static-mapping k8s-prod-cp4-data ip-address '10.9.10.125'
set service dhcp-server shared-network-name DATA subnet 10.9.10.0/23 static-mapping k8s-prod-cp4-data mac-address '1a:10:50:00:01:04'
set service dhcp-server shared-network-name MGMT subnet 10.9.8.0/23 static-mapping k8s-prod-cp4-mgmt ip-address '10.9.9.125'
set service dhcp-server shared-network-name MGMT subnet 10.9.8.0/23 static-mapping k8s-prod-cp4-mgmt mac-address '1a:10:50:00:11:04'

set protocols bgp neighbor 10.9.9.125 address-family ipv4-unicast
set protocols bgp neighbor 10.9.9.125 description 'k8s-prod-cp4'
set protocols bgp neighbor 10.9.9.125 remote-as '64512'


set service dhcp-server shared-network-name DATA subnet 10.9.10.0/23 static-mapping k8s-prod-wrk0-data ip-address '10.9.10.130'
set service dhcp-server shared-network-name DATA subnet 10.9.10.0/23 static-mapping k8s-prod-wrk0-data mac-address '1a:10:50:00:01:05'
set service dhcp-server shared-network-name MGMT subnet 10.9.8.0/23 static-mapping k8s-prod-wrk0-mgmt ip-address '10.9.9.130'
set service dhcp-server shared-network-name MGMT subnet 10.9.8.0/23 static-mapping k8s-prod-wrk0-mgmt mac-address '1a:10:50:00:11:05'

set protocols bgp neighbor 10.9.9.130 address-family ipv4-unicast
set protocols bgp neighbor 10.9.9.130 description 'k8s-prod-wrk0'
set protocols bgp neighbor 10.9.9.130 remote-as '64512'


set service dhcp-server shared-network-name DATA subnet 10.9.10.0/23 static-mapping k8s-prod-wrk1-data ip-address '10.9.10.131'
set service dhcp-server shared-network-name DATA subnet 10.9.10.0/23 static-mapping k8s-prod-wrk1-data mac-address '1a:10:50:00:01:06'
set service dhcp-server shared-network-name MGMT subnet 10.9.8.0/23 static-mapping k8s-prod-wrk1-mgmt ip-address '10.9.9.131'
set service dhcp-server shared-network-name MGMT subnet 10.9.8.0/23 static-mapping k8s-prod-wrk1-mgmt mac-address '1a:10:50:00:11:06'

set protocols bgp neighbor 10.9.9.131 address-family ipv4-unicast
set protocols bgp neighbor 10.9.9.131 description 'k8s-prod-wrk1'
set protocols bgp neighbor 10.9.9.131 remote-as '64512'


set service dhcp-server shared-network-name DATA subnet 10.9.10.0/23 static-mapping k8s-prod-wrk2-data ip-address '10.9.10.132'
set service dhcp-server shared-network-name DATA subnet 10.9.10.0/23 static-mapping k8s-prod-wrk2-data mac-address '1a:10:50:00:01:07'
set service dhcp-server shared-network-name MGMT subnet 10.9.8.0/23 static-mapping k8s-prod-wrk2-mgmt ip-address '10.9.9.132'
set service dhcp-server shared-network-name MGMT subnet 10.9.8.0/23 static-mapping k8s-prod-wrk2-mgmt mac-address '1a:10:50:00:11:07'

set protocols bgp neighbor 10.9.9.132 address-family ipv4-unicast
set protocols bgp neighbor 10.9.9.132 description 'k8s-prod-wrk2'
set protocols bgp neighbor 10.9.9.132 remote-as '64512'


set service dhcp-server shared-network-name DATA subnet 10.9.10.0/23 static-mapping k8s-prod-wrk3-data ip-address '10.9.10.133'
set service dhcp-server shared-network-name DATA subnet 10.9.10.0/23 static-mapping k8s-prod-wrk3-data mac-address '1a:10:50:00:01:08'
set service dhcp-server shared-network-name MGMT subnet 10.9.8.0/23 static-mapping k8s-prod-wrk3-mgmt ip-address '10.9.9.133'
set service dhcp-server shared-network-name MGMT subnet 10.9.8.0/23 static-mapping k8s-prod-wrk3-mgmt mac-address '1a:10:50:00:11:08'

set protocols bgp neighbor 10.9.9.133 address-family ipv4-unicast
set protocols bgp neighbor 10.9.9.133 description 'k8s-prod-wrk3'
set protocols bgp neighbor 10.9.9.133 remote-as '64512'


set service dhcp-server shared-network-name DATA subnet 10.9.10.0/23 static-mapping k8s-prod-wrk4-data ip-address '10.9.10.134'
set service dhcp-server shared-network-name DATA subnet 10.9.10.0/23 static-mapping k8s-prod-wrk4-data mac-address '1a:10:50:00:01:09'
set service dhcp-server shared-network-name MGMT subnet 10.9.8.0/23 static-mapping k8s-prod-wrk4-mgmt ip-address '10.9.9.134'
set service dhcp-server shared-network-name MGMT subnet 10.9.8.0/23 static-mapping k8s-prod-wrk4-mgmt mac-address '1a:10:50:00:11:09'

set protocols bgp neighbor 10.9.9.134 address-family ipv4-unicast
set protocols bgp neighbor 10.9.9.134 description 'k8s-prod-wrk4'
set protocols bgp neighbor 10.9.9.134 remote-as '64512'
