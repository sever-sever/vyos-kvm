# vyos-kvm
Adding VyOS instances with ansible. Require intstall pkg "expect"

Install VM's and provide ip address on eth0 from vars and ssh access to them via ssh-key.

Params of VMs in the file vars/guests.yml

In the example, 2 virtual machines will be created.

# Run playbook
ansible-playbook virt-guests.yml
