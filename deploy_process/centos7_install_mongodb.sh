#!/bin/bash
# author：浪子尘心
# created_time：2018-09-11
# description：centos7下编译安装mongodb4.0.2
wget https://fastdl.mongodb.org/linux/mongodb-linux-x86_64-rhel70-4.0.2.tgz
# 创建mongodb用户，注意权限
groupadd mongodb
useradd -r -g mongodb -s /sbin/nologin -M mongodb
# 解压，移动
tar -zxf mongodb-linux-*-4.0.2.tgz
mv mongodb-linux-x86_64-rhel70-4.0.2 /usr/local
cd /usr/local
# 建立软连接，方便未来需要版本升级
ln -s mongodb-linux-x86_64-rhel70-4.0.2 mongodb
# 创建mongodb数据、日志、配置目录，可根据实际情况修改
mkdir ./mongodb/data ./mongodb/log ./mongodb/conf
touch ./mongodb/conf/mongod.conf << EOF
systemLog:
  destination: file
  logAppend: true
  path: /usr/local/mongodb/log/mongod.log
storage:
  dbPath: /usr/local/mongodb/data
  journal:
    enabled: true
processManagement:
  fork: true  # fork and run in background
  pidFilePath: /var/run/mongodb/mongod.pid  # location of pidfile
  timeZoneInfo: /usr/share/zoneinfo
net:
  port: 27017
  bindIp: 0.0.0.0
EOF
# 修改目录所属用户
chown -R mongodb:mongodb mongodb mongodb-linux-x86_64-rhel70-4.0.2
# 添加环境变量
echo '$PATH:/usr/local/mongodb/bin' >> /etc/profile
source /etc/profile
# 启动mongodb
/usr/local/mongodb/bin/mongod -f /usr/local/mongodb/bin/mongodb.conf
# 加入开机启动,这是没有启用验证的，启用验证需要修改启动方式
chmod +x /etc/rc.d/rc.local
echo '/usr/local/mongodb/bin/mongod -f /usr/local/mongodb/bin/mongodb.conf' >> /etc/rc.d/rc.local