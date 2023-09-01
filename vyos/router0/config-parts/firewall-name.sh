#!/bin/vbash
# shellcheck shell=bash

# From GUEST to IOT
set firewall name guest-iot default-action 'drop'
set firewall name guest-iot description 'From GUEST to IOT'
set firewall name guest-iot enable-default-log

# From GUEST to NOT
set firewall name guest-not default-action 'drop'
set firewall name guest-not description 'From GUEST to NOT'
set firewall name guest-not enable-default-log

# From GUEST to LAN
set firewall name guest-lan default-action 'drop'
set firewall name guest-lan description 'From GUEST to LAN'
set firewall name guest-lan enable-default-log

set firewall name guest-lan rule 1 action 'accept'
set firewall name guest-lan rule 1 description 'Rule: accept_dns'
set firewall name guest-lan rule 1 destination port 'domain,domain-s'
set firewall name guest-lan rule 1 destination group address-group 'local-dns-servers'
set firewall name guest-lan rule 1 protocol 'tcp_udp'

# From GUEST to DATA
set firewall name guest-data default-action 'drop'
set firewall name guest-data description 'From GUEST to DATA'
set firewall name guest-data enable-default-log

# From GUEST to LOCAL
set firewall name guest-local default-action 'drop'
set firewall name guest-local description 'From GUEST to LOCAL'
set firewall name guest-local enable-default-log
set firewall name guest-local rule 1 action 'accept'
set firewall name guest-local rule 1 description 'Rule: accept_dhcp'
set firewall name guest-local rule 1 destination port '67,68'
set firewall name guest-local rule 1 protocol 'udp'
set firewall name guest-local rule 1 source port '67,68'

# From GUEST to MGMT
set firewall name guest-mgmt default-action 'drop'
set firewall name guest-mgmt description 'From GUEST to MGMT'
set firewall name guest-mgmt enable-default-log

# From GUEST to SERVICES
set firewall name guest-services default-action 'drop'
set firewall name guest-services description 'From GUEST to SERVICES'
set firewall name guest-services enable-default-log
set firewall name guest-services rule 1 action 'accept'
set firewall name guest-services rule 1 description 'Rule: accept_dns'
set firewall name guest-services rule 1 destination port 'domain,domain-s'
set firewall name guest-services rule 1 protocol 'tcp_udp'

# From GUEST to PRIMARY
set firewall name guest-primary default-action 'drop'
set firewall name guest-primary description 'From GUEST to PRIMARY'
set firewall name guest-primary enable-default-log

set firewall name guest-primary rule 1 action 'accept'
set firewall name guest-primary rule 1 description 'Rule: accept_dns'
set firewall name guest-primary rule 1 destination port 'domain,domain-s'
set firewall name guest-primary rule 1 destination group address-group 'local-dns-servers'
set firewall name guest-primary rule 1 protocol 'tcp_udp'

# From GUEST to WAN
set firewall name guest-wan default-action 'accept'
set firewall name guest-wan description 'From GUEST to WAN'

# From IOT to GUEST
set firewall name iot-guest default-action 'drop'
set firewall name iot-guest description 'From IOT to GUEST'
set firewall name iot-guest enable-default-log

# From IOT to NOT
set firewall name iot-not default-action 'drop'
set firewall name iot-not description 'From IOT to NOT'
set firewall name iot-not enable-default-log

# From IOT to LAN
set firewall name iot-lan default-action 'drop'
set firewall name iot-lan description 'From IOT to LAN'
set firewall name iot-lan enable-default-log

set firewall name iot-lan rule 1 action 'accept'
set firewall name iot-lan rule 1 description 'Rule: accept_dns'
set firewall name iot-lan rule 1 destination port 'domain,domain-s'
set firewall name iot-lan rule 1 destination group address-group 'local-dns-servers'
set firewall name iot-lan rule 1 protocol 'tcp_udp'
set firewall name iot-lan rule 2 action 'accept'
set firewall name iot-lan rule 2 description 'Rule: accept_icmp_to_dns'
set firewall name iot-lan rule 2 protocol 'icmp'
set firewall name iot-lan rule 2 destination group address-group 'local-dns-servers'

# From IOT to LOCAL
set firewall name iot-local default-action 'drop'
set firewall name iot-local description 'From IOT to LOCAL'
set firewall name iot-local enable-default-log
set firewall name iot-local rule 1 action 'accept'
set firewall name iot-local rule 1 description 'Rule: accept_ssh'
set firewall name iot-local rule 1 destination port 'ssh'
set firewall name iot-local rule 1 protocol 'tcp'
set firewall name iot-local rule 2 action 'accept'
set firewall name iot-local rule 2 description 'Rule: accept_ntp'
set firewall name iot-local rule 2 destination port 'ntp'
set firewall name iot-local rule 2 protocol 'udp'
set firewall name iot-local rule 3 action 'accept'
set firewall name iot-local rule 3 description 'Rule: accept_dhcp'
set firewall name iot-local rule 3 destination port '67,68'
set firewall name iot-local rule 3 protocol 'udp'
set firewall name iot-local rule 3 source port '67,68'
set firewall name iot-local rule 4 action 'accept'
set firewall name iot-local rule 4 description 'Rule: accept_igmp'
set firewall name iot-local rule 4 protocol '2'
set firewall name iot-local rule 5 action 'accept'
set firewall name iot-local rule 5 description 'Rule: accept_mdns'
set firewall name iot-local rule 5 destination port 'mdns'
set firewall name iot-local rule 5 protocol 'udp'
set firewall name iot-local rule 5 source port 'mdns'
set firewall name iot-local rule 6 action 'accept'
set firewall name iot-local rule 6 description 'Rule: accept_from_bluesound'
set firewall name iot-local rule 6 destination group port-group 'bluesound'
set firewall name iot-local rule 6 protocol 'tcp_udp'
set firewall name iot-local rule 6 source group address-group 'bluesound'
set firewall name iot-local rule 7 action 'accept'
set firewall name iot-local rule 7 description 'Rule: accept_from_roon'
set firewall name iot-local rule 7 destination group port-group 'roon'
set firewall name iot-local rule 7 protocol 'tcp_udp'
set firewall name iot-local rule 7 source group address-group 'roon'
set firewall name iot-local rule 8 action 'accept'
set firewall name iot-local rule 8 description 'Rule: accept_icmp'
set firewall name iot-local rule 8 protocol 'icmp'

set firewall name iot-local rule 9 action 'accept'
set firewall name iot-local rule 9 description 'Rule: accept_mdns'
set firewall name iot-local rule 9 destination port '5353'
set firewall name iot-local rule 9 protocol 'tcp_udp'
set firewall name iot-local rule 9 destination address '224.0.0.251'

# From IOT to MGMT
set firewall name iot-mgmt default-action 'drop'
set firewall name iot-mgmt description 'From IOT to MGMT'
set firewall name iot-mgmt enable-default-log

set firewall name iot-mgmt rule 1 action 'accept'
set firewall name iot-mgmt rule 1 description 'Rule: accept_wall_dashboard_to_k8s_ingress'
set firewall name iot-mgmt rule 1 source group address-group 'wall-dashboards'
set firewall name iot-mgmt rule 1 destination group address-group 'k8s_cluster_prod_ingress_all'
set firewall name iot-mgmt rule 1 destination port 'http,https'
set firewall name iot-mgmt rule 1 protocol 'tcp'

# From IOT to SERVICES
set firewall name iot-services default-action 'drop'
set firewall name iot-services description 'From IOT to SERVICES'
set firewall name iot-services enable-default-log
set firewall name iot-services rule 1 action 'accept'
set firewall name iot-services rule 1 description 'Rule: accept_dns'
set firewall name iot-services rule 1 destination port 'domain,domain-s'
set firewall name iot-services rule 1 protocol 'tcp_udp'

# From IOT to PRIMARY
set firewall name iot-primary default-action 'drop'
set firewall name iot-primary description 'From IOT to PRIMARY'
set firewall name iot-primary enable-default-log
set firewall name iot-primary rule 1 action 'accept'
set firewall name iot-primary rule 1 description 'Rule: accept_dns'
set firewall name iot-primary rule 1 destination port 'domain,domain-s'
set firewall name iot-primary rule 1 destination group address-group 'local-dns-servers'
set firewall name iot-primary rule 1 protocol 'tcp_udp'
set firewall name iot-primary rule 2 action 'accept'
set firewall name iot-primary rule 2 description 'Rule: accept_bluesound'
set firewall name iot-primary rule 2 destination group address-group 'bluesound'
set firewall name iot-primary rule 2 destination group port-group 'bluesound'
set firewall name iot-primary rule 2 protocol 'tcp_udp'
set firewall name iot-primary rule 3 action 'accept'
set firewall name iot-primary rule 3 description 'Rule: accept_roon'
set firewall name iot-primary rule 3 destination group address-group 'roon'
set firewall name iot-primary rule 3 destination group port-group 'roon'
set firewall name iot-primary rule 3 protocol 'tcp_udp'
set firewall name iot-primary rule 4 action 'accept'
set firewall name iot-primary rule 4 description 'Rule: accept_octoprint_to_homeassistant'
set firewall name iot-primary rule 4 destination group address-group 'homeassistant'
set firewall name iot-primary rule 4 protocol 'tcp_udp'
set firewall name iot-primary rule 4 source group address-group 'octoprint'
set firewall name iot-primary rule 5 action 'accept'
set firewall name iot-primary rule 5 description 'Rule: accept_icmp_to_dns'
set firewall name iot-primary rule 5 protocol 'icmp'
set firewall name iot-primary rule 5 destination group address-group 'local-dns-servers'
set firewall name iot-primary rule 6 action 'accept'
set firewall name iot-primary rule 6 description 'Rule: accept_wall_dashboard_to_homeassistant'
set firewall name iot-primary rule 6 source group address-group 'wall-dashboards'
set firewall name iot-primary rule 6 destination group address-group 'homeassistant'
set firewall name iot-primary rule 6 destination group port-group 'homeassistant'
set firewall name iot-primary rule 6 protocol 'tcp_udp'


# From IOT to DATA
set firewall name iot-data default-action 'drop'
set firewall name iot-data description 'From IOT to DATA'
set firewall name iot-data enable-default-log

# From IOT to WAN
set firewall name iot-wan default-action 'accept'
set firewall name iot-wan description 'From IOT to WAN'

#### NOT

# From NOT to GUEST
set firewall name not-guest default-action 'drop'
set firewall name not-guest description 'From NOT to GUEST'
set firewall name not-guest enable-default-log

# From NOT to iot
set firewall name not-iot default-action 'drop'
set firewall name not-iot description 'From NOT to IOT'
set firewall name not-iot enable-default-log

# From NOT to LAN
set firewall name not-lan default-action 'drop'
set firewall name not-lan description 'From NOT to LAN'
set firewall name not-lan enable-default-log

set firewall name not-lan rule 1 action 'accept'
set firewall name not-lan rule 1 description 'Rule: accept_dns'
set firewall name not-lan rule 1 destination port 'domain,domain-s'
set firewall name not-lan rule 1 destination group address-group 'local-dns-servers'
set firewall name not-lan rule 1 protocol 'tcp_udp'

set firewall name not-lan rule 2 action 'accept'
set firewall name not-lan rule 2 description 'Rule: accept_icmp_to_dns'
set firewall name not-lan rule 2 protocol 'icmp'
set firewall name not-lan rule 2 destination group address-group 'local-dns-servers'

# From NOT to LOCAL
set firewall name not-local default-action 'drop'
set firewall name not-local description 'From NOT to LOCAL'
set firewall name not-local enable-default-log
set firewall name not-local rule 2 action 'accept'
set firewall name not-local rule 2 description 'Rule: accept_ntp'
set firewall name not-local rule 2 destination port 'ntp'
set firewall name not-local rule 2 protocol 'udp'
set firewall name not-local rule 3 action 'accept'
set firewall name not-local rule 3 description 'Rule: accept_dhcp'
set firewall name not-local rule 3 destination port '67,68'
set firewall name not-local rule 3 protocol 'udp'
set firewall name not-local rule 3 source port '67,68'
set firewall name not-local rule 4 action 'accept'
set firewall name not-local rule 4 description 'Rule: accept_igmp'
set firewall name not-local rule 4 protocol '2'
set firewall name not-local rule 5 action 'accept'
set firewall name not-local rule 5 description 'Rule: accept_mdns'
set firewall name not-local rule 5 destination port 'mdns'
set firewall name not-local rule 5 protocol 'udp'
set firewall name not-local rule 5 source port 'mdns'
set firewall name not-local rule 6 action 'accept'
set firewall name not-local rule 7 action 'accept'
set firewall name not-local rule 7 description 'Rule: accept_icmp'
set firewall name not-local rule 7 protocol 'icmp'

# From NOT to MGMT
set firewall name not-mgmt default-action 'drop'
set firewall name not-mgmt description 'From NOT to MGMT'
set firewall name not-mgmt enable-default-log

# From NOT to SERVICES
set firewall name not-services default-action 'drop'
set firewall name not-services description 'From NOT to SERVICES'
set firewall name not-services enable-default-log
set firewall name not-services rule 1 action 'accept'
set firewall name not-services rule 1 description 'Rule: accept_dns'
set firewall name not-services rule 1 destination port 'domain,domain-s'
set firewall name not-services rule 1 protocol 'tcp_udp'

# From NOT to PRIMARY
set firewall name not-primary default-action 'drop'
set firewall name not-primary description 'From NOT to PRIMARY'
set firewall name not-primary enable-default-log

set firewall name not-primary rule 1 action 'accept'
set firewall name not-primary rule 1 description 'Rule: accept_shelly_to_homeassistant'
set firewall name not-primary rule 1 destination group address-group 'homeassistant'
set firewall name not-primary rule 1 destination group port-group 'homeassistant-shelly'
set firewall name not-primary rule 1 source group address-group 'shellys'
set firewall name not-primary rule 1 protocol 'tcp_udp'

set firewall name not-primary rule 2 action 'accept'
set firewall name not-primary rule 2 description 'Rule: accept_dns'
set firewall name not-primary rule 2 destination port 'domain,domain-s'
set firewall name not-primary rule 2 destination group address-group 'local-dns-servers'
set firewall name not-primary rule 2 protocol 'tcp_udp'

set firewall name not-primary rule 3 action 'accept'
set firewall name not-primary rule 3 description 'Rule: accept_icmp_to_dns'
set firewall name not-primary rule 3 protocol 'icmp'
set firewall name not-primary rule 3 destination group address-group 'local-dns-servers'

# From NOT to DATA
set firewall name not-data default-action 'drop'
set firewall name not-data description 'From NOT to DATA'
set firewall name not-data enable-default-log

# From NOT to WAN
set firewall name not-wan default-action 'drop'
set firewall name not-wan description 'From NOT to WAN'

# From LAN to GUEST
set firewall name lan-guest default-action 'drop'
set firewall name lan-guest description 'From LAN to GUEST'
set firewall name lan-guest enable-default-log

# From LAN to IOT
set firewall name lan-iot default-action 'drop'
set firewall name lan-iot description 'From LAN to IOT'
set firewall name lan-iot enable-default-log

set firewall name lan-iot rule 1 action 'accept'
set firewall name lan-iot rule 1 description 'Rule: accept_icmp'
set firewall name lan-iot rule 1 protocol 'icmp'
set firewall name lan-iot rule 2 action 'accept'
set firewall name lan-iot rule 2 description 'Rule: accept_admin_to_octoprint'
set firewall name lan-iot rule 2 destination group port-group 'octoprint'
set firewall name lan-iot rule 2 protocol 'tcp_udp'
set firewall name lan-iot rule 2 source group address-group 'admin'
set firewall name lan-iot rule 3 action 'accept'
set firewall name lan-iot rule 3 description 'Rule: accept_ssh'
set firewall name lan-iot rule 3 destination port 'ssh'
set firewall name lan-iot rule 3 protocol 'tcp'
set firewall name lan-iot rule 3 source group address-group 'admin'

# From LAN to NOT
set firewall name lan-not default-action 'drop'
set firewall name lan-not description 'From LAN to NOT'
set firewall name lan-not enable-default-log

set firewall name lan-not rule 1 action 'accept'
set firewall name lan-not rule 1 description 'Rule: accept_icmp'
set firewall name lan-not rule 1 protocol 'icmp'

set firewall name lan-not rule 2 action 'accept'
set firewall name lan-not rule 2 description 'Rule: accept_admin'
set firewall name lan-not rule 2 protocol 'tcp_udp'
set firewall name lan-not rule 2 source group address-group 'admin'

# set firewall name lan-not rule 3 action 'accept'
# set firewall name lan-not rule 3 description 'Rule: accept_admin_to_esphome'
# set firewall name lan-not rule 3 destination group port-group 'esphome-api'
# set firewall name lan-not rule 3 destination group address-group 'esphome'
# set firewall name lan-not rule 3 protocol 'tcp'
# set firewall name lan-not rule 3 source group address-group 'admin'

# set firewall name lan-not rule 4 action 'accept'
# set firewall name lan-not rule 4 description 'Rule: accept_admin_to_shelly'
# set firewall name lan-not rule 4 destination group port-group 'shelly'
# set firewall name lan-not rule 4 destination group address-group 'shellys'
# set firewall name lan-not rule 4 protocol 'tcp_udp'
# set firewall name lan-not rule 4 source group address-group 'admin'



# From LAN to LOCAL
set firewall name lan-local default-action 'drop'
set firewall name lan-local description 'From LAN to LOCAL'
set firewall name lan-local enable-default-log
set firewall name lan-local rule 1 action 'accept'
set firewall name lan-local rule 1 description 'Rule: accept_icmp'
set firewall name lan-local rule 1 protocol 'icmp'
set firewall name lan-local rule 2 action 'accept'
set firewall name lan-local rule 2 description 'Rule: accept_ssh'
set firewall name lan-local rule 2 destination port 'ssh'
set firewall name lan-local rule 2 protocol 'tcp'
set firewall name lan-local rule 2 source group address-group 'admin'
set firewall name lan-local rule 3 action 'accept'
set firewall name lan-local rule 3 description 'Rule: accept_ntp'
set firewall name lan-local rule 3 destination port 'ntp'
set firewall name lan-local rule 3 protocol 'udp'
set firewall name lan-local rule 4 action 'accept'
set firewall name lan-local rule 4 description 'Rule: accept_dhcp'
set firewall name lan-local rule 4 destination port '67,68'
set firewall name lan-local rule 4 protocol 'udp'
set firewall name lan-local rule 4 source port '67,68'

# From LAN to MGMT
set firewall name lan-mgmt default-action 'drop'
set firewall name lan-mgmt description 'From LAN to MGMT'
set firewall name lan-mgmt enable-default-log

set firewall name lan-mgmt rule 1 action 'accept'
set firewall name lan-mgmt rule 1 description 'Rule: accept_icmp'
set firewall name lan-mgmt rule 1 protocol 'icmp'

set firewall name lan-mgmt rule 2 action 'accept'
set firewall name lan-mgmt rule 2 description 'Rule: accept_dns'
set firewall name lan-mgmt rule 2 destination port 'domain,domain-s'
set firewall name lan-mgmt rule 2 destination group address-group 'local-dns-servers'
set firewall name lan-mgmt rule 2 protocol 'tcp_udp'

set firewall name lan-mgmt rule 3 action 'accept'
set firewall name lan-mgmt rule 3 description 'Rule: accept_admin_all'
set firewall name lan-mgmt rule 3 destination port '1-65535'
set firewall name lan-mgmt rule 3 protocol 'tcp'
set firewall name lan-mgmt rule 3 source group address-group 'admin'

# From LAN to SERVICES
set firewall name lan-services default-action 'accept'
set firewall name lan-services description 'From LAN to SERVICES'
set firewall name lan-services enable-default-log

# From LAN to PRIMARY
set firewall name lan-primary default-action 'drop'
set firewall name lan-primary description 'From LAN to PRIMARY'
set firewall name lan-primary enable-default-log

set firewall name lan-primary rule 1 action 'accept'
set firewall name lan-primary rule 1 description 'Rule: accept_dns'
set firewall name lan-primary rule 1 destination port 'domain,domain-s'
set firewall name lan-primary rule 1 destination group address-group 'local-dns-servers'
set firewall name lan-primary rule 1 protocol 'tcp_udp'

set firewall name lan-primary rule 2 action 'accept'
set firewall name lan-primary rule 2 description 'Rule: accept_to_homeassistant'
set firewall name lan-primary rule 2 destination group port-group 'homeassistant'
set firewall name lan-primary rule 2 protocol 'tcp_udp'

set firewall name lan-primary rule 3 action 'accept'
set firewall name lan-primary rule 3 description 'Rule: accept_ssh'
set firewall name lan-primary rule 3 destination port 'ssh'
set firewall name lan-primary rule 3 protocol 'tcp'
set firewall name lan-primary rule 3 source group address-group 'admin'

set firewall name lan-primary rule 4 action 'accept'
set firewall name lan-primary rule 4 description 'Rule: accept_icmp'
set firewall name lan-primary rule 4 protocol 'icmp'

set firewall name lan-primary rule 5 action 'accept'
set firewall name lan-primary rule 5 description 'Rule: accept_admin_to_zigbee2mqtt'
set firewall name lan-primary rule 5 destination group port-group 'zigbee2mqtt'
set firewall name lan-primary rule 5 destination group address-group 'zigbee2mqtt'
set firewall name lan-primary rule 5 source group address-group 'admin'
set firewall name lan-primary rule 5 protocol 'tcp_udp'

set firewall name lan-primary rule 6 action 'accept'
set firewall name lan-primary rule 6 description 'Rule: accept_http_from_admin'
set firewall name lan-primary rule 6 destination port 'http,https,8080,8384'
set firewall name lan-primary rule 6 protocol 'tcp_udp'
set firewall name lan-primary rule 6 source group address-group 'admin'

set firewall name lan-primary rule 7 action 'accept'
set firewall name lan-primary rule 7 description 'Rule: accept_ql_label_printer'
set firewall name lan-primary rule 7 destination port '9100'
set firewall name lan-primary rule 7 protocol 'tcp_udp'
set firewall name lan-primary rule 7 source group address-group 'admin'

set firewall name lan-primary rule 8 action 'accept'
set firewall name lan-primary rule 8 description 'Rule: accept_kde_connect'
set firewall name lan-primary rule 8 destination group port-group 'kde-connect'
set firewall name lan-primary rule 8 protocol 'tcp_udp'
set firewall name lan-primary rule 8 source group address-group 'kde-connect-devices'

set firewall name lan-primary rule 9 action 'accept'
set firewall name lan-primary rule 9 description 'Rule: accept_syncthing'
set firewall name lan-primary rule 9 destination group port-group 'syncthing'
set firewall name lan-primary rule 9 protocol 'tcp_udp'
set firewall name lan-primary rule 9 source group address-group 'kde-connect-devices'

set firewall name lan-primary rule 10 action 'accept'
set firewall name lan-primary rule 10 description 'Rule: accept_admin_to_offsite'
set firewall name lan-primary rule 10 protocol all
set firewall name lan-primary rule 10 destination group network-group 'offsite1'
set firewall name lan-primary rule 10 source group address-group 'admin'

set firewall name lan-primary rule 11 action 'accept'
set firewall name lan-primary rule 11 description 'Rule: accept_admin_all'
set firewall name lan-primary rule 11 destination port '1-65535'
set firewall name lan-primary rule 11 protocol 'tcp_udp'
set firewall name lan-primary rule 11 source group address-group 'admin'

# From LAN to DATA
set firewall name lan-data default-action 'drop'
set firewall name lan-data description 'From LAN to DATA'
set firewall name lan-data enable-default-log

set firewall name lan-data rule 1 action 'accept'
set firewall name lan-data rule 1 description 'Rule: accept_icmp'
set firewall name lan-data rule 1 protocol 'icmp'
set firewall name lan-data rule 1 source group address-group 'admin'

# From LAN to WAN
set firewall name lan-wan default-action 'accept'
set firewall name lan-wan description 'From LAN to WAN'

# From LOCAL to GUEST
set firewall name local-guest default-action 'drop'
set firewall name local-guest description 'From LOCAL to GUEST'
set firewall name local-guest enable-default-log

# From LOCAL to IOT
set firewall name local-iot default-action 'drop'
set firewall name local-iot description 'From LOCAL to IOT'
set firewall name local-iot enable-default-log
set firewall name local-iot rule 1 action 'accept'
set firewall name local-iot rule 1 description 'Rule: accept_igmp'
set firewall name local-iot rule 1 protocol '2'
set firewall name local-iot rule 2 action 'accept'
set firewall name local-iot rule 2 description 'Rule: accept_mdns'
set firewall name local-iot rule 2 destination port 'mdns'
set firewall name local-iot rule 2 protocol 'udp'
set firewall name local-iot rule 2 source port 'mdns'
set firewall name local-iot rule 3 action 'accept'
set firewall name local-iot rule 3 description 'Rule: accept_discovery_from_bluesound'
set firewall name local-iot rule 3 destination group port-group 'bluesound'
set firewall name local-iot rule 3 protocol 'tcp_udp'
set firewall name local-iot rule 3 source group address-group bluesound
set firewall name local-iot rule 4 action 'accept'
set firewall name local-iot rule 4 description 'Rule: accept_discovery_from_roon'
set firewall name local-iot rule 4 destination group port-group 'roon'
set firewall name local-iot rule 4 protocol 'tcp_udp'
set firewall name local-iot rule 4 source group address-group roon
set firewall name local-iot rule 5 action 'accept'
set firewall name local-iot rule 5 description 'Rule: accept_icmp'
set firewall name local-iot rule 5 protocol 'icmp'
set firewall name local-iot rule 6 action 'accept'
set firewall name local-iot rule 6 description 'Rule: accept_mdns'
set firewall name local-iot rule 6 destination port '5353'
set firewall name local-iot rule 6 protocol 'tcp_udp'
set firewall name local-iot rule 6 destination address '224.0.0.251'


# From LOCAL to NOT
set firewall name local-not default-action 'drop'
set firewall name local-not description 'From LOCAL to NOT'
set firewall name local-not enable-default-log

set firewall name local-not rule 1 action 'accept'
set firewall name local-not rule 1 description 'Rule: accept_icmp'
set firewall name local-not rule 1 protocol 'icmp'

# From LOCAL to LAN
set firewall name local-lan default-action 'drop'
set firewall name local-lan description 'From LOCAL to LAN'
set firewall name local-lan enable-default-log

set firewall name local-lan rule 1 action 'accept'
set firewall name local-lan rule 1 description 'Rule: accept_dns'
set firewall name local-lan rule 1 destination port 'domain,domain-s'
set firewall name local-lan rule 1 destination group address-group 'local-dns-servers'
set firewall name local-lan rule 1 protocol 'tcp_udp'

set firewall name local-lan rule 2 action 'accept'
set firewall name local-lan rule 2 description 'Rule: accept_icmp'
set firewall name local-lan rule 2 protocol 'icmp'


# From LOCAL to MGMT
set firewall name local-mgmt default-action 'drop'
set firewall name local-mgmt description 'From LOCAL to MGMT'
set firewall name local-mgmt enable-default-log
set firewall name local-mgmt rule 1 action 'accept'
set firewall name local-mgmt rule 1 description 'Rule: accept_bgp'
set firewall name local-mgmt rule 1 destination port 'bgp'
set firewall name local-mgmt rule 1 protocol 'tcp'
set firewall name local-mgmt rule 2 action 'accept'
set firewall name local-mgmt rule 2 description 'Rule: accept_dns'
set firewall name local-mgmt rule 2 destination port 'domain,domain-s'
set firewall name local-mgmt rule 2 protocol 'tcp_udp'
set firewall name local-mgmt rule 3 action 'accept'
set firewall name local-mgmt rule 3 description 'Rule: accept_icmp'
set firewall name local-mgmt rule 3 protocol 'icmp'
set firewall name local-mgmt rule 4 action 'accept'
set firewall name local-mgmt rule 4 description 'Rule: accept_ssh'
set firewall name local-mgmt rule 4 destination port 'ssh'
set firewall name local-mgmt rule 4 protocol 'tcp'
set firewall name local-mgmt rule 5 action 'accept'
set firewall name local-mgmt rule 5 description 'Rule: accept_vector_syslog'
set firewall name local-mgmt rule 5 destination group address-group 'k8s_vector_aggregator'
set firewall name local-mgmt rule 5 destination port '6001'
set firewall name local-mgmt rule 5 protocol 'tcp'
set firewall name local-mgmt rule 6 action 'accept'
set firewall name local-mgmt rule 6 description 'Rule: accept_tailscale_udp_in'
set firewall name local-mgmt rule 6 destination port '41641,3478,5351,1900'
set firewall name local-mgmt rule 6 protocol 'udp'


# From LOCAL to SERVICES
set firewall name local-services default-action 'accept'
set firewall name local-services description 'From LOCAL to SERVICES'
set firewall name local-services rule 1 action 'accept'
set firewall name local-services rule 1 description 'Rule: accept_dns'
set firewall name local-services rule 1 destination port 'domain,domain-s'
set firewall name local-services rule 1 protocol 'tcp_udp'

# From LOCAL to PRIMARY
set firewall name local-primary default-action 'drop'
set firewall name local-primary description 'From LOCAL to PRIMARY'
set firewall name local-primary enable-default-log
set firewall name local-primary rule 1 action 'accept'
set firewall name local-primary rule 1 description 'Rule: accept_igmp'
set firewall name local-primary rule 1 protocol '2'
set firewall name local-primary rule 2 action 'accept'
set firewall name local-primary rule 2 description 'Rule: accept_mdns'
set firewall name local-primary rule 2 destination port 'mdns'
set firewall name local-primary rule 2 protocol 'udp'
set firewall name local-primary rule 2 source port 'mdns'
set firewall name local-primary rule 3 action 'accept'
set firewall name local-primary rule 3 description 'Rule: accept_discovery_from_bluesound'
set firewall name local-primary rule 3 destination group port-group 'bluesound'
set firewall name local-primary rule 3 protocol 'tcp_udp'
set firewall name local-primary rule 3 source group address-group 'bluesound'
set firewall name local-primary rule 4 action 'accept'
set firewall name local-primary rule 4 description 'Rule: accept_discovery_from_roon'
set firewall name local-primary rule 4 destination group port-group 'roon'
set firewall name local-primary rule 4 protocol 'tcp_udp'
set firewall name local-primary rule 4 source group address-group 'roon'
set firewall name local-primary rule 5 action 'accept'
set firewall name local-primary rule 5 description 'Rule: accept_dns'
set firewall name local-primary rule 5 destination port 'domain,domain-s'
set firewall name local-primary rule 5 destination group address-group 'local-dns-servers'
set firewall name local-primary rule 5 protocol 'tcp_udp'

# From LOCAL to DATA
set firewall name local-data default-action 'drop'
set firewall name local-data description 'From LOCAL to DATA'
set firewall name local-data enable-default-log

# From LOCAL to WAN
set firewall name local-wan default-action 'accept'
set firewall name local-wan description 'From LOCAL to WAN'

# From MGMT to GUEST
set firewall name mgmt-guest default-action 'drop'
set firewall name mgmt-guest description 'From MGMT to GUEST'
set firewall name mgmt-guest enable-default-log

# From MGMT to IOT
set firewall name mgmt-iot default-action 'drop'
set firewall name mgmt-iot description 'From MGMT to IOT'
set firewall name mgmt-iot enable-default-log
set firewall name mgmt-iot rule 1 action 'accept'
set firewall name mgmt-iot rule 1 description 'Rule: accept_icmp'
set firewall name mgmt-iot rule 1 protocol 'icmp'

# From MGMT to NOT
set firewall name mgmt-not default-action 'drop'
set firewall name mgmt-not description 'From MGMT to NOT'
set firewall name mgmt-not enable-default-log
set firewall name mgmt-not rule 1 action 'accept'
set firewall name mgmt-not rule 1 description 'Rule: accept_icmp'
set firewall name mgmt-not rule 1 protocol 'icmp'

# From MGMT to LAN
set firewall name mgmt-lan default-action 'drop'
set firewall name mgmt-lan description 'From MGMT to LAN'
set firewall name mgmt-lan enable-default-log

set firewall name mgmt-lan rule 1 action 'accept'
set firewall name mgmt-lan rule 1 description 'Rule: accept_icmp'
set firewall name mgmt-lan rule 1 protocol 'icmp'

set firewall name mgmt-lan rule 2 action 'accept'
set firewall name mgmt-lan rule 2 description 'Rule: accept_dns'
set firewall name mgmt-lan rule 2 destination port 'domain,domain-s'
set firewall name mgmt-lan rule 2 destination group address-group 'local-dns-servers'
set firewall name mgmt-lan rule 2 protocol 'tcp_udp'

set firewall name mgmt-lan rule 3 action 'accept'
set firewall name mgmt-lan rule 3 description 'Rule: accept_dns_prometheus'
set firewall name mgmt-lan rule 3 destination port '9253'
set firewall name mgmt-lan rule 3 destination group address-group 'local-dns-servers'
set firewall name mgmt-lan rule 3 protocol 'tcp_udp'

set firewall name mgmt-lan rule 4 action 'accept'
set firewall name mgmt-lan rule 4 description 'Rule: accept_prometheus_unpoller_to_cloudkey'
set firewall name mgmt-lan rule 4 destination port '8443'
set firewall name mgmt-lan rule 4 destination group address-group 'unifi-cloudkey'
set firewall name mgmt-lan rule 4 protocol 'tcp'

set firewall name mgmt-lan rule 5 action 'accept'
set firewall name mgmt-lan rule 5 description 'Rule: accept_node_exporter'
set firewall name mgmt-lan rule 5 destination port '9100'
set firewall name mgmt-lan rule 5 protocol 'tcp'

# From MGMT to LOCAL
set firewall name mgmt-local default-action 'drop'
set firewall name mgmt-local description 'From MGMT to LOCAL'
set firewall name mgmt-local enable-default-log
set firewall name mgmt-local rule 1 action 'accept'
set firewall name mgmt-local rule 1 description 'Rule: accept_icmp'
set firewall name mgmt-local rule 1 protocol 'icmp'
set firewall name mgmt-local rule 2 action 'accept'
set firewall name mgmt-local rule 2 description 'Rule: accept_ntp'
set firewall name mgmt-local rule 2 destination port 'ntp'
set firewall name mgmt-local rule 2 protocol 'udp'
set firewall name mgmt-local rule 3 action 'accept'
set firewall name mgmt-local rule 3 description 'Rule: accept_dhcp'
set firewall name mgmt-local rule 3 destination port '67,68'
set firewall name mgmt-local rule 3 protocol 'udp'
set firewall name mgmt-local rule 3 source port '67,68'
set firewall name mgmt-local rule 4 action 'accept'
set firewall name mgmt-local rule 4 description 'Rule: accept_bgp'
set firewall name mgmt-local rule 4 destination port 'bgp'
set firewall name mgmt-local rule 4 protocol 'tcp'
set firewall name mgmt-local rule 5 action 'accept'
set firewall name mgmt-local rule 5 description 'Rule: accept_tftp'
set firewall name mgmt-local rule 5 destination port '69'
set firewall name mgmt-local rule 5 protocol 'udp'
set firewall name mgmt-local rule 6 action 'accept'
set firewall name mgmt-local rule 6 description 'Rule: accept_local_prometheus'
set firewall name mgmt-local rule 6 destination port '9273'
set firewall name mgmt-local rule 6 protocol 'tcp'

set firewall name mgmt-local rule 7 action 'accept'
set firewall name mgmt-local rule 7 description 'Rule: accept_tailscale_udp_out'
set firewall name mgmt-local rule 7 source port '41641,3478'
set firewall name mgmt-local rule 7 protocol 'udp'

set firewall name mgmt-local rule 8 action 'accept'
set firewall name mgmt-local rule 8 description 'Rule: accept_tailscale_udp_in'
set firewall name mgmt-local rule 8 destination port '41641,3478,5351,1900'
set firewall name mgmt-local rule 8 protocol 'udp'

# From MGMT to SERVICES
set firewall name mgmt-services default-action 'accept'
set firewall name mgmt-services description 'From MGMT to SERVICES'
set firewall name mgmt-services enable-default-log
set firewall name mgmt-services rule 1 action 'accept'
set firewall name mgmt-services rule 1 description 'Rule: accept_dns'
set firewall name mgmt-services rule 1 destination port 'domain,domain-s'
set firewall name mgmt-services rule 1 protocol 'tcp_udp'

set firewall name mgmt-services rule 2 action 'accept'
set firewall name mgmt-services rule 2 description 'Rule: accept_smtp_from_mgmt'
set firewall name mgmt-services rule 2 destination port 'smtp'
set firewall name mgmt-services rule 2 protocol 'tcp'

set firewall name mgmt-services rule 3 action 'accept'
set firewall name mgmt-services rule 3 description 'Rule: accept_prometheus_node_exporter'
set firewall name mgmt-services rule 3 destination port '9100'
set firewall name mgmt-services rule 3 protocol 'tcp'

set firewall name mgmt-services rule 4 action 'accept'
set firewall name mgmt-services rule 4 description 'Rule: accept_prometheus_snmp_exporter'
set firewall name mgmt-services rule 4 destination port '9116'
set firewall name mgmt-services rule 4 protocol 'tcp'

# From MGMT to PRIMARY
set firewall name mgmt-primary default-action 'drop'
set firewall name mgmt-primary description 'From MGMT to PRIMARY'
set firewall name mgmt-primary enable-default-log
set firewall name mgmt-primary rule 1 action 'accept'
set firewall name mgmt-primary rule 1 description 'Rule: accept_icmp'
set firewall name mgmt-primary rule 1 protocol 'icmp'

set firewall name mgmt-primary rule 2 action 'accept'
set firewall name mgmt-primary rule 2 description 'Rule: accept_dns'
set firewall name mgmt-primary rule 2 destination port 'domain,domain-s'
set firewall name mgmt-primary rule 2 destination group address-group 'local-dns-servers'
set firewall name mgmt-primary rule 2 protocol 'tcp_udp'

set firewall name mgmt-primary rule 3 action 'accept'
set firewall name mgmt-primary rule 3 description 'Rule: accept_container0_to_homeassistant'
set firewall name mgmt-primary rule 3 destination group port-group 'homeassistant'
set firewall name mgmt-primary rule 3 destination group address-group 'homeassistant'
set firewall name mgmt-primary rule 3 protocol 'tcp_udp'

set firewall name mgmt-primary rule 4 action 'accept'
set firewall name mgmt-primary rule 4 description 'Rule: accept_admin_to_zigbee2mqtt'
set firewall name mgmt-primary rule 4 destination group port-group 'zigbee2mqtt'
set firewall name mgmt-primary rule 4 destination group address-group 'zigbee2mqtt'
set firewall name mgmt-primary rule 4 source group address-group 'admin'
set firewall name mgmt-primary rule 4 protocol 'tcp_udp'

set firewall name mgmt-primary rule 5 action 'accept'
set firewall name mgmt-primary rule 5 description 'Rule: accept_ssh_to_borgbackup'
set firewall name mgmt-primary rule 5 destination port 'ssh'
set firewall name mgmt-primary rule 5 destination group address-group 'borgbackup-hosts'
set firewall name mgmt-primary rule 5 protocol 'tcp_udp'

set firewall name mgmt-primary rule 6 action 'accept'
set firewall name mgmt-primary rule 6 description 'Rule: accept_prometheus_node_exporter'
set firewall name mgmt-primary rule 6 destination port '9100'
set firewall name mgmt-primary rule 6 protocol 'tcp'

set firewall name mgmt-primary rule 7 action 'accept'
set firewall name mgmt-primary rule 7 description 'Rule: accept_dns_prometheus'
set firewall name mgmt-primary rule 7 destination port '9253'
set firewall name mgmt-primary rule 7 destination group address-group 'local-dns-servers'
set firewall name mgmt-primary rule 7 protocol 'tcp'

set firewall name mgmt-primary rule 8 action 'accept'
set firewall name mgmt-primary rule 8 description 'Rule: accept_prometheus_zrepl_scrape'
set firewall name mgmt-primary rule 8 destination port '9811'
set firewall name mgmt-primary rule 8 destination group address-group 'truenas'
set firewall name mgmt-primary rule 8 source group address-group 'k8s_cluster_prod_nodes'
set firewall name mgmt-primary rule 8 protocol 'tcp_udp'

set firewall name mgmt-primary rule 9 action 'accept'
set firewall name mgmt-primary rule 9 description 'Rule: accept_tailscale_udp_in'
set firewall name mgmt-primary rule 9 destination port '41641,3478'
set firewall name mgmt-primary rule 9 protocol 'udp'

set firewall name mgmt-primary rule 10 action 'accept'
set firewall name mgmt-primary rule 10 description 'Rule: accept_tailscale_udp_out'
set firewall name mgmt-primary rule 10 source port '41641,3478'
set firewall name mgmt-primary rule 10 protocol 'udp'

# From MGMT to DATA
set firewall name mgmt-data default-action 'drop'
set firewall name mgmt-data description 'From MGMT to DATA'
set firewall name mgmt-data enable-default-log
set firewall name mgmt-data rule 1 action 'accept'
set firewall name mgmt-data rule 1 description 'Rule: accept_icmp'
set firewall name mgmt-data rule 1 protocol 'icmp'

# From MGMT to WAN
set firewall name mgmt-wan default-action 'accept'
set firewall name mgmt-wan description 'From MGMT to WAN'

# From SERVICES to GUEST
set firewall name services-guest default-action 'drop'
set firewall name services-guest description 'From SERVICES to GUEST'
set firewall name services-guest enable-default-log

# From SERVICES to IOT
set firewall name services-iot default-action 'drop'
set firewall name services-iot description 'From SERVICES to IOT'
set firewall name services-iot enable-default-log

# From SERVICES to NOT
set firewall name services-not default-action 'drop'
set firewall name services-not description 'From SERVICES to NOT'
set firewall name services-not enable-default-log

# From SERVICES to LAN
set firewall name services-lan default-action 'drop'
set firewall name services-lan description 'From SERVICES to LAN'
set firewall name services-lan enable-default-log

set firewall name services-lan rule 1 action 'accept'
set firewall name services-lan rule 1 description 'Rule: accept_dns'
set firewall name services-lan rule 1 destination port 'domain,domain-s'
set firewall name services-lan rule 1 destination group address-group 'local-dns-servers'
set firewall name services-lan rule 1 protocol 'tcp_udp'

# From SERVICES to LOCAL
set firewall name services-local default-action 'drop'
set firewall name services-local description 'From SERVICES to LOCAL'
set firewall name services-local enable-default-log
set firewall name services-local rule 1 action 'accept'
set firewall name services-local rule 1 description 'Rule: accept_ntp'
set firewall name services-local rule 1 destination port 'ntp'
set firewall name services-local rule 1 protocol 'udp'
set firewall name services-local rule 2 action 'accept'
set firewall name services-local rule 2 description 'Rule: accept_dhcp'
set firewall name services-local rule 2 destination port '67,68'
set firewall name services-local rule 2 protocol 'udp'
set firewall name services-local rule 2 source port '67,68'

set firewall name services-local rule 3 action 'accept'
set firewall name services-local rule 3 description 'Rule: accept_snmp_from_snmp-exporter'
set firewall name services-local rule 3 source address '10.5.0.9'
set firewall name services-local rule 3 destination address '10.9.8.1'
set firewall name services-local rule 3 protocol 'tcp_udp'
set firewall name services-local rule 3 destination port '161'

# From SERVICES to MGMT
set firewall name services-mgmt default-action 'accept'
set firewall name services-mgmt description 'From SERVICES to MGMT'
set firewall name services-mgmt rule 1 action 'accept'
set firewall name services-mgmt rule 1 description 'Rule: accept_icmp'
set firewall name services-mgmt rule 1 protocol 'icmp'

# From SERVICES to PRIMARY
set firewall name services-primary default-action 'drop'
set firewall name services-primary description 'From SERVICES to PRIMARY'
set firewall name services-primary enable-default-log

set firewall name services-primary rule 1 action 'accept'
set firewall name services-primary rule 1 description 'Rule: accept_dns'
set firewall name services-primary rule 1 destination port 'domain,domain-s'
set firewall name services-primary rule 1 destination group address-group 'local-dns-servers'
set firewall name services-primary rule 1 protocol 'tcp_udp'

# From SERVICES to DATA
set firewall name services-data default-action 'drop'
set firewall name services-data description 'From SERVICES to DATA'
set firewall name services-data enable-default-log

# From SERVICES to WAN
set firewall name services-wan default-action 'accept'
set firewall name services-wan description 'From SERVICES to WAN'

# From PRIMARY to GUEST
set firewall name primary-guest default-action 'drop'
set firewall name primary-guest description 'From PRIMARY to GUEST'
set firewall name primary-guest enable-default-log

# From PRIMARY to IOT
set firewall name primary-iot default-action 'accept'
set firewall name primary-iot description 'From PRIMARY to IOT'
set firewall name primary-iot enable-default-log
set firewall name primary-iot rule 1 action 'accept'
set firewall name primary-iot rule 1 description 'Rule: accept_icmp'
set firewall name primary-iot rule 1 protocol 'icmp'
set firewall name primary-iot rule 2 action 'accept'
set firewall name primary-iot rule 2 description 'Rule: accept_bluesound'
set firewall name primary-iot rule 2 destination group port-group 'bluesound'
set firewall name primary-iot rule 2 protocol 'tcp_udp'
set firewall name primary-iot rule 2 source group address-group 'bluesound'
set firewall name primary-iot rule 3 action 'accept'
set firewall name primary-iot rule 3 description 'Rule: accept_roon'
set firewall name primary-iot rule 3 destination group port-group 'roon'
set firewall name primary-iot rule 3 protocol 'tcp_udp'
set firewall name primary-iot rule 3 source group address-group 'roon'
set firewall name primary-iot rule 4 action 'accept'
set firewall name primary-iot rule 4 description 'Rule: accept_homeassistant_to_octoprint'
set firewall name primary-iot rule 4 destination group port-group 'octoprint'
set firewall name primary-iot rule 4 destination group address-group 'octoprint'
set firewall name primary-iot rule 4 protocol 'tcp_udp'
set firewall name primary-iot rule 4 source group address-group 'homeassistant'

# From PRIMARY to NOT
set firewall name primary-not default-action 'accept'
set firewall name primary-not description 'From PRIMARY to NOT'
set firewall name primary-not enable-default-log
set firewall name primary-not rule 1 action 'accept'
set firewall name primary-not rule 1 description 'Rule: accept_icmp'
set firewall name primary-not rule 1 protocol 'icmp'
set firewall name primary-not rule 2 action 'accept'
set firewall name primary-not rule 2 description 'Rule: accept_homeassistant_to_shelly'
set firewall name primary-not rule 2 destination group port-group 'shelly'
set firewall name primary-not rule 2 destination group address-group 'shellys'
set firewall name primary-not rule 2 protocol 'tcp_udp'
set firewall name primary-not rule 2 source group address-group 'homeassistant'
set firewall name primary-not rule 3 action 'accept'
set firewall name primary-not rule 3 description 'Rule: accept_homeassistant_to_esphome'
set firewall name primary-not rule 3 destination group port-group 'esphome-api'
set firewall name primary-not rule 3 destination group address-group 'esphome'
set firewall name primary-not rule 3 protocol 'tcp_udp'
set firewall name primary-not rule 3 source group address-group 'homeassistant'
set firewall name primary-not rule 4 action 'accept'
set firewall name primary-not rule 4 description 'Rule: accept_homeassistant_to_wled'
set firewall name primary-not rule 4 destination group port-group 'wled-api'
set firewall name primary-not rule 4 destination group address-group 'wled'
set firewall name primary-not rule 4 protocol 'tcp'
set firewall name primary-not rule 4 source group address-group 'homeassistant'

# From PRIMARY to LAN
set firewall name primary-lan default-action 'accept'
set firewall name primary-lan description 'From PRIMARY to LAN'
set firewall name primary-lan enable-default-log

set firewall name primary-lan rule 1 action 'accept'
set firewall name primary-lan rule 1 description 'Rule: accept_dns'
set firewall name primary-lan rule 1 destination port 'domain,domain-s'
set firewall name primary-lan rule 1 destination group address-group 'local-dns-servers'
set firewall name primary-lan rule 1 protocol 'tcp_udp'

set firewall name primary-lan rule 2 action 'accept'
set firewall name primary-lan rule 2 description 'Rule: accept_kde_connect'
set firewall name primary-lan rule 2 destination group port-group 'kde-connect'
set firewall name primary-lan rule 2 protocol 'tcp_udp'
set firewall name primary-lan rule 2 source group address-group 'kde-connect-devices'

set firewall name primary-lan rule 3 action 'accept'
set firewall name primary-lan rule 3 description 'Rule: accept_syncthing'
set firewall name primary-lan rule 3 destination group port-group 'syncthing'
set firewall name primary-lan rule 3 protocol 'tcp_udp'
set firewall name primary-lan rule 3 source group address-group 'kde-connect-devices'

set firewall name primary-lan rule 4 action 'accept'
set firewall name primary-lan rule 4 description 'Rule: accept_admin_ssh'
set firewall name primary-lan rule 4 destination port 'ssh'
set firewall name primary-lan rule 4 protocol 'tcp_udp'
set firewall name primary-lan rule 4 source group address-group 'admin'

set firewall name primary-lan rule 5 action 'accept'
set firewall name primary-lan rule 5 description 'Rule: accept_icmp'
set firewall name primary-lan rule 5 protocol 'icmp'

# From PRIMARY to LOCAL
set firewall name primary-local default-action 'drop'
set firewall name primary-local description 'From PRIMARY to LOCAL'
set firewall name primary-local enable-default-log
set firewall name primary-local rule 1 action 'accept'
set firewall name primary-local rule 1 description 'Rule: accept_icmp'
set firewall name primary-local rule 1 protocol 'icmp'
set firewall name primary-local rule 2 action 'accept'
set firewall name primary-local rule 2 description 'Rule: accept_ssh'
set firewall name primary-local rule 2 destination port 'ssh'
set firewall name primary-local rule 2 protocol 'tcp'
set firewall name primary-local rule 3 action 'accept'
set firewall name primary-local rule 3 description 'Rule: accept_ntp'
set firewall name primary-local rule 3 destination port 'ntp'
set firewall name primary-local rule 3 protocol 'udp'
set firewall name primary-local rule 4 action 'accept'
set firewall name primary-local rule 4 description 'Rule: accept_dhcp'
set firewall name primary-local rule 4 destination port '67,68'
set firewall name primary-local rule 4 protocol 'udp'
set firewall name primary-local rule 4 source port '67,68'
set firewall name primary-local rule 5 action 'accept'
set firewall name primary-local rule 5 description 'Rule: accept_igmp'
set firewall name primary-local rule 5 protocol '2'
set firewall name primary-local rule 6 action 'accept'
set firewall name primary-local rule 6 description 'Rule: accept_mdns'
set firewall name primary-local rule 6 destination port 'mdns'
set firewall name primary-local rule 6 protocol 'udp'
set firewall name primary-local rule 6 source port 'mdns'
set firewall name primary-local rule 7 action 'accept'
set firewall name primary-local rule 7 description 'Rule: accept_vyos_api'
set firewall name primary-local rule 7 destination port '8443'
set firewall name primary-local rule 7 protocol 'tcp'
set firewall name primary-local rule 8 action 'accept'
set firewall name primary-local rule 8 description 'Rule: accept_discovery_from_bluesound'
set firewall name primary-local rule 8 destination group port-group 'bluesound'
set firewall name primary-local rule 8 protocol 'tcp_udp'
set firewall name primary-local rule 8 source group address-group 'bluesound'
set firewall name primary-local rule 9 action 'accept'
set firewall name primary-local rule 9 description 'Rule: accept_discovery_from_roon'
set firewall name primary-local rule 9 destination group port-group 'roon'
set firewall name primary-local rule 9 protocol 'tcp_udp'
set firewall name primary-local rule 9 source group address-group 'roon'

set firewall name primary-local rule 10 action 'accept'
set firewall name primary-local rule 10 description 'Rule: accept_mdns'
set firewall name primary-local rule 10 destination port '5353'
set firewall name primary-local rule 10 protocol 'tcp_udp'
set firewall name primary-local rule 10 destination address '224.0.0.251'

set firewall name primary-local rule 11 action 'accept'
set firewall name primary-local rule 11 description 'Rule: accept_tailscale_udp_out'
set firewall name primary-local rule 11 source port '41641,3478'
set firewall name primary-local rule 11 protocol 'udp'

set firewall name primary-local rule 12 action 'accept'
set firewall name primary-local rule 12 description 'Rule: accept_tailscale_udp_in'
set firewall name primary-local rule 12 destination port '41641,3478,5351,1900'
set firewall name primary-local rule 12 protocol 'udp'

set firewall name primary-local rule 13 action 'accept'
set firewall name primary-local rule 13 description 'Rule: accept_ingress_for_roon_arc'
set firewall name primary-local rule 13 destination group port-group 'roon-arc'
set firewall name primary-local rule 13 protocol 'tcp_udp'

# From PRIMARY to MGMT
set firewall name primary-mgmt default-action 'drop'
set firewall name primary-mgmt description 'From PRIMARY to MGMT'
set firewall name primary-mgmt enable-default-log
set firewall name primary-mgmt rule 1 action 'accept'
set firewall name primary-mgmt rule 1 description 'Rule: accept_icmp'
set firewall name primary-mgmt rule 1 protocol 'icmp'

set firewall name primary-mgmt rule 2 action 'accept'
set firewall name primary-mgmt rule 2 description 'Rule: accept_ingress_to_container0'
set firewall name primary-mgmt rule 2 destination address '10.9.8.30'
set firewall name primary-mgmt rule 2 destination port 'http,https'
set firewall name primary-mgmt rule 2 protocol 'tcp'

set firewall name primary-mgmt rule 3 action 'accept'
set firewall name primary-mgmt rule 3 description 'Rule: accept_dns'
set firewall name primary-mgmt rule 3 destination port 'domain,domain-s'
set firewall name primary-mgmt rule 3 destination group address-group 'local-dns-servers'
set firewall name primary-mgmt rule 3 protocol 'tcp_udp'

set firewall name primary-mgmt rule 4 action 'accept'
set firewall name primary-mgmt rule 4 description 'Rule: accept_k8s_ingress'
set firewall name primary-mgmt rule 4 destination port 'http,https'
set firewall name primary-mgmt rule 4 destination group address-group 'k8s_cluster_test_ingress_all'
set firewall name primary-mgmt rule 4 protocol 'tcp_udp'

set firewall name primary-mgmt rule 5 action 'accept'
set firewall name primary-mgmt rule 5 description 'Rule: accept_k8s_api_from_admin'
set firewall name primary-mgmt rule 5 destination group port-group 'k8s-api'
set firewall name primary-mgmt rule 5 destination group address-group 'k8s_cluster_test_api'
set firewall name primary-mgmt rule 5 protocol 'tcp_udp'
set firewall name primary-mgmt rule 5 source group address-group 'admin'

set firewall name primary-mgmt rule 6 action 'accept'
set firewall name primary-mgmt rule 6 description 'Rule: accept_admin_ssh'
set firewall name primary-mgmt rule 6 destination port 'ssh'
set firewall name primary-mgmt rule 6 protocol 'tcp_udp'
set firewall name primary-mgmt rule 6 source group address-group 'admin'

set firewall name primary-mgmt rule 7 action 'accept'
set firewall name primary-mgmt rule 7 description 'Rule: accept_k8s_prod_ingress'
set firewall name primary-mgmt rule 7 destination port 'http,https'
set firewall name primary-mgmt rule 7 destination group address-group 'k8s_cluster_prod_ingress_all'
set firewall name primary-mgmt rule 7 protocol 'tcp_udp'

set firewall name primary-mgmt rule 8 action 'accept'
set firewall name primary-mgmt rule 8 description 'Rule: accept_k8s_prod_api_from_admin'
set firewall name primary-mgmt rule 8 destination group port-group 'k8s-api'
set firewall name primary-mgmt rule 8 destination group address-group 'k8s_cluster_prod_api'
set firewall name primary-mgmt rule 8 protocol 'tcp_udp'
set firewall name primary-mgmt rule 8 source group address-group 'admin'

set firewall name primary-mgmt rule 9 action 'accept'
set firewall name primary-mgmt rule 9 description 'Rule: accept_truenas_graphite'
set firewall name primary-mgmt rule 9 destination port '2003'
set firewall name primary-mgmt rule 9 destination address '10.10.12.6'
set firewall name primary-mgmt rule 9 protocol 'tcp_udp'

set firewall name primary-mgmt rule 10 action 'accept'
set firewall name primary-mgmt rule 10 description 'Rule: accept_truenas_to_node'
set firewall name primary-mgmt rule 10 source group address-group 'truenas'
set firewall name primary-mgmt rule 10 destination group address-group 'k8s_cluster_prod_nodes'
set firewall name primary-mgmt rule 10 protocol 'tcp_udp'

set firewall name primary-mgmt rule 11 action 'accept'
set firewall name primary-mgmt rule 11 description 'Rule: accept_traceroute'
set firewall name primary-mgmt rule 11 destination port '33434-34000'
set firewall name primary-mgmt rule 11 protocol 'udp'

set firewall name primary-mgmt rule 12 action 'accept'
set firewall name primary-mgmt rule 12 description 'Rule: accept_plex'
set firewall name primary-mgmt rule 12 destination port '32400'
set firewall name primary-mgmt rule 12 destination address '10.10.12.8'
set firewall name primary-mgmt rule 12 protocol 'tcp'

set firewall name primary-mgmt rule 13 action 'accept'
set firewall name primary-mgmt rule 13 description 'Rule: accept_admin'
set firewall name primary-mgmt rule 13 protocol 'tcp_udp'
set firewall name primary-mgmt rule 13 source group address-group 'admin'

# From PRIMARY to SERVICES
set firewall name primary-services default-action 'accept'
set firewall name primary-services description 'From PRIMARY to SERVICES'
set firewall name primary-services rule 1 action 'accept'
set firewall name primary-services rule 1 description 'Rule: accept_dns'
set firewall name primary-services rule 1 destination port 'domain,domain-s'
set firewall name primary-services rule 1 protocol 'tcp_udp'

# From PRIMARY to DATA
set firewall name primary-data default-action 'drop'
set firewall name primary-data description 'From PRIMARY to DATA'
set firewall name primary-data enable-default-log
set firewall name primary-data rule 1 action 'accept'
set firewall name primary-data rule 1 description 'Rule: accept_icmp'
set firewall name primary-data rule 1 protocol 'icmp'
set firewall name primary-data rule 2 action 'accept'
set firewall name primary-data rule 2 description 'Rule: accept_samba_from_homeassistant'
set firewall name primary-data rule 2 destination group port-group 'truenas-samba'
set firewall name primary-data rule 2 destination group address-group 'mali'
set firewall name primary-data rule 2 protocol 'tcp_udp'
set firewall name primary-data rule 2 source group address-group 'homeassistant'

# From PRIMARY to WAN
set firewall name primary-wan default-action 'accept'
set firewall name primary-wan description 'From PRIMARY to WAN'

# From DATA to GUEST
set firewall name data-guest default-action 'drop'
set firewall name data-guest description 'From DATA to GUEST'
set firewall name data-guest enable-default-log

# From DATA to IOT
set firewall name data-iot default-action 'drop'
set firewall name data-iot description 'From DATA to IOT'
set firewall name data-iot enable-default-log

# From DATA to NOT
set firewall name data-not default-action 'drop'
set firewall name data-not description 'From DATA to NOT'
set firewall name data-not enable-default-log

# From DATA to LAN
set firewall name data-lan default-action 'drop'
set firewall name data-lan description 'From DATA to LAN'
set firewall name data-lan enable-default-log

set firewall name data-lan rule 1 action 'accept'
set firewall name data-lan rule 1 description 'Rule: accept_dns'
set firewall name data-lan rule 1 destination port 'domain,domain-s'
set firewall name data-lan rule 1 destination group address-group 'local-dns-servers'
set firewall name data-lan rule 1 protocol 'tcp_udp'

# From DATA to LOCAL
set firewall name data-local default-action 'drop'
set firewall name data-local description 'From DATA to LOCAL'
set firewall name data-local enable-default-log
set firewall name data-local rule 1 action 'accept'
set firewall name data-local rule 1 description 'Rule: accept_ntp'
set firewall name data-local rule 1 destination port 'ntp'
set firewall name data-local rule 1 protocol 'udp'
set firewall name data-local rule 2 action 'accept'
set firewall name data-local rule 2 description 'Rule: accept_dhcp'
set firewall name data-local rule 2 destination port '67,68'
set firewall name data-local rule 2 protocol 'udp'
set firewall name data-local rule 2 source port '67,68'

# From DATA to MGMT
set firewall name data-mgmt default-action 'drop'
set firewall name data-mgmt description 'From DATA to MGMT'
set firewall name data-mgmt enable-default-log

set firewall name data-mgmt rule 1 action 'accept'
set firewall name data-mgmt rule 1 description 'Rule: accept_k8s_prod_api_from_admin'
set firewall name data-mgmt rule 1 destination group port-group 'k8s-api'
set firewall name data-mgmt rule 1 destination group address-group 'k8s_cluster_prod_api'
set firewall name data-mgmt rule 1 protocol 'tcp_udp'
set firewall name data-mgmt rule 1 source group address-group 'k8s_cluster_prod_nodes'

# From DATA to SERVICES
set firewall name data-services default-action 'accept'
set firewall name data-services description 'From DATA to SERVICES'
set firewall name data-services enable-default-log
set firewall name data-services rule 1 action 'accept'
set firewall name data-services rule 1 description 'Rule: accept_dns'
set firewall name data-services rule 1 destination port 'domain,domain-s'
set firewall name data-services rule 1 protocol 'tcp_udp'

# From DATA to PRIMARY
set firewall name data-primary default-action 'drop'
set firewall name data-primary description 'From DATA to PRIMARY'
set firewall name data-primary enable-default-log

set firewall name data-primary rule 1 action 'accept'
set firewall name data-primary rule 1 description 'Rule: accept_dns'
set firewall name data-primary rule 1 destination port 'domain,domain-s'
set firewall name data-primary rule 1 destination group address-group 'local-dns-servers'
set firewall name data-primary rule 1 protocol 'tcp_udp'

# From DATA to WAN
set firewall name data-wan default-action 'accept'
set firewall name data-wan description 'From DATA to WAN'

# From WAN to GUEST
set firewall name wan-guest default-action 'drop'
set firewall name wan-guest description 'From WAN to GUEST'
set firewall name wan-guest enable-default-log

# From WAN to IOT
set firewall name wan-iot default-action 'drop'
set firewall name wan-iot description 'From WAN to IOT'
set firewall name wan-iot enable-default-log

# From WAN to NOT
set firewall name wan-not default-action 'drop'
set firewall name wan-not description 'From WAN to NOT'
set firewall name wan-not enable-default-log

# From WAN to LAN
set firewall name wan-lan default-action 'drop'
set firewall name wan-lan description 'From WAN to LAN'
set firewall name wan-lan enable-default-log

# From WAN to LOCAL
set firewall name wan-local default-action 'drop'
set firewall name wan-local description 'From WAN to LOCAL'
set firewall name wan-local enable-default-log
set firewall name wan-local rule 1 action 'accept'
set firewall name wan-local rule 1 description 'Rule: accept_wireguard'
set firewall name wan-local rule 1 destination port '51820'
set firewall name wan-local rule 1 protocol 'udp'

set firewall name wan-local rule 2 action 'accept'
set firewall name wan-local rule 2 description 'Rule: accept_tailscale'
set firewall name wan-local rule 2 destination port '41641,42417'
set firewall name wan-local rule 2 protocol 'udp'

# From WAN to MGMT
set firewall name wan-mgmt default-action 'drop'
set firewall name wan-mgmt description 'From WAN to MGMT'
set firewall name wan-mgmt enable-default-log
set firewall name wan-mgmt rule 1 action 'accept'
set firewall name wan-mgmt rule 1 description 'Rule: accept_ingress_from_cloudflare'
set firewall name wan-mgmt rule 1 destination group address-group 'k8s_cluster_test_ingress_external'
set firewall name wan-mgmt rule 1 destination port 'http,https'
set firewall name wan-mgmt rule 1 protocol 'tcp'
set firewall name wan-mgmt rule 1 source group network-group 'cloudflare-ipv4'

set firewall name wan-mgmt rule 2 action 'accept'
set firewall name wan-mgmt rule 2 description 'Rule: accept_plex'
set firewall name wan-mgmt rule 2 destination address '10.10.12.8'
set firewall name wan-mgmt rule 2 destination port '32400'
set firewall name wan-mgmt rule 2 protocol 'tcp'

set firewall name wan-mgmt rule 3 action 'accept'
set firewall name wan-mgmt rule 3 description 'Rule: accept_k8s_prod_ingress_from_cloudflare'
set firewall name wan-mgmt rule 3 destination group address-group 'k8s_cluster_prod_ingress_external'
set firewall name wan-mgmt rule 3 destination port 'http,https'
set firewall name wan-mgmt rule 3 protocol 'tcp'
set firewall name wan-mgmt rule 3 source group network-group 'cloudflare-ipv4'

# From WAN to SERVICES
set firewall name wan-services default-action 'drop'
set firewall name wan-services description 'From WAN to SERVICES'
set firewall name wan-services enable-default-log

# From WAN to PRIMARY
set firewall name wan-primary default-action 'drop'
set firewall name wan-primary description 'From WAN to PRIMARY'
set firewall name wan-primary enable-default-log
set firewall name wan-primary rule 1 action 'accept'
set firewall name wan-primary rule 1 description 'Rule: accept_ingress_for_roon_arc'
set firewall name wan-primary rule 1 destination group address-group 'roon-server'
set firewall name wan-primary rule 1 destination group port-group 'roon-arc'
set firewall name wan-primary rule 1 protocol 'tcp_udp'

# From WAN to DATA
set firewall name wan-data default-action 'drop'
set firewall name wan-data description 'From WAN to DATA'
set firewall name wan-data enable-default-log

set firewall name wan-data rule 1 action 'accept'
set firewall name wan-data rule 1 description 'Rule: accept_ingress_for_mali_zrepl_replication'
set firewall name wan-data rule 1 source group address-group 'ludwig-wan'
set firewall name wan-data rule 1 destination group address-group 'mali'
set firewall name wan-data rule 1 destination group port-group 'mali-replication'
set firewall name wan-data rule 1 protocol 'tcp_udp'
