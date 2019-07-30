#!/usr/bin/env bash

cat > /etc/default/grub <<- EOM
GRUB_DEFAULT=0
GRUB_TIMEOUT=5
GRUB_DISTRIBUTOR=`lsb_release -i -s 2> /dev/null || echo Debian`

GRUB_CMDLINE_LINUX_DEFAULT="console=ttyS0,115200n8 console=tty1"
GRUB_CMDLINE_LINUX=""

GRUB_TERMINAL="serial console"
GRUB_SERIAL_COMMAND="serial --speed=115200 --unit=0 --word=8 --parity=no --stop=1"

EOM

update-grub2