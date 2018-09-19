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
#forbidden user
DenyUsers test mysql tomcat
systemctl restart sshd

#6、关闭NetworkManager
systemctl stop NetworkManager
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

#12、设置history显示显示操作时间、用户和登录 IP
cat >> /etc/bashrc <<EOF
HISTFILESIZE=4000
HISTSIZE=4000
USER_IP=`who -u am i 2>/dev/null| awk '{print $NF}'|sed -e 's/[()]//g'`
if [ -z $USER_IP ]
then
  USER_IP=`hostname`
fi
HISTTIMEFORMAT="%F %T $USER_IP:`whoami` "
export HISTTIMEFORMAT
EOF

# 13、内核参数优化，使用 sysctl -p 立即生效
cat /etc/sysctl.conf
# 避免放大攻击
net.ipv4.icmp_echo_ignore_broadcasts = 1
# 开启恶意icmp错误消息保护
net.ipv4.icmp_ignore_bogus_error_responses = 1
#关闭路由转发
net.ipv4.ip_forward = 0
net.ipv4.conf.all.send_redirects = 0
net.ipv4.conf.default.send_redirects = 0
#开启反向路径过滤
net.ipv4.conf.all.rp_filter = 1
net.ipv4.conf.default.rp_filter = 1
#处理无源路由的包
net.ipv4.conf.all.accept_source_route = 0
net.ipv4.conf.default.accept_source_route = 0
#关闭sysrq功能
kernel.sysrq = 0
#core文件名中添加pid作为扩展名
kernel.core_uses_pid = 1
# 开启SYN洪水攻击保护
net.ipv4.tcp_syncookies = 1
#修改消息队列长度
kernel.msgmnb = 65536
kernel.msgmax = 65536
#设置最大内存共享段大小bytes
kernel.shmmax = 68719476736
kernel.shmall = 4294967296
#timewait的数量，默认180000
net.ipv4.tcp_max_tw_buckets = 6000
net.ipv4.tcp_sack = 1
net.ipv4.tcp_window_scaling = 1
net.ipv4.tcp_rmem = 4096        87380   4194304
net.ipv4.tcp_wmem = 4096        16384   419430
net.core.wmem_default = 8388608
net.core.rmem_default = 8388608
net.core.rmem_max = 16777216
net.core.wmem_max = 16777216
#每个网络接口接收数据包的速率比内核处理这些包的速率快时，允许送到队列的数据包的最大数目
net.core.netdev_max_backlog = 262144
#限制仅仅是为了防止简单的DoS 攻击
net.ipv4.tcp_max_orphans = 3276800
#未收到客户端确认信息的连接请求的最大值
net.ipv4.tcp_max_syn_backlog = 262144
net.ipv4.tcp_timestamps = 0
#内核放弃建立连接之前发送SYNACK 包的数量
net.ipv4.tcp_synack_retries = 1
#内核放弃建立连接之前发送SYN 包的数量
net.ipv4.tcp_syn_retries = 1
#启用timewait 快速回收
net.ipv4.tcp_tw_recycle = 1
#开启重用。允许将TIME-WAIT sockets 重新用于新的TCP 连接
net.ipv4.tcp_tw_reuse = 1
net.ipv4.tcp_mem = 94500000 915000000 927000000
net.ipv4.tcp_fin_timeout = 1
#当keepalive 起用的时候，TCP 发送keepalive 消息的频度。缺省是2 小时
net.ipv4.tcp_keepalive_time = 30
#允许系统打开的端口范围
net.ipv4.ip_local_port_range = 1024    65000
#修改防火墙表大小，默认65536
net.netfilter.nf_conntrack_max = 655350
net.netfilter.nf_conntrack_tcp_timeout_established = 1200
# 确保无人能修改路由表
net.ipv4.conf.all.accept_redirects = 0
net.ipv4.conf.default.accept_redirects = 0
net.ipv4.conf.all.secure_redirects = 0
net.ipv4.conf.default.secure_redirects = 0