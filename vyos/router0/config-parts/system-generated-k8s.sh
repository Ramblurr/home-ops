#!/bin/vbash
#
# Ansible managed: system-generated-k8s.sh.j2 modified on 2023-03-22 14:39:04 by ramblurr on toolbox
#
# shellcheck shell=bash

# k8s dhcp reservations
## cluster-test

set service dhcp-server shared-network-name DATA subnet 10.9.10.0/23 static-mapping cluster-test-cp0-data ip-address '10.9.10.101'
set service dhcp-server shared-network-name DATA subnet 10.9.10.0/23 static-mapping cluster-test-cp0-data mac-address '1a:10:50:00:00:00'
set service dhcp-server shared-network-name MGMT subnet 10.9.8.0/23 static-mapping cluster-test-cp0-mgmt ip-address '10.9.9.101'
set service dhcp-server shared-network-name MGMT subnet 10.9.8.0/23 static-mapping cluster-test-cp0-mgmt mac-address '1a:10:50:00:10:00'


set service dhcp-server shared-network-name DATA subnet 10.9.10.0/23 static-mapping cluster-test-cp1-data ip-address '10.9.10.102'
set service dhcp-server shared-network-name DATA subnet 10.9.10.0/23 static-mapping cluster-test-cp1-data mac-address '1a:10:50:00:00:01'
set service dhcp-server shared-network-name MGMT subnet 10.9.8.0/23 static-mapping cluster-test-cp1-mgmt ip-address '10.9.9.102'
set service dhcp-server shared-network-name MGMT subnet 10.9.8.0/23 static-mapping cluster-test-cp1-mgmt mac-address '1a:10:50:00:10:01'


set service dhcp-server shared-network-name DATA subnet 10.9.10.0/23 static-mapping cluster-test-cp2-data ip-address '10.9.10.103'
set service dhcp-server shared-network-name DATA subnet 10.9.10.0/23 static-mapping cluster-test-cp2-data mac-address '1a:10:50:00:00:02'
set service dhcp-server shared-network-name MGMT subnet 10.9.8.0/23 static-mapping cluster-test-cp2-mgmt ip-address '10.9.9.103'
set service dhcp-server shared-network-name MGMT subnet 10.9.8.0/23 static-mapping cluster-test-cp2-mgmt mac-address '1a:10:50:00:10:02'
