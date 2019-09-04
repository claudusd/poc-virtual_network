#!/usr/bin/env bash

virsh destroy front
virsh undefine front
rm disk/front
rm cloudinit/front-cloud-init.iso

virsh destroy back
virsh undefine back
rm disk/back
rm cloudinit/back-cloud-init.iso
