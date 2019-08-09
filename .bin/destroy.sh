#!/usr/bin/env bash

rm disk/front
virsh destroy front
virsh undefine front

rm disk/back
virsh destroy back
virsh undefine back