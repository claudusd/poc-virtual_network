#!/usr/bin/env bash

virsh destroy front
virsh undefine front
rm disk/front
rm cloudinit/front-cloud-init.iso

# rm disk/back
# virsh destroy back
# virsh undefine back