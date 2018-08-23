#!/bin/bash
#author：黄健
#created_time：2018-08-22
#description：保留tomcat日志脚本，以后复用修改tomcat项目路径和保留天数就可以了
#crontab : 55 23 * * *       sh /home/tomcat/script/backup_tomcat_log.sh  >& /dev/null

#tomcat路径
tomcat_path='/home/software/apache-tomcat-8.5.32/logs'
#保留天数
DATE=`date "+%Y-%m-%d"`
TENDAYSAGO=`date -d "-30 days" +%Y-%m-%d`    #保存30天日志，日志需要存放天数根据需要修改
cd ${tomcat_path}
cp catalina.out catalina.out.$DATE.log
echo > catalina.out
while [ -e catalina.out.$TENDAYSAGO.log ];do
  rm -rf catalina.out.$TENDAYSAGO.log
done
#删除其他的日志
  rm -rf $(ls -lt manager.* | awk '{print $9}' | sed -n "31,100p")
  rm -rf $(ls -lt localhost_access_log.* | awk '{print $9}' | sed -n "31,100p")
  rm -rf $(ls -lt host-manager.* | awk '{print $9}' | sed -n "31,100p")
  rm -rf $(ls -lt catalina.20* | awk '{print $9}' | sed -n "31,100p")