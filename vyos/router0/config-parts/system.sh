#!/bin/vbash
# shellcheck shell=bash

set system login user vyos authentication plaintext-password "${SECRET_ADMIN_PASSWORD}"
set system domain-name "${SECRET_DOMAIN}"
set system host-name 'gateway'
set system ipv6 disable-forwarding
set system name-server "${SECRET_DNS1}"
set system name-server "${SECRET_DNS2}"
set system sysctl parameter kernel.pty.max value '24000'

set system syslog host 10.10.12.7 facility kern level 'warning'
set system syslog host 10.10.12.7 protocol 'tcp'
set system syslog host 10.10.12.7 port '6001'
set system syslog host 10.10.12.7 format 'octet-counted'

set system task-scheduler task backup-config crontab-spec '30 0 * * *'
set system task-scheduler task backup-config executable path '/config/scripts/custom-config-backup.sh'

set system time-zone 'Europe/Berlin'
