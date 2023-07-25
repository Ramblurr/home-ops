#!/bin/vbash
# shellcheck shell=bash

# General configuration
set firewall state-policy established action 'accept'
set firewall state-policy invalid action 'drop'
set firewall state-policy related action 'accept'

# Address Groups
set firewall group address-group android_tv_players address '10.9.4.14'

set firewall group address-group ereaders address '10.9.6.96'
set firewall group address-group ereaders address '10.9.6.95'

set firewall group address-group homeassistant address '10.9.4.25'

set firewall group address-group shellys address '10.9.4.35'
set firewall group address-group shellys address '10.8.60.10'
set firewall group address-group shellys address '10.8.60.11'
set firewall group address-group shellys address '10.8.60.12'
set firewall group address-group shellys address '10.8.60.13'
set firewall group address-group shellys address '10.8.60.14'
set firewall group address-group shellys address '10.8.60.15'
set firewall group address-group shellys address '10.8.60.16'
set firewall group address-group shellys address '10.8.60.17'
set firewall group address-group shellys address '10.8.60.18'
set firewall group address-group shellys address '10.8.60.19'
set firewall group address-group shellys address '10.8.60.20'
set firewall group address-group shellys address '10.8.60.21'
set firewall group address-group shellys address '10.8.60.22'
set firewall group address-group shellys address '10.8.60.23'
set firewall group address-group shellys address '10.8.60.24'
set firewall group address-group shellys address '10.8.60.25'
set firewall group address-group shellys address '10.8.60.26'
set firewall group address-group shellys address '10.8.60.27'
set firewall group address-group shellys address '10.8.60.31'
set firewall group address-group shellys address '10.8.60.33'
set firewall group address-group shellys address '10.8.60.34'
set firewall group address-group shellys address '10.8.60.35'
set firewall group address-group shellys address '10.8.60.36'
set firewall group address-group shellys address '10.8.60.37'
set firewall group address-group shellys address '10.8.60.38'
set firewall group address-group shellys address '10.8.60.39'
set firewall group address-group shellys address '10.8.60.40'
set firewall group address-group shellys address '10.8.60.41'
set firewall group address-group shellys address '10.8.60.42'
set firewall group address-group shellys address '10.8.60.43'
set firewall group address-group shellys address '10.8.60.44'
set firewall group address-group shellys address '10.8.60.49'
set firewall group address-group shellys address '10.8.60.50'
set firewall group address-group esphome address '10.8.60.28' # bedroom-switch-esphome
set firewall group address-group esphome address '10.8.60.29' # quinled-a-south
set firewall group address-group esphome address '10.8.60.30' # quinled-b-north
set firewall group address-group esphome address '10.8.60.45' # bathroom-climate
set firewall group address-group esphome address '10.8.60.48'
set firewall group address-group wled address '10.8.60.46' # wled-childroom-nightlight
set firewall group address-group wled address '10.8.60.32' # wled-office
set firewall group address-group wled address '10.8.60.47' # wled-fairylights
set firewall group address-group wled address '10.8.60.102' # wled-gr-rgb
set firewall group address-group octoprint address '10.8.50.52'

set firewall group address-group k8s_cluster_test_api address '10.9.9.100'
set firewall group address-group k8s_cluster_test_nodes address '10.9.9.101'
set firewall group address-group k8s_cluster_test_nodes address '10.9.9.102'
set firewall group address-group k8s_cluster_test_nodes address '10.9.9.103'
set firewall group address-group k8s_cluster_test_ingress_external address '10.10.10.1'
set firewall group address-group k8s_cluster_test_ingress_internal address '10.10.10.3'
set firewall group address-group k8s_cluster_test_ingress_all address '10.10.10.1'
set firewall group address-group k8s_cluster_test_ingress_all address '10.10.10.3'
set firewall group address-group k8s_cluster_test_postgres address '10.10.10.2'

set firewall group address-group k8s_vector_aggregator address '10.10.12.7'
set firewall group address-group k8s_cluster_prod_api address '10.9.9.120'
set firewall group address-group k8s_cluster_prod_nodes address '10.9.9.121'
set firewall group address-group k8s_cluster_prod_nodes address '10.9.9.122'
set firewall group address-group k8s_cluster_prod_nodes address '10.9.9.123'
set firewall group address-group k8s_cluster_prod_nodes address '10.9.9.124'
set firewall group address-group k8s_cluster_prod_nodes address '10.9.9.125'
set firewall group address-group k8s_cluster_prod_nodes address '10.9.9.130'
set firewall group address-group k8s_cluster_prod_nodes address '10.9.9.131'
set firewall group address-group k8s_cluster_prod_nodes address '10.9.9.132'
set firewall group address-group k8s_cluster_prod_nodes address '10.9.9.133'
set firewall group address-group k8s_cluster_prod_ingress_external address '10.10.12.1'
set firewall group address-group k8s_cluster_prod_ingress_internal address '10.10.12.3'
set firewall group address-group k8s_cluster_prod_ingress_all address '10.10.12.1'
set firewall group address-group k8s_cluster_prod_ingress_all address '10.10.12.3'
set firewall group address-group k8s_cluster_prod_postgres address '10.10.12.2'

set firewall group address-group nas-prim address '10.9.4.10'

set firewall group address-group printers address '10.9.5.1'
set firewall group address-group printers address '10.9.5.2'

set firewall group address-group bluesound address '10.9.6.16'
set firewall group address-group bluesound address '10.9.6.28'
set firewall group address-group bluesound address '10.9.4.15'
set firewall group address-group bluesound address '10.9.4.13'
set firewall group address-group bluesound address '10.9.4.12'

set firewall group address-group roon address '10.9.6.16'
set firewall group address-group roon address '10.9.6.28'
set firewall group address-group roon address '10.9.4.15'
set firewall group address-group roon address '10.9.4.13'
set firewall group address-group roon address '10.9.4.12'
set firewall group address-group roon address '10.9.6.23'

set firewall group address-group roon-server address '10.9.6.23'

set firewall group address-group vector_journald_allowed address '10.1.3.56'
set firewall group address-group vector_journald_allowed address '10.1.3.60'

set firewall group address-group vyos_chronyd address '10.5.0.5'

set firewall group address-group wall-dashboards address '10.8.50.10'

set firewall group address-group admin address '192.168.1.82'
set firewall group address-group admin address '192.168.1.83'
set firewall group address-group admin address '192.168.1.243'
set firewall group address-group admin address '10.9.6.14'
set firewall group address-group admin address '10.9.6.15'
set firewall group address-group admin address '100.108.66.109'
set firewall group address-group admin address '100.78.82.102'
set firewall group address-group admin address '10.9.4.27'

set firewall group address-group kde-connect-devices address '192.168.1.83'
set firewall group address-group kde-connect-devices address '192.168.1.82'
set firewall group address-group kde-connect-devices address '192.168.1.243'
set firewall group address-group kde-connect-devices address '10.9.6.15'
set firewall group address-group kde-connect-devices address '10.9.6.14'

set firewall group address-group mali address '10.9.4.10'
set firewall group address-group mali address '10.9.10.10'

set firewall group address-group truenas address '10.9.4.10'
set firewall group address-group truenas address '192.168.8.4'

set firewall group address-group ludwig-wan address "${SECRET_LUDWIG_WAN_IP}"

set firewall group address-group local-dns-servers address '10.9.4.4'
set firewall group address-group local-dns-servers address '192.168.1.3'
set firewall group address-group local-dns-servers address '10.10.10.53'
set firewall group address-group local-dns-servers address '10.10.12.53'

set firewall group address-group vyos-dnsdist address '10.5.0.4'

set firewall group address-group zigbee2mqtt address '10.9.4.11'

set firewall group address-group minio address '10.9.10.12'
set firewall group address-group minio address '10.9.10.10'

set firewall group address-group filebrowser address '10.9.6.60'

set firewall group address-group unifi-cloudkey address '192.168.1.2'

set firewall group address-group borgbackup-hosts address '10.9.4.21'

# Network groups
set firewall group network-group cloudflare-ipv4 network '173.245.48.0/20'
set firewall group network-group cloudflare-ipv4 network '103.21.244.0/22'
set firewall group network-group cloudflare-ipv4 network '103.22.200.0/22'
set firewall group network-group cloudflare-ipv4 network '103.31.4.0/22'
set firewall group network-group cloudflare-ipv4 network '141.101.64.0/18'
set firewall group network-group cloudflare-ipv4 network '108.162.192.0/18'
set firewall group network-group cloudflare-ipv4 network '190.93.240.0/20'
set firewall group network-group cloudflare-ipv4 network '188.114.96.0/20'
set firewall group network-group cloudflare-ipv4 network '197.234.240.0/22'
set firewall group network-group cloudflare-ipv4 network '198.41.128.0/17'
set firewall group network-group cloudflare-ipv4 network '162.158.0.0/15'
set firewall group network-group cloudflare-ipv4 network '104.16.0.0/13'
set firewall group network-group cloudflare-ipv4 network '104.24.0.0/14'
set firewall group network-group cloudflare-ipv4 network '172.64.0.0/13'
set firewall group network-group cloudflare-ipv4 network '131.0.72.0/22'

# Port groups
set firewall group port-group minio port '9100'
set firewall group port-group wireguard port '51820'
set firewall group port-group bluesound port '80'
set firewall group port-group bluesound port '11000'
set firewall group port-group bluesound port '11010'
set firewall group port-group bluesound port '11020'
set firewall group port-group bluesound port '11030'
set firewall group port-group bluesound port '11430'
set firewall group port-group roon port '9330-9339'
set firewall group port-group roon port '30000-30010'
set firewall group port-group roon port '42839'
set firewall group port-group roon port '9093'
set firewall group port-group roon port '9003'
set firewall group port-group shelly port '5683'
set firewall group port-group shelly port '80'
set firewall group port-group esphome-api port '6053'
set firewall group port-group esphome-api port '80'
set firewall group port-group wled-api port '80'
set firewall group port-group roon-arc port '33399'
set firewall group port-group mali-replication port '3478'
set firewall group port-group truenas-nfs port '111'
set firewall group port-group truenas-nfs port '2049'
set firewall group port-group truenas-samba port '137'
set firewall group port-group truenas-samba port '138'
set firewall group port-group truenas-samba port '139'
set firewall group port-group truenas-samba port '445'
set firewall group port-group octoprint port '80'
set firewall group port-group octoprint port '5000'
set firewall group port-group octoprint port '443'
set firewall group port-group homeassistant port '8123'
set firewall group port-group homeassistant-shelly port '8123'
set firewall group port-group k8s-api port '6443'

set firewall group port-group syncthing port '22000'
set firewall group port-group syncthing port '21027'

set firewall group port-group zigbee2mqtt port '8080'

set firewall group port-group kde-connect port '1714-1764'

set firewall group network-group offsite1 network '192.168.8.0/22'
