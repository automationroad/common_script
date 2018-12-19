telnet-server服务启动依赖xinetd服务
查看是否安装xinetd
rpm -qa | grep xinetd
安装xinetd
yum install -y xinetd
查看是否安装Telnet
rpm -qa | grep telnet*
分别安装telnet 和 telnet-server
yum -y install telnet-server telnet


centos7:
允许root登录
echo 'pts/0' >> /etc/securetty
echo 'pts/1' >> /etc/securetty

systemctl start telnet.socket
systemctl enable telnet.socket
systemctl start xinetd
systemctl enable xinetd


centos6:
将其中disable字段的yes改为no以启用telnet服务
sed -i '/disable/s/yes/no/' /etc/xinetd.d/telnet
允许root用户通过telnet登录
mv /etc/securetty /etc/securetty.old

service xinetd start
chkconfig telnet on
chkconfig xinetd on
