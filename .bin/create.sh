#!/usr/bin/env bash

cp images/poc-front-qemu/poc-front disk/poc-front
virsh define libvirt/definition/poc-front.xml
virsh start poc-front