#!/bin/bash
#uthor:hj
#lastChangeDate:2017-11-23
#version:0.1
#获取当前执行时间
d=`date "+%Y%m%d%H%M%S"`
#得到新的需要封的ip文件
tail -n 5000 /usr/local/nginx/logs/access.log \
|grep -i -v -E "google|360|baidu|sogou" |awk '{print $1}' | awk '!/121.46.18.113/' \
|awk '!/101.37.22.117/' | awk '!/^113.111/{print}' | awk '!/183.3.130.20/' \
|sort|uniq -c|sort -rn|awk '{if($1>150)print "deny "$2";"}' \
>/usr/local/nginx/conf/vhost/blockip${d}.conf

tail -n 5000 /home/bxkc/ip.log \
|grep -i -v -E "google|360|baidu|sogou" |awk '{print $1}' | awk '!/121.46.18.113/' \
|awk '!/101.37.22.117/' | awk '!/^113.111/{print}' | awk '!/183.3.130.20/' \
|sort|uniq -c|sort -rn|awk '{if($1>150)print "deny "$2";"}' \
>>/usr/local/nginx/conf/vhost/blockip${d}.conf

#新的需要封的ip文件跟已有的ip封锁文件对比，如果存在新的不在则加入ip封锁文件
grep -vwf /usr/local/nginx/conf/vhost/blockip.conf /usr/local/nginx/conf/vhost/blockip${d}.conf \
> /usr/local/nginx/conf/vhost/blockip_new.conf
#删除新的ip封锁文件
rm -rf  /usr/local/nginx/conf/vhost/blockip${d}.conf
cat /usr/local/nginx/conf/vhost/blockip_new.conf >> /usr/local/nginx/conf/vhost/blockip.conf
#重新加载Nginx配置
/usr/local/nginx/sbin/nginx -s reload