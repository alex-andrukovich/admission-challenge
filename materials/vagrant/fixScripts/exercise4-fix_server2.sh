#!/bin/bash

sed -i 's/PasswordAuthentication no/PasswordAuthentication yes/g' /etc/ssh/sshd_config

if ! (grep -q server1 /etc/hosts); then
   sed -i '$ a 192.168.60.10 server1' /etc/hosts
fi
if ! (grep -q server1 /etc/ssh/ssh_config); then
  sed -i '$ a Host server1\n    StrictHostKeyChecking no\n' /etc/ssh/ssh_config
fi

systemctl restart sshd
