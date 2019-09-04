#!/usr/bin/env bash

RELEASE=$(lsb_release -i -s)

if [[ $RELEASE == 'Debian' ]]; then

apt-get install -y qemu-guest-agent

fi

if [[ $RELEASE == 'CentOS' ]]; then

yum install -y qemu-guest-agent

fi