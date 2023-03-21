#!/bin/vbash

# Container networks
set container network services prefix '10.5.0.0/24'

# haproxy-k8s-api
set container name haproxy-k8s-api image 'docker.io/library/haproxy:2.7.5'
set container name haproxy-k8s-api memory '0'
set container name haproxy-k8s-api network services address '10.5.0.2'
set container name haproxy-k8s-api restart 'on-failure'
set container name haproxy-k8s-api shared-memory '0'
set container name haproxy-k8s-api volume config destination '/usr/local/etc/haproxy/haproxy.cfg'
set container name haproxy-k8s-api volume config source '/config/containers/haproxy/config/haproxy.cfg'
set container name haproxy-k8s-api volume config mode 'ro'

# node-exporter
set container name node-exporter environment procfs value '/host/proc'
set container name node-exporter environment rootfs value '/host/rootfs'
set container name node-exporter environment sysfs value '/host/sys'
set container name node-exporter image 'quay.io/prometheus/node-exporter:v1.5.0'
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
set container name speedtest-exporter image 'ghcr.io/miguelndecarvalho/speedtest-exporter:v3.5.3'
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
