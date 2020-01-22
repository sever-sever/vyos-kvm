#!/usr/bin/env bash

vm_name=$1

# Check that the vm-name argument is set
if [ $# -ne 1 ]; then
    echo "Usage: $0 <Vm name> (virsh list --all)"
    exit 1
fi

vm_state=$(virsh list --all | grep "$vm_name" | awk '{print $3}')

# Check that vmname is exists
virsh dominfo $vm_name > /dev/null 2>&1
if [ $? -eq 1 ]; then
    echo "[$vm_name] vm id or node name not found."
    echo "You can check with \"virsh list\""
    exit 1
fi



if [ "$vm_state" != "running" ]; then
  virsh start $vm_name
  sleep 2
  virsh list | grep $vm_name
fi

user=vyos
pass=vyos123
new_user=sever
ssh_key_id=$(cat ~/.ssh/id_rsa.pub | awk '{print $3}')
ssh_key_type=$(cat ~/.ssh/id_rsa.pub | awk '{print $1}')
ssh_key_pub=$(cat ~/.ssh/id_rsa.pub | awk '{print $2}')

expect <<EOF

  spawn virsh console $vm_name --force

  expect "Escape character is"  {send "\r"}
  expect "vyos login:"  {send "$user\r"}
  expect "Password:"  {send "$pass\r"}
  expect "vyos@vyos:" {send "configure\r"}
  expect "vyos@vyos*" {send "set system login user $new_user level admin \r"}
  expect "vyos@vyos*" {send "set system login user $new_user authentication public-keys $ssh_key_id key $ssh_key_pub \r"}
  expect "vyos@vyos*" {send "set system login user $new_user authentication public-keys $ssh_key_id type $ssh_key_type \r"}
  expect "vyos@vyos*" {send "set interfaces ethernet eth0 address dhcp \r"}
  expect "vyos@vyos*" {send "set service ssh \r"}
  expect "vyos@vyos*" {send "commit \r"}
  sleep 4
  expect "vyos@vyos*" {send "run show interface \r"}
  expect "vyos@vyos*" {send "exit\r"}
  expect "vyos@vyos*" {send "exit\r"}


EOF
