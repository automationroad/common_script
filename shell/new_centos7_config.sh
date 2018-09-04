#!/bin/bash
#desc : centos7环境下新系统安装后基本配置
#author : 浪子尘心
#created : 2018-08-23

#1、时间同步
yum -y install ntpdate
ntpdate cn.pool.ntp.org
hwclock --systohc
echo "/usr/sbin/ntpdate cn.pool.ntp.org" >> /etc/rc.d/rc.local
echo "hwclock --systohc" >> /etc/rc.d/rc.local

#2、主机名设置
hostnamectl set-hostname yourname

#3、hosts设置
vim /etc/hosts
（1）加主机名
（2）如果有应用服务需要用到主机名，将对应的IP和主机名加入，加快请求速度

#4、禁止root用户ssh登录
sed -i 's/#PermitRootLogin yes/PermitRootLogin no/g' /etc/ssh/sshd_config
systemctl restart sshd

#5、禁止应用用户ssh登录
DenyUsers test mysql tomcat
systemctl restart sshd

#6、关闭NetworkManager
systemctl stop etworkManager
systemctl disable NetworkManager

#7、关于selinux，这个开启还是关闭看实际环境，安全性要求非常高的会开启，大部分情况下的人都是关闭的，我只是书上看过点皮毛理论
#我一直都是关闭的，如果开启的话，策略没有配置好可能会有很多想不到的问题
#临时关闭selinux
setenforce 1
#永久关闭selinux
sed -i "s/SELINUX=enforcing/SELINUX=disabled/g" /etc/selinux/config

#8、关闭防火墙和开机不启动（生产环境慎用，可以选择开放对应的端口）
systemctl stop firewalld.service
systemctl disable firewalld.service

#9、给rc.local增加执行权限
chmod +x /etc/rc.d/rc.local

#10、字符集设置，这个我装机的时候选择中文，所以没试过设置，这我网上的方法
#查看当前
localectl status
#设置为字符集为zh_CN.UTF-8
localectl set-locale LANG=zh_CN.UTF-8

#11、加大打开文件数的限制，
#查看，默认是1024
ulimit -n
echo "* soft nofile 65536" >> /etc/security/limits.conf
echo "* hard nofile 65536" >> /etc/security/limits.conf
reboot

#12、设置history显示操作时间和最大记录数
cat >> /etc/bashrc <<EOF
HISTFILESIZE=2000
HISTSIZE=2000
HISTTIMEFORMAT='%F %T '
export HISTTIMEFORMAT
EOF