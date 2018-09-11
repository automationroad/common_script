#!/bin/bash
LOGPATH=/opt/apache-tomcat-special/logs  #catalina.out 存放路径根据实际情况修改
DATE=`date "+%Y-%m-%d"`
TENDAYSAGO=`date -d "-7 days" +%Y-%m-%d`    #保存7天日志，日志需要存放天数根据需要修改
cd $LOGPATH
cp catalina.out catalina.out.$DATE       
echo > catalina.out
while [ -e catalina.out.$TENDAYSAGO ];do
        rm -rf catalina.out.$TENDAYSAGO
done
rm -rf $(ls -lt manager.* | awk '{print $9}' | sed -n "8,100p")
rm -rf $(ls -lt localhost_access_log.* | awk '{print $9}' | sed -n "8,100p")
rm -rf $(ls -lt localhost.* | awk '{print $9}' | sed -n "8,100p")
rm -rf $(ls -lt host-manager.* | awk '{print $9}' | sed -n "8,100p")
rm -rf $(ls -lt catalina.20* | awk '{print $9}' | sed -n "8,100p")