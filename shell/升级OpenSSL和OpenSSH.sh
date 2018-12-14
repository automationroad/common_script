说明，整个升级不一定顺利，为安全起见，开一下 telnet 服务，一定要创建普通用户，默认升级后root不能直连
# 先查看当前安装的版本
# 查看ssh版本
ssh -V
# 查看openssl版本
openssl version -a

# 安装 Zlib
wget http://www.zlib.net/zlib-1.2.11.tar.gz
tar -zxf zlib-1.2.11.tar.gz
cd zlib-1.2.11
./configure --prefix==/usr/local/zlib
make ; echo $?
make install ; echo $?

# 安装perl
cd -
wget https://www.cpan.org/src/5.0/perl-5.28.0.tar.gz
tar -zxf perl-5.28.0.tar.gz
cd perl-5.28.0
./Configure -des -Dprefix=/usr
make ; echo $?
make install ; echo $?
# 查询perl是否安装成功
perl -version

# 升级 OpenSSL
cd -
tar -zxf openssl-1.0.2n.tar.gz
cd openssl-1.0.2n
./config --prefix=/usr --shared zlib;echo $?
make -j8 ; echo $?
make test ; echo $?
make install ; echo $?
# 查看版本
openssl version -a

# OpenSSH
cd -
tar -zxf openssh-7.6p1.tar.gz
mv openssh-7.6p1 /usr/local/
cd /usr/local/openssh-7.6p1/
# 执行这一步之前检查一下有没有安装 pam-devel，否则报错，报错信息 'configure: error: PAM headers not found'
# Redhat6.6的pam版本 pam-devel-1.1.1-24.el6.x86_64 ，centos7.5 的pam版本 pam-devel-1.1.8-22.el7.x86_64
# 安装命令  yum install -y pam-devel
./configure --prefix=/usr --with-pam --with-zlib --with-md5-passwords ;echo $?
make -j8 ; echo $?
make -j8 install ; echo $?
cp ./contrib/redhat/sshd.init /etc/init.d/sshd
chmod +x /etc/init.d/sshd
# 查看sshd配置，因为安装的目录是这些包的默认目录，不需要修改，但是为了安全还是确认一下
vim /etc/init.d/sshd
# 25行
SSHD=/usr/sbin/sshd
# 41行
/usr/bin/ssh-keygen -A
# 在 ‘$SSHD $OPTIONS && success || failure’这一行上面加上一行  49行后面加
OPTIONS="-f /etc/ssh/sshd_config"

# 创建一个空文件
touch /etc/ssh/ssh_host_ecdsa_key.pub

# 重装服务端，不知道为什么一定要这样服务才能起来，这个方法偶然试到的
yum remove -y openssh-server
yum install -y openssh-server

# 重启服务

service sshd restart
#systemctl restart sshd