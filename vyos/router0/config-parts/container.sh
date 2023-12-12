#!/bin/vbash
# shellcheck shell=bash

# Container networks
set container network services prefix '10.5.0.0/24'

# haproxy-k8s-api
set container name haproxy-k8s-api image 'docker.io/library/haproxy:2.9.1'
set container name haproxy-k8s-api memory '0'
set container name haproxy-k8s-api network services address '10.5.0.2'
set container name haproxy-k8s-api restart 'on-failure'
set container name haproxy-k8s-api shared-memory '0'
set container name haproxy-k8s-api volume config destination '/usr/local/etc/haproxy/haproxy.cfg'
set container name haproxy-k8s-api volume config source '/config/containers/haproxy/config/haproxy.cfg'
set container name haproxy-k8s-api volume config mode 'ro'

# smtp-relay
set container name smtp-relay image 'ghcr.io/foxcpp/maddy:0.7.0'
set container name smtp-relay environment SMTP_DOMAIN value "${SECRET_SMTP_FROM_DOMAIN}"
set container name smtp-relay environment SMTP_PASSWORD value "${SECRET_SMTP_PASSWORD}"
set container name smtp-relay environment SMTP_PORT value "${SECRET_SMTP_PORT}"
set container name smtp-relay environment SMTP_SERVER value "${SECRET_SMTP_HOST}"
set container name smtp-relay environment SMTP_USERNAME value "${SECRET_SMTP_USERNAME}"
set container name smtp-relay environment SMTP_DOMAIN_WORK value "${SECRET_SMTP_FROM_DOMAIN_WORK}"
set container name smtp-relay environment SMTP_PASSWORD_WORK value "${SECRET_SMTP_PASSWORD_WORK}"
set container name smtp-relay environment SMTP_PORT_WORK value "${SECRET_SMTP_PORT_WORK}"
set container name smtp-relay environment SMTP_SERVER_WORK value "${SECRET_SMTP_HOST_WORK}"
set container name smtp-relay environment SMTP_USERNAME_WORK value "${SECRET_SMTP_USERNAME_WORK}"
set container name smtp-relay restart 'on-failure'
set container name smtp-relay memory '0'
set container name smtp-relay network services address '10.5.0.3'
set container name smtp-relay shared-memory '0'
set container name smtp-relay volume smtp-relay-config destination '/data/maddy.conf'
set container name smtp-relay volume smtp-relay-config mode 'ro'
set container name smtp-relay volume smtp-relay-config source '/config/containers/smtp-relay/config/maddy.conf'


# dnsdist
set container name dnsdist cap-add 'net-bind-service'
set container name dnsdist environment TZ value 'Europe/Berlin'
set container name dnsdist image 'docker.io/powerdns/dnsdist-18:1.8.3'
set container name dnsdist arguments '--log-timestamps'
set container name dnsdist memory '0'
set container name dnsdist network services address '10.5.0.4'
set container name dnsdist restart 'on-failure'
set container name dnsdist shared-memory '0'
set container name dnsdist volume config source '/config/containers/dnsdist/config/dnsdist.conf'
set container name dnsdist volume config destination '/etc/dnsdist/dnsdist.conf'
set container name dnsdist volume config mode 'ro'

# node-exporter
set container name node-exporter environment procfs value '/host/proc'
set container name node-exporter environment rootfs value '/host/rootfs'
set container name node-exporter environment sysfs value '/host/sys'
set container name node-exporter image 'quay.io/prometheus/node-exporter:v1.7.0'
set container name node-exporter memory '0'
set container name node-exporter network services address '10.5.0.7'
set container name node-exporter restart 'on-failure'
set container name node-exporter shared-memory '0'
set container name node-exporter volume procfs destination '/host/proc'
set container name node-exporter volume procfs mode 'ro'
set container name node-exporter volume procfs source '/proc'
set container name node-exporter volume rootfs destination '/host/rootfs'
set container name node-exporter volume rootfs mode 'ro'
set container name node-exporter volume rootfs source '/'
set container name node-exporter volume sysfs destination '/host/sys'
set container name node-exporter volume sysfs mode 'ro'
set container name node-exporter volume sysfs source '/sys'

# speedtest-exporter
set container name speedtest-exporter image 'ghcr.io/miguelndecarvalho/speedtest-exporter:v3.5.4'
set container name speedtest-exporter memory '0'
set container name speedtest-exporter network services address '10.5.0.8'
set container name speedtest-exporter restart 'on-failure'
set container name speedtest-exporter shared-memory '0'
set container name speedtest-exporter volume vyosresolv destination '/etc/hosts'
set container name speedtest-exporter volume vyosresolv source '/etc/resolv.conf'
set container name speedtest-exporter volume vyosresolv mode 'ro'

# udp-broadcast-relay-mdns
set container name udp-broadcast-relay-mdns allow-host-networks
set container name udp-broadcast-relay-mdns cap-add 'net-raw'
set container name udp-broadcast-relay-mdns environment CFG_DEV value 'eth3.4;eth3.50'
set container name udp-broadcast-relay-mdns environment CFG_ID value '2'
set container name udp-broadcast-relay-mdns environment CFG_MULTICAST value '224.0.0.251'
set container name udp-broadcast-relay-mdns environment CFG_PORT value '5353'
set container name udp-broadcast-relay-mdns environment SEPARATOR value ';'
set container name udp-broadcast-relay-mdns image 'ghcr.io/onedr0p/udp-broadcast-relay-redux:1.0.27'
set container name udp-broadcast-relay-mdns memory '0'
set container name udp-broadcast-relay-mdns restart 'on-failure'
set container name udp-broadcast-relay-mdns shared-memory '0'

# udp-broadcast-relay-roon
set container name udp-broadcast-relay-roon allow-host-networks
set container name udp-broadcast-relay-roon cap-add 'net-raw'
set container name udp-broadcast-relay-roon environment CFG_DEV value 'eth3.4;eth3.50'
set container name udp-broadcast-relay-roon environment CFG_ID value '1'
set container name udp-broadcast-relay-roon environment CFG_PORT value '9003'
set container name udp-broadcast-relay-roon environment SEPARATOR value ';'
set container name udp-broadcast-relay-roon image 'ghcr.io/onedr0p/udp-broadcast-relay-redux:1.0.27'
set container name udp-broadcast-relay-roon memory '0'
set container name udp-broadcast-relay-roon restart 'on-failure'
set container name udp-broadcast-relay-roon shared-memory '0'

# udp-broadcast-relay-syncthing
set container name udp-broadcast-relay-syncthing allow-host-networks
set container name udp-broadcast-relay-syncthing cap-add 'net-raw'
set container name udp-broadcast-relay-syncthing environment CFG_DEV value 'eth3.4;eth3'
set container name udp-broadcast-relay-syncthing environment CFG_ID value '3'
set container name udp-broadcast-relay-syncthing environment CFG_PORT value '21027'
set container name udp-broadcast-relay-syncthing environment SEPARATOR value ';'
set container name udp-broadcast-relay-syncthing image 'ghcr.io/onedr0p/udp-broadcast-relay-redux:1.0.27'
set container name udp-broadcast-relay-syncthing memory '0'
set container name udp-broadcast-relay-syncthing restart 'on-failure'
set container name udp-broadcast-relay-syncthing shared-memory '0'


# snmp-exporter
set container name snmp-exporter image 'quay.io/prometheus/snmp-exporter:v0.25.0'
set container name snmp-exporter memory '0'
set container name snmp-exporter network services address '10.5.0.9'
set container name snmp-exporter restart 'on-failure'
set container name snmp-exporter shared-memory '0'
