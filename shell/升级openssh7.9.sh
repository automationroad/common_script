# 说明，整个升级不一定顺利，为安全起见，开一下 telnet 服务，一定要创建普通用户，默认升级后root不能直连
# 先查看当前安装的版本
# 查看ssh版本
ssh -V
# 查看openssl版本
openssl version -a
# 查看zlib版本
rpm -q zlib
rpm -q gcc
rpm -q openssl
rpm -q openssl-devel

systemctl stop firewalld
systemctl disable firewalld
sed -i "s/SELINUX=enforcing/SELINUX=disabled/g" /etc/selinux/config
yum install -y gcc openssl openssl-devel
rpm -e `rpm -qa | grep openssh` --nodeps
install -v -m700 -d /var/lib/sshd
chown -v root:sys /var/lib/sshd
groupadd -g 50 sshd
useradd -c 'sshd PrivSep' -d /var/lib/sshd -g sshd -s /bin/false -u 50 sshd
wget -c http://ftp.openbsd.org/pub/OpenBSD/OpenSSH/portable/openssh-7.9p1.tar.gz
tar -zxf openssh-7.9p1.tar.gz
cd openssh-7.9p1
./configure --prefix=/usr --sysconfdir=/etc/ssh --with-md5-passwords --with-privsep-path=/var/lib/sshd
make
chmod 600 /etc/ssh/ssh_host_rsa_key
chmod 600 /etc/ssh/ssh_host_ecdsa_key
chmod 600 /etc/ssh/ssh_host_ed25519_key
make install
install -v -m755 contrib/ssh-copy-id /usr/bin
install -v -m644 contrib/ssh-copy-id.1 /usr/share/man/man1
install -v -m755 -d /usr/share/doc/openssh-7.9p1
install -v -m644 INSTALL LICENCE OVERVIEW README*
install -v -m644 INSTALL LICENCE OVERVIEW README* /usr/share/doc/openssh-7.9p1
# echo "PermitRootLogin yes" >> /etc/ssh/sshd_config
# 允许root远程登陆
sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin\ yes/g' /etc/ssh/sshd_config
# 禁止空密码
sed -i 's/#PermitEmptyPasswords\(.*\)/PermitEmptyPasswords\ no/g' /etc/ssh/sshd_config
# 写上新版ssh支持的算法
echo 'KexAlgorithms curve25519-sha256@libssh.org,ecdh-sha2-nistp256,ecdh-sha2-nistp384,ecdh-sha2-nistp521,diffie-hellman-group-exchange-sha256,diffie-hellman-group14-sha1,diffie-hellman-group-exchange-sha1,diffie-hellman-group1-sha1' >> /etc/ssh/sshd_config

cp -p contrib/redhat/sshd.init /etc/init.d/sshd
chmod +x /etc/init.d/sshd
chkconfig --add sshd
chkconfig sshd on
chkconfig --list sshd
systemctl start sshd
systemctl restart sshd


# 方法二，centos6
yum install -y gcc openssl-devel pam-devel rpm-build pam-devel
wget -c http://ftp.openbsd.org/pub/OpenBSD/OpenSSH/portable/openssh-7.9p1.tar.gz
tar -zxf openssh-7.9p1.tar.gz &&  cd openssh-7.9p1
./configure --prefix=/usr --sysconfdir=/etc/ssh --with-pam --with-zlib --with-md5-passwords --with-tcp-wrappers && make && make install
sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin\ yes/g' /etc/ssh/sshd_config
sed -i 's/#PermitEmptyPasswords\(.*\)/PermitEmptyPasswords\ no/g' /etc/ssh/sshd_config
sed -i 's/^SELINUX\(.*\)/SELINUX=disabled/g' /etc/selinux/config
echo 'KexAlgorithms curve25519-sha256@libssh.org,ecdh-sha2-nistp256,ecdh-sha2-nistp384,ecdh-sha2-nistp521,diffie-hellman-group-exchange-sha256,diffie-hellman-group14-sha1,diffie-hellman-group-exchange-sha1,diffie-hellman-group1-sha1' >> /etc/ssh/sshd_config
cp contrib/redhat/sshd.init /etc/init.d/sshd
chkconfig --add sshd
chkconfig sshd on
service sshd start
service sshd restart
chkconfig --list sshd
ssh -V