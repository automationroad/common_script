#!/bin/bash

#########################################################################
# File Name: batch_users.sh
# file_path: /root/script/batch_users.sh
# Author: 浪子尘心
# Mail: hj536418286@gmail.com
# Created Time: 2018-12-19 17:17:07
# Last Changed: 2018-12-19 17:18:12
# Description: batch create users in linux
# Version: 0.1
#########################################################################

which sshpass > /dev/null 2>&1
if [ $? -ne 0 ];then
echo "don't exist sshpass,please install sshpas"
exit;
fi

# select a user for ansible manager
ansible_user='ansible'

# passwd of ansible user
user_passwd='123456@Ap'

# root passwd
root_passwd='123456!Ab'

# creater a user
useradd ${ansible_user}

# change user passwd
echo ${user_passwd} | passwd --stdin ${ansible_user}

# make user to be the power of root
sed -i "92a ${ansible_user}     ALL=(ALL)       ALL" /etc/sudoers

# create private key
su - ${ansible_user} -c "ssh-keygen -t rsa -f /home/${ansible_user}/.ssh/id_rsa -N '' -q"

# config the public key
su - ${ansible_user} -c "sshpass -p${user_passwd} ssh-copy-id -i /home/${ansible_user}/.ssh/id_rsa.pub ${ansible_user}@127.0.0.1 -o StrictHostKeyChecking=no"

# batch create users and send public key
for line in `cat /root/script/ip_list.txt`
do
# create a user and change user passwd and make user to be root on remote
sshpass -p"${root_passwd}" ssh -o StrictHostKeyChecking=no root@${line} "useradd ${ansible_user} ; echo ${user_passwd} | passwd --stdin ${ansible_user} ; sed -i '92a ${ansible_user}     ALL=(ALL)       ALL' /etc/sudoers"

# send public key
su - ${ansible_user} -c "sshpass -p${user_passwd} ssh-copy-id -i /home/${ansible_user}/.ssh/id_rsa.pub ${ansible_user}@${line} -o StrictHostKeyChecking=no"
done
