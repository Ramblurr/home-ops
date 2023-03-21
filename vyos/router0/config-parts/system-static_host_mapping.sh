# Gateway
set system static-host-mapping host-name gateway.socozy.casa inet 192.168.1.1

# Unifi controller
set system static-host-mapping host-name unifi inet 192.168.1.2

# NAS
set system static-host-mapping host-name mali.int.socozy.casa inet 10.9.4.10
set system static-host-mapping host-name mali.data.socozy.casa inet 10.9.10.10

# Kubernetes hosts
#set system static-host-mapping host-name delta.socozy.casa inet 10.1.1.31

# Kubernetes cluster VIP
#set system static-host-mapping host-name cluster-0.socozy.casa inet 10.5.0.2
