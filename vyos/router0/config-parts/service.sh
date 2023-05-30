#!/bin/vbash
# shellcheck shell=bash

# NTP server
delete service ntp allow-client
set service ntp allow-client address '127.0.0.0/8'
set service ntp allow-client address '10.0.0.0/8'
set service ntp allow-client address '172.16.0.0/12'
set service ntp allow-client address '192.168.0.0/16'
delete service ntp server
set service ntp server at.pool.ntp.org

# SSH server
set service ssh disable-password-authentication
set service ssh port '22'

# Prometheus exporter
set service monitoring telegraf prometheus-client

# SNMP server
set service snmp community public authorization ro
set service snmp community public network 10.9.8.0/23
set service snmp community public client  10.5.0.9
set service snmp listen-address 10.9.8.1 port 161
