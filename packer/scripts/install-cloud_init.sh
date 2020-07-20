#!/usr/bin/env bash

RELEASE=$(lsb_release -i -s)

if [ $RELEASE == 'Debian' ] || [ $RELEASE == 'Ubuntu' ]; then

apt-get install -y cloud-init

if [ $RELEASE == 'Debian' ]; then
apt-get install -y cloud-tools 
fi

if [ $RELEASE == 'Ubuntu' ]; then
apt-get install -y linux-cloud-tools
fi

apt-get install -y cloud-initramfs-growroot

DISTRO="debian"

fi

if [[ $RELEASE == 'CentOS' ]]; then

yum install -y cloud-init
yum install -y cloud-utils-growpart

DISTRO="rhel"

CI_PACKAGE=$(cat <<'END_HEREDOC'
abc'asdf"
$(dont-execute-this)
foo"bar"''
END_HEREDOC
)


fi

cat <<EOF > /etc/cloud/cloud.cfg
# The top level settings are used as module
# and system configuration.

# A set of users which may be applied and/or used by various modules
# when a 'default' entry is found it will reference the 'default_user'
# from the distro configuration specified below
users:
   - default

# If this is set, 'root' will not be able to ssh in and they 
# will get a message to login instead as the above $user (debian)
disable_root: true

# This will cause the set+update hostname module to not operate (if true)
preserve_hostname: false

# Example datasource config
# datasource: 
#    Ec2: 
#      metadata_urls: [ 'blah.com' ]
#      timeout: 5 # (defaults to 50 seconds)
#      max_wait: 10 # (defaults to 120 seconds)

# The modules that run in the 'init' stage
cloud_init_modules:
 - migrator
 - seed_random
 - bootcmd
 - write-files
 - growpart
 - resizefs
 - disk_setup
 - mounts
 - set_hostname
 - update_hostname
 - update_etc_hosts
 - ca-certs
 - rsyslog
 - users-groups
 - ssh
 - yum_add_repo

# The modules that run in the 'config' stage
cloud_config_modules:
# Emit the cloud config ready event
# this ca/etc/cloud/cloud.cfg jobs for 'start on cloud-config'.
 - emit_u/etc/cloud/cloud.cfg
 - ssh-im/etc/cloud/cloud.cfg
 - locale/etc/cloud/cloud.cfg
 - set-passwords
 - grub-dpkg
 - apt-pipelining
 - apt-configure
 - ntp
 - timezone
 - disable-ec2-metadata
 - runcmd
 - byobu

# The modules that run in the 'final' stage
cloud_final_modules:
 #- package-update-upgrade-install
 - fan
 - puppet
 - chef
 - salt-minion
 - mcollective
 - rightscale_userdata
 - scripts-vendor
 - scripts-per-once
 - scripts-per-boot
 - scripts-per-instance
 - scripts-user
 - ssh-authkey-fingerprints
 - keys-to-console
 - phone-home
 - final-message
 - power-state-change

# System and/or distro specific settings
# (not accessible to handlers/transforms)
system_info:
   # This will affect which distro class gets used
   distro: ${DISTRO}
   # Default user name + that default users groups (if added/used)
   default_user:
     lock_passwd: True
     gecos: Default
     groups: [adm, audio, cdrom, dialout, dip, floppy, netdev, plugdev, sudo, video]
     sudo: ["ALL=(ALL) NOPASSWD:ALL"]
     shell: /bin/bash
   # Other config here will be given to the distro class and/or path classes
   paths:
      cloud_dir: /var/lib/cloud/
      templates_dir: /etc/cloud/templates/
      upstart_dir: /etc/init/
growpart:
  mode: auto
  devices: ['/']
  ignore_growroot_disabled: false
EOF