#!/usr/bin/env bash

RELEASE=$(lsb_release -i -s)

if [[ $RELEASE == 'Debian' ]]; then

apt-get install -y acpid

fi

if [[ $RELEASE == 'Centos' ]]; then

yum install -y acpid

fi