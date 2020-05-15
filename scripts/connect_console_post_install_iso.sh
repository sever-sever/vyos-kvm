#!/usr/bin/env bash

vm_name=$1
default_user=$2
new_vyos_pass=$3
ipaddr=$4

ssh_key_id=$(cat ~/.ssh/id_rsa.pub | awk '{print $3}')
ssh_key_type=$(cat ~/.ssh/id_rsa.pub | awk '{print $1}')
ssh_key_pub=$(cat ~/.ssh/id_rsa.pub | awk '{print $2}')

expect <<EOF

  set timeout 120
  spawn virsh console $vm_name --force

  expect "Escape character is"  {send "\r"}
  expect "Welcome to VyOS" {send "\r"}
  expect "vyos login:"  {send "$default_user\r"}
  expect "Password:"  {send "$new_vyos_pass\r"}
  expect "vyos@vyos:" {send "configure\r"}
  expect "vyos@vyos*" {send "set system login user $default_user authentication public-keys $ssh_key_id key $ssh_key_pub \r"}
  expect "vyos@vyos*" {send "set system login user $default_user authentication public-keys $ssh_key_id type $ssh_key_type \r"}
  expect "vyos@vyos*" {send "set interfaces ethernet eth0 address $ipaddr/24 \r"}
  expect "vyos@vyos*" {send "set protocols static route 0.0.0.0/0 next-hop 192.168.122.1 \r"}
  expect "vyos@vyos*" {send "set system name-server 1.1.1.1 \r"}
  expect "vyos@vyos*" {send "set system host-name $vm_name \r"}
  expect "vyos@vyos*" {send "set service ssh \r"}
  expect "vyos@vyos*" {send "set service ssh disable-host-validation \r"}
  expect "vyos@vyos*" {send "commit \r"}
  expect "vyos@vyos*" {send "save \r"}
  expect "vyos@vyos*" {send "exit\r"}
  expect "vyos@vyos*" {send "exit\r"}

EOF

