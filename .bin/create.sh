#!/usr/bin/env bash

function build() {
    cp images/default/debian_10-quemu.qcow2 disk/$1

    cat <<EOF > cloudinit/$1-cloud-init.yml
instance-id: 0fc18e419e44e0acedd05630e70f3075c216da7d
version: 1
config:
    - type: physical
      mac_address: 'fe:59:0f:26:fa:b2'
      subnets:
      - type: static
        address: 172.16.76.46/20
        gateway: 172.16.79.254
    - type: physical
      mac_address: 'fe:59:0f:26:fa:b3'
      subnets:
      - type: static
        address: 10.10.0.1/24
hostname: base
manage_etc_hosts: true
EOF

    genisoimage  -output cloudinit/$1-cloud-init.iso -volid cidata -joliet -rock cloudinit/$1-cloud-init.yml

    virsh define libvirt/definition/$1.xml
    virsh start $1
}

build "front"

# build "back"

# cp images/default/debian_10-quemu.qcow2 disk/front
# cp images/default/debian_10-quemu.qcow2 disk/back
# virsh define libvirt/definition/front.xml
# virsh define libvirt/definition/back.xml
# virsh start front
# virsh start back
