#!/bin/vbash
# shellcheck shell=bash

set system login user vyos authentication plaintext-password "${SECRET_ADMIN_PASSWORD}"
set system domain-name 'socozy.casa'
set system host-name 'gateway'
set system ipv6 disable-forwarding
set system name-server '45.90.30.124'
set system name-server '45.90.28.124'
set system sysctl parameter kernel.pty.max value '24000'

#set system syslog host 10.45.0.2 facility kern level 'warning'
#set system syslog host 10.45.0.2 facility kern protocol 'tcp'
#set system syslog host 10.45.0.2 port '6001'

set system task-scheduler task backup-config crontab-spec '30 0 * * *'
set system task-scheduler task backup-config executable path '/config/scripts/custom-config-backup.sh'

set system time-zone 'Europe/Berlin'
