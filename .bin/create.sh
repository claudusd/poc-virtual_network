#!/usr/bin/env bash

function build() {
    cp images/default/debian_10-quemu.qcow2 disk/$1

    CLOUD_INIT_YAML_META_DATA_FILE="cloudinit/meta-data"

    cat <<EOF > $CLOUD_INIT_YAML_META_DATA_FILE
instance-id: 0fc18e419e44e0acedd05630e70f3075c216da7d
EOF


    CLOUD_INIT_YAML_NETWORK_FILE="cloudinit/network-config"

    cat <<EOF > $CLOUD_INIT_YAML_NETWORK_FILE
version: 1
config:
    - type: physical
      mac_address: '76:2d:fb:63:1e:49'
      name: 'ens1'
      subnets:
        - type: static
          address: '172.16.76.46'
          netmask: '255.255.240.0'
          gateway: '172.16.79.254'
          dns_nameservers:
            - '192.168.100.75'
            - '192.168.100.74'
    - type: physical
      mac_address: '76:2d:fb:63:1e:50'
      name: 'ens2'
      subnets:
        - type: static
          address: '10.10.0.1'
          netmask: '255.255.255.0'
          dns_nameservers:
            - '192.168.100.75'
            - '192.168.100.74'
EOF

    CLOUD_INIT_YAML_USER_DATA_FILE="cloudinit/user-data"

    cat <<EOF > $CLOUD_INIT_YAML_USER_DATA_FILE
#cloud-config
hostname: nginx
manage_etc_hosts: true
fqdn: front.isima.fr local.isima.fr
user: limosadm
ssh_authorized_keys:
  - ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDWZG/U964fhPxt1phecXR4i1vUPzF4yS9W5X4ac4N5gc1CipYoUJPSGI/TtTaCDvmXwZ0Rh8NtJoI62RIoftSThys0OQ41JNYyDKROElBusvs0Nr8Dl3g6W51rRsddAmAgzTBznfmzKuLIrPx0H4SKQGe8xZFSR4c3FOXbfIMeLaLPkCA+AVPpzoAwrsZiWg16efvtlkbz/8Yt2VpiBnmvfx3R2g6dPjQK0gT0PhJKfLsIO6tyMigtBWn6GWcFMTFD09vTnSWvRII2UyoXbg18/z1O2Slw66/cLle8t24saVsV3XklPr+/mgfsR7EMIrw1xuohqQrynMOeczw/k06hxEqKyWwIGJ3E49iewXGXHpK6TNDgzzMNEuB4kWUt3sWvaNPLo3x1Z+BKUPUjSH8Zv5a6JdY+h0qhe+ZOY+mtMPMak63fHFq7rMLcV2a1vqrwJ6sM761LI7LOaTI5okGr4ohCwpA1XOtDY3ZlqSj2MvDQPa9lelY4RR/uVspCW03gDyPFEx2iiW2FvkGTrgRwWC6SU28NMoATeLrtgJS8Fe6pvlskBah3Amc9PwNHR9lj2AnQFW2oLErMjfW+oljnXYa6ub5g/BBtLPEBoZfyJHjuwd+Tv2bRBMQp7WJkzzCTkIPuzA5oDX55wtgp67QjxrcmH8Hiq38t0awXz3oDFw== limosadm@isima.fr
chpasswd:
  expire: False
users:
  - default
package_upgrade: true
EOF

    genisoimage  -output cloudinit/$1-cloud-init.iso -volid cidata -joliet -rock $CLOUD_INIT_YAML_USER_DATA_FILE $CLOUD_INIT_YAML_META_DATA_FILE $CLOUD_INIT_YAML_NETWORK_FILE

    rm $CLOUD_INIT_YAML_META_DATA_FILE

    rm $CLOUD_INIT_YAML_USER_DATA_FILE

    rm $CLOUD_INIT_YAML_NETWORK_FILE

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
