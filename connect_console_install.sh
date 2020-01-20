#!/usr/bin/env bash

vmid=$1

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

