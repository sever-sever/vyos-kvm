#!/usr/bin/env bash

# Path to ISO file
ISO=/home/sever/Downloads/ISO/vyos-rolling-latest.iso

# How many instance will be created
number_instances=2
name=$(date +%Y-%m-%d-%T)
vmid=VyOS-$name
user=vyos


for I in `seq 1 $number_instances`
do
virt-install \
  -n $vmid-$I \
  --description "Test VM VyOS $name" \
  --os-type=Linux \
  --os-variant=debian9 \
  --virt-type kvm \
  --ram=512 \
  --vcpus=1 \
  --disk path=/var/lib/libvirt/images/vyos-$name-$I.img,bus=virtio,size=4 \
  --graphics none \
  --noautoconsole \
  --cdrom $ISO \
  --network network:default  >/dev/null 2>&1


virsh list &
echo "done"
done

exit
