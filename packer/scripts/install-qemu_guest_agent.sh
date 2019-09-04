#!/usr/bin/env bash

RELEASE=$(lsb_release -i -s)

if [[ $RELEASE == 'Debian' ]]; then

apt-get install -y qemu-guest-agent

fi

if [[ $RELEASE == 'Centos' ]]; then

yum install -y qemu-guest-agent

fi