#!/usr/bin/env bash

rm disk/poc-front
virsh destroy poc-front
virsh undefine poc-front