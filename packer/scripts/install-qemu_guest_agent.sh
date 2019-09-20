#!/usr/bin/env bash

RELEASE=$(lsb_release -i -s)

if [ $RELEASE == 'Debian' ] || [ $RELEASE == 'Ubuntu' ]; then

apt-get install -y qemu-guest-agent

fi

if [[ $RELEASE == 'CentOS' ]]; then

yum install -y qemu-guest-agent

fi