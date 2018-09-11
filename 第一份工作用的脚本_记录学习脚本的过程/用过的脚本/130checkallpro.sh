#!/bin/bash
#检查110所有的接口项目和入库项目状态
#每个接口项目下的进程数统计
#定时器检查
echo > /home/bin/allprostatus.log
specialnum=`ps aux | grep 'apache-tomcat-special' | grep -v 'grep' | awk '{print $2}'`
if [ ${specialnum} ];then
	echo 'apache-tomcat-special启动正常，进程号为：' ${specialnum} >> /home/bin/allprostatus.log
else
	echo 'apache-tomcat-special未启动' >> /home/bin/allprostatus.log
	echo 'apache-tomcat-special未启动' | mail -s 'apache-tomcat-special未启动' 536418286@qq.com
fi
city1num=`ps aux | grep 'apache-tomcat-city1' | grep -v 'grep' | awk '{print $2}'`
if [ ${city1num} ];then
	echo 'apache-tomcat-city1启动正常，进程号为：' ${city1num} >> /home/bin/allprostatus.log
else
	echo 'apache-tomcat-city1未启动' >> /home/bin/allprostatus.log
	echo 'apache-tomcat-city1未启动' | mail -s 'apache-tomcat-city1未启动' 536418286@qq.com
fi
city2num=`ps aux | grep 'apache-tomcat-city2' | grep -v 'grep' | awk '{print $2}'`
if [ ${city2num} ];then
	echo 'apache-tomcat-city2启动正常，进程号为：' ${city2num} >> /home/bin/allprostatus.log
else
	echo 'apache-tomcat-city2未启动' >> /home/bin/allprostatus.log
	echo 'apache-tomcat-city2未启动' | mail -s 'apache-tomcat-city2未启动' 536418286@qq.com
fi
city3num=`ps aux | grep 'apache-tomcat-city3' | grep -v 'grep' | awk '{print $2}'`
if [ ${city3num} ];then
	echo 'apache-tomcat-city3启动正常，进程号为：' ${city3num} >> /home/bin/allprostatus.log
else
	echo 'apache-tomcat-city3未启动' >> /home/bin/allprostatus.log
	echo 'apache-tomcat-city3未启动' | mail -s 'apache-tomcat-city3未启动' 536418286@qq.com
fi
baidubaipinnum=`ps aux | grep 'apache-tomcat-baidubaipin' | grep -v 'grep' | awk '{print $2}'`
if [ ${baidubaipinnum} ];then
	echo 'apache-tomcat-baidubaipin启动正常，进程号为：' ${baidubaipinnum} >> /home/bin/allprostatus.log
else
	echo 'apache-tomcat-baidubaipin未启动' >> /home/bin/allprostatus.log
	echo 'apache-tomcat-baidubaipin未启动' | mail -s 'apache-tomcat-city3未启动' 536418286@qq.com
fi