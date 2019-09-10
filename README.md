# POC - Libvirt and OpenVSwitch

This repository it's a proof of concept to build private network.


To use this poc you need :
* Hasicorp Packer
* Qemu KVM

## Build

I use Hashicorp Packer to build centos and debian qcow2 image.


Run ``make build`` to run the image building.





## Not watch below
### Front

This VM is build with packer and ansible. This is debian 10 (buster). 



```
iptables -t nat -A POSTROUTING -o ens1 -j MASQUERADE

iptables -A FORWARD -i ens1 -o ens2 -m state --state RELATED,ESTABLISHED -j ACCEPT

iptables -A FORWARD -i ens2 -o ens1 -j ACCEPT
```

```
iptables -t nat -A POSTROUTING -o ens2 -j MASQUERADE

iptables -A FORWARD -i ens2 -o ens1 -m state --state RELATED,ESTABLISHED -j ACCEPT

iptables -A FORWARD -i ens1 -o ens2 -j ACCEPT
```

### Package

```
sudo apt install libguestfs-tools 
```