#!/bin/sh

# Run this on a proxmox node!

STORAGE_DIR=/mnt/pve/mali-tank2/template/cache

set -uex

BASEURL="https://cloud.centos.org/centos/9-stream/x86_64/images/"
IMAGE="$(curl -s "$BASEURL" | sed -n 's/^.*\(CentOS-Stream-GenericCloud-9-[^"]*.qcow2\)".*$/\1/p' | tail -n1)"
RAW="${IMAGE%.qcow2}.raw"
TARBALL="${IMAGE%.qcow2}.tar.gz"

# download and check image
TMPDIR="$(mktemp -d)"
cd "$TMPDIR"
curl -s -O "$BASEURL$IMAGE"
curl -s -O "$BASEURL$IMAGE.SHA256SUM"
sha256sum -c "$IMAGE.SHA256SUM"

# convert to raw image
qemu-img convert -p -O raw "$IMAGE" "$RAW"

# mount locally
MOUNTDIR="$(mktemp -d)"
mount -o loop -o offset=1048576 "$RAW" "$MOUNTDIR"
cd "$MOUNTDIR"

# create template archive
tar cfz "${STORAGE_DIR}/${TARBALL}" --exclude=boot *

# cleanup
cd /
umount "$MOUNTDIR"
rm -rf "$TMPDIR"
