#!/usr/bin/env bash

function remove() {
    virsh destroy $1
    virsh undefine $1
    rm -f disk/$1
    rm -f cloudinit/$1-cloud-init.iso
}

remove 'front'

remove 'back'
