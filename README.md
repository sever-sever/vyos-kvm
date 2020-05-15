# vyos-kvm
Adding VyOS instances with ansible. Requires intstalltion of additional packages "python3-expect expect"

Install VM's and provide ip address on eth0 from vars and ssh access to them via ssh-key.

Params of VMs on base ISO in the file vars/guests_iso.yml

Params of VMs on base QCOW2 in the file vars/guests_qcow.yml


# Run playbook for deploy VMs from iso
ansible-playbook create_vm_from_iso.yml

# Run playbook for deploy VMs from qcow2 
(requires sudo or access to directory /var/lib/libvirt/images/)

sudo ansible-playbook create_vm_from_qcow.yml

