#!/bin/vbash
# shellcheck shell=bash

# Gateway
set system static-host-mapping host-name gateway.${SECRET_DOMAIN} inet 192.168.1.1

# Unifi controller
set system static-host-mapping host-name unifi inet 192.168.1.2

# NAS
set system static-host-mapping host-name mali.int.${SECRET_DOMAIN} inet 10.9.4.10
set system static-host-mapping host-name mali.data.${SECRET_DOMAIN} inet 10.9.10.10

# Kubernetes hosts
#set system static-host-mapping host-name delta.${SECRET_DOMAIN} inet 10.1.1.31

# Kubernetes cluster VIP
#set system static-host-mapping host-name cluster-0.${SECRET_DOMAIN} inet 10.5.0.2
