#!/usr/bin/env bash

cp images/default/debian_10-quemu.qcow2 disk/front
cp images/default/debian_10-quemu.qcow2 disk/back
virsh define libvirt/definition/front.xml
virsh define libvirt/definition/back.xml
virsh start front
virsh start back