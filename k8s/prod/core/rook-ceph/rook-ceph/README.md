# rook-ceph on NixOS Hosts

To get rook-ceph working on NixOS, you need to do a few extra things:

Some of these are documented on [the rook-ceph prereqs page](https://rook.io/docs/rook/latest/Getting-Started/Prerequisites/prerequisites/#nixos), some not.


1. Set nix specific `csiRBDPlugin*` values (see prereqs link above or [./app/helmrelease.yaml](./app/helmrelease.yaml))
2. If you want to use LVM or encrypted OSDs then you need to override the `PATH` env var in the OSD pods (see [./app/configmap.yaml](./app/configmap.yaml)) (ref: https://github.com/rook/rook/issues/12012#issuecomment-1730268281)
