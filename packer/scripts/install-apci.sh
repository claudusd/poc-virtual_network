#!/usr/bin/env bash

RELEASE=$(lsb_release -i -s)

if [ $RELEASE == 'Debian' ] || [ $RELEASE == 'Ubuntu' ]; then

apt-get install -y acpid

fi

if [[ $RELEASE == 'CentOS' ]]; then

yum install -y acpid

fi