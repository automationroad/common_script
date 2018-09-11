#!/bin/bash
#uthor:hj
#lastChangeDate:2017-11-23
#version:0.1
#获取当前执行时间
d=`date "+%Y%m%d%H%M%S"`
#得到新的需要封的ip文件
tail -n 3000 /usr/local/nginx/logs/access.log |awk '{print $1,$12}' \
|grep -i -v -E "google|yahoo|baidu|msnbot|FeedSky|sogou" |awk '{print $1}' \
|awk '!/101.37.22.117/' | awk '!/113.111.63.203/' | awk '!/183.3.130.20/' |awk '!/113.111.61.166/' |awk '!/113.111.54.165/' \
|sort|uniq -c|sort -rn|awk '{if($1>100)print "deny "$2";"}' \
>/usr/local/nginx/conf/vhost/blockip${d}.conf
#新的需要封的ip文件跟已有的ip封锁文件对比，如果存在新的不在则加入ip封锁文件
grep -vwf /usr/local/nginx/conf/vhost/blockip.conf /usr/local/nginx/conf/vhost/blockip${d}.conf \
> /usr/local/nginx/conf/vhost/blockip_new.conf
#删除新的ip封锁文件
rm -rf	/usr/local/nginx/conf/vhost/blockip${d}.conf
cat /usr/local/nginx/conf/vhost/blockip_new.conf >> /usr/local/nginx/conf/vhost/blockip.conf
#重新加载Nginx配置
/usr/local/nginx/sbin/nginx -s reload