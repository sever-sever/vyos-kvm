# vyos-kvm
Adding VyOS vm's in kvm

In file  create_vms_vyos.sh change "number_instances" example 3

01. Create vm instances with ./create_vms_vyos.sh
Check 1-2 minutes to build

02. Install instance 1-by-1
./connect_console_install.sh $1

where $1 - id of instance from (virsh list)
