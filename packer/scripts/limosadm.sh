#!/usr/bin/env bash

groupadd limosadm

useradd -c "Limosadm" -m -p $6$cgV6i3M7d7WUhJ6$x7idNRAuKOZhaogsFy5dbyc9jPCAouIw8.u3881U2vcKp4NzCKYtHEAPiPbSs9QYha6qGV2ZLt6XIqp0Lxzjf1 -g limosadm -G adm,dialout,floppy  -s /bin/bash limosadm

mkdir /home/limosadm/.ssh/

chown limosadm:limosadm /home/limosadm/.ssh

echo "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDWZG/U964fhPxt1phecXR4i1vUPzF4yS9W5X4ac4N5gc1CipYoUJPSGI/TtTaCDvmXwZ0Rh8NtJoI62RIoftSThys0OQ41JNYyDKROElBusvs0Nr8Dl3g6W51rRsddAmAgzTBznfmzKuLIrPx0H4SKQGe8xZFSR4c3FOXbfIMeLaLPkCA+AVPpzoAwrsZiWg16efvtlkbz/8Yt2VpiBnmvfx3R2g6dPjQK0gT0PhJKfLsIO6tyMigtBWn6GWcFMTFD09vTnSWvRII2UyoXbg18/z1O2Slw66/cLle8t24saVsV3XklPr+/mgfsR7EMIrw1xuohqQrynMOeczw/k06hxEqKyWwIGJ3E49iewXGXHpK6TNDgzzMNEuB4kWUt3sWvaNPLo3x1Z+BKUPUjSH8Zv5a6JdY+h0qhe+ZOY+mtMPMak63fHFq7rMLcV2a1vqrwJ6sM761LI7LOaTI5okGr4ohCwpA1XOtDY3ZlqSj2MvDQPa9lelY4RR/uVspCW03gDyPFEx2iiW2FvkGTrgRwWC6SU28NMoATeLrtgJS8Fe6pvlskBah3Amc9PwNHR9lj2AnQFW2oLErMjfW+oljnXYa6ub5g/BBtLPEBoZfyJHjuwd+Tv2bRBMQp7WJkzzCTkIPuzA5oDX55wtgp67QjxrcmH8Hiq38t0awXz3oDFw== limosadm@isima.fr" > /home/limosadm/.ssh/authorized_keys

chown limosadm:limosadm /home/limosadm/.ssh/authorized_keys

echo "limosadm ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/limosadm

chown root:root /etc/sudoers.d/limosadm

chmod 440 /etc/sudoers.d/limosadm