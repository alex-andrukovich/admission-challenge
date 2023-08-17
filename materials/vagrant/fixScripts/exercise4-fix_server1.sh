#!/bin/bash

sed -i 's/PasswordAuthentication no/PasswordAuthentication yes/g' /etc/ssh/sshd_config

if ! (grep -q server2 /etc/hosts); then
   sed -i '$ a 192.168.60.11 server2' /etc/hosts
fi
if ! (grep -q server2 /etc/ssh/ssh_config); then
  sed -i '$ a Host server2\n    StrictHostKeyChecking no\n' /etc/ssh/ssh_config
fi

systemctl restart sshd
