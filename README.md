# vyos-kvm
Adding VyOS instances with ansible.

Install VM's and provide ip address on eth0 via dhcp and ssh access to them via ssh-key.

Params of VMs in file vars/guests.yml

In the example, 2 virtual machines will be created.

# Run playbook
ansible-playbook virt-guests.yml
