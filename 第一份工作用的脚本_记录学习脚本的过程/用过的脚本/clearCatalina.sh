#!/bin/bash
#uthor:hj
#lastChangeDate:2017-10-09
#version:0.2

#切割并删除目录下的文件
specialLOGPATH=/opt/apache-tomcat-special/logs/  #catalina.out 存放路径根据实际情况修改
city1LOGPATH=/opt/apache-tomcat-city1/logs/
city2LOGPATH=/opt/apache-tomcat-city2/logs/
city3LOGPATH=/opt/apache-tomcat-city3/logs/
baidubaipinLOGPATH=/opt/apache-tomcat-baidubaipin/logs/
DATE=`date "+%Y-%m-%d"`
TENDAYSAGO=`date -d "-7 days" +%Y-%m-%d`    #保存7天日志，日志需要存放天数根据需要修改
for path in $specialLOGPATH $city1LOGPATH $city2LOGPATH $city3LOGPATH $baidubaipinLOGPATH
do
cd ${path}
cp catalina.out catalina.out.$DATE.log
echo > catalina.out
while [ -e catalina.out.$TENDAYSAGO.log ];do
        rm -rf catalina.out.$TENDAYSAGO.log
done
rm -rf $(ls -lt manager.* | awk '{print $9}' | sed -n "8,100p")
rm -rf $(ls -lt localhost_access_log.* | awk '{print $9}' | sed -n "8,100p")
rm -rf $(ls -lt localhost.* | awk '{print $9}' | sed -n "8,100p")
rm -rf $(ls -lt host-manager.* | awk '{print $9}' | sed -n "8,100p")
rm -rf $(ls -lt catalina.20* | awk '{print $9}' | sed -n "8,100p")
for documentpath in $(ls -F | grep /$ | sed 's/\///g')
do
cd ${path}${documentpath}
rm -rf $(ls -lt info.log.20* | awk '{print $9}' | sed -n "8,100p")
rm -rf $(ls -lt error.log.20* | awk '{print $9}' | sed -n "8,100p")
done
done

#燕云日志清理
bxkcproject=`cat /home/bin/checkProjectsStatus.sh | grep 'echo' | awk '{print $2}' | sed 's/"//g'`
for pro in  ${bxkcproject}
do
echo > /projects/${pro}/internetware-phone-reactor/Internetware-phone-reactor.err
done
