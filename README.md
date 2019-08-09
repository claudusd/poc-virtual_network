# POC - Libvirt and OpenVSwitch

This repository it's a proof of concept to build private network.


## Front

This VM is build with packer and ansible. This is debian 10 (buster). 



```
iptables -t nat -A POSTROUTING -o ens2 -j MASQUERADE

iptables -A FORWARD -i ens2 -o ens3 -m state --state RELATED,ESTABLISHED -j ACCEPT

iptables -A FORWARD -i ens3 -o ens2 -j ACCEPT
```