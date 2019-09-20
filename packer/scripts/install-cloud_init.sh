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
#     name: limosadm
     lock_passwd: True
     gecos: Limosadm
     groups: [adm, audio, cdrom, dialout, dip, floppy, netdev, plugdev, sudo, video]
     sudo: ["ALL=(ALL) NOPASSWD:ALL"]
     shell: /bin/bash
  #    ssh_authorized_keys:
  #      - ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDWZG/U964fhPxt1phecXR4i1vUPzF4yS9W5X4ac4N5gc1CipYoUJPSGI/TtTaCDvmXwZ0Rh8NtJoI62RIoftSThys0OQ41JNYyDKROElBusvs0Nr8Dl3g6W51rRsddAmAgzTBznfmzKuLIrPx0H4SKQGe8xZFSR4c3FOXbfIMeLaLPkCA+AVPpzoAwrsZiWg16efvtlkbz/8Yt2VpiBnmvfx3R2g6dPjQK0gT0PhJKfLsIO6tyMigtBWn6GWcFMTFD09vTnSWvRII2UyoXbg18/z1O2Slw66/cLle8t24saVsV3XklPr+/mgfsR7EMIrw1xuohqQrynMOeczw/k06hxEqKyWwIGJ3E49iewXGXHpK6TNDgzzMNEuB4kWUt3sWvaNPLo3x1Z+BKUPUjSH8Zv5a6JdY+h0qhe+ZOY+mtMPMak63fHFq7rMLcV2a1vqrwJ6sM761LI7LOaTI5okGr4ohCwpA1XOtDY3ZlqSj2MvDQPa9lelY4RR/uVspCW03gDyPFEx2iiW2FvkGTrgRwWC6SU28NMoATeLrtgJS8Fe6pvlskBah3Amc9PwNHR9lj2AnQFW2oLErMjfW+oljnXYa6ub5g/BBtLPEBoZfyJHjuwd+Tv2bRBMQp7WJkzzCTkIPuzA5oDX55wtgp67QjxrcmH8Hiq38t0awXz3oDFw== limosadm@isima.fr
   # Other config here will be given to the distro class and/or path classes
   paths:
      cloud_dir: /var/lib/cloud/
      templates_dir: /etc/cloud/templates/
      upstart_dir: /etc/init/
   # package_mirrors:
   #   - arches: [default]
   #     failsafe:
   #       primary: http://deb.debian.org/debian
   #       security: http://security.debian.org/
   # ssh_svcname: ssh
growpart:
  mode: auto
  devices: ['/']
  ignore_growroot_disabled: false

users:
  - default
  - name: limosadm
    lock_passwd: True
    gecos: Limosadm
    groups: [adm, audio, cdrom, dialout, dip, floppy, netdev, plugdev, sudo, video]
    sudo: ["ALL=(ALL) NOPASSWD:ALL"]
    shell: /bin/bash
    ssh_authorized_keys:
      - ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDWZG/U964fhPxt1phecXR4i1vUPzF4yS9W5X4ac4N5gc1CipYoUJPSGI/TtTaCDvmXwZ0Rh8NtJoI62RIoftSThys0OQ41JNYyDKROElBusvs0Nr8Dl3g6W51rRsddAmAgzTBznfmzKuLIrPx0H4SKQGe8xZFSR4c3FOXbfIMeLaLPkCA+AVPpzoAwrsZiWg16efvtlkbz/8Yt2VpiBnmvfx3R2g6dPjQK0gT0PhJKfLsIO6tyMigtBWn6GWcFMTFD09vTnSWvRII2UyoXbg18/z1O2Slw66/cLle8t24saVsV3XklPr+/mgfsR7EMIrw1xuohqQrynMOeczw/k06hxEqKyWwIGJ3E49iewXGXHpK6TNDgzzMNEuB4kWUt3sWvaNPLo3x1Z+BKUPUjSH8Zv5a6JdY+h0qhe+ZOY+mtMPMak63fHFq7rMLcV2a1vqrwJ6sM761LI7LOaTI5okGr4ohCwpA1XOtDY3ZlqSj2MvDQPa9lelY4RR/uVspCW03gDyPFEx2iiW2FvkGTrgRwWC6SU28NMoATeLrtgJS8Fe6pvlskBah3Amc9PwNHR9lj2AnQFW2oLErMjfW+oljnXYa6ub5g/BBtLPEBoZfyJHjuwd+Tv2bRBMQp7WJkzzCTkIPuzA5oDX55wtgp67QjxrcmH8Hiq38t0awXz3oDFw== limosadm@isima.fr

EOF