#!/bin/bash
#author:linjinxing
#lastChangeDate:2017-11-23
#version:0.1
#获取当前执行时间
d=`date "+%Y%m%d%H%M%S"`
#得到新的需要封的ip文件
tail -n 5000 /usr/local/apache-tomcat-7.0.67/logs/catalina.out \
| grep -i logininterceptor | grep info | sed 's/or:/or: /g' | sed 's/->/ ->/g' \
| awk '{print $3}' |awk '!/101.37.22.117/' | awk '!/^113.111/{print}' | awk '!/183.3.130.20/' \
| sort | uniq -c | sort -rn \
| awk '{if($1>100)print "iptables -I INPUT -s "$2" -j DROP"}' \
> /home/iptables_blockip${d}.sh
#新的需要封的ip文件跟已有的ip封锁文件对比，如果存在新的不在则加入ip封锁文件
grep -vwf /home/iptables_blockip.sh /home/iptables_blockip${d}.sh \
> /home/iptables_blockip_new.sh
#删除新的ip封锁文件
rm -rf  /home/iptables_blockip${d}.sh
cat /home/iptables_blockip_new.sh >> /home/iptables_blockip.sh
#运行脚本
/home/iptables_blockip_new.sh
#重启iptables
service iptables save
systemctl restart iptables.service