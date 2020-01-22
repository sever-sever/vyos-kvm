#!/usr/bin/env bash

vmid=$1

# Check that the vm-id argument is set
if [ $# -ne 1 ]; then
    echo "Usage: $0 <node id or node name> (virsh list)"
    exit 1
fi

# Check that vm-id is exists
virsh dominfo $vmid > /dev/null 2>&1
if [ $? -eq 1 ]; then
    echo "[$vmid] vm id or nat not found"
    echo "You can check with \"virsh list\""
    exit 1
fi

user="vyos"
new_password="vyos123"

expect <<EOF

spawn virsh console $vmid --force

expect "Escape character is"  {send "\r"}
expect "vyos login:"  {send "$user\r"}
expect "Password:"  {send "$user\r"}
expect "vyos@vyos:"  {send "install image\r"}
expect "Would you like to continue?"  {send "Yes\r"}
expect "Partition (Auto/Parted/Skip)"  {send "\r"}
expect "Install the image on? *vd*"  {send "\r"}
expect "Continue?"  {send "Yes\r"}
expect "How big of a root partition should I create?" {send "\r"}
expect "What would you like to name this image?" {send "\r"}
expect "Which one should I copy to "  {send "\r"}
expect "Enter password for user 'vyos':" {send "$new_password\r"}
expect "Retype password for user 'vyos':"  {send "$new_password\r"}
expect "Which drive should GRUB modify the boot partition on?" {send "\r"}

expect "vyos@vyos:"  {send "reboot now\r"}
expect "reboot:"

EOF

