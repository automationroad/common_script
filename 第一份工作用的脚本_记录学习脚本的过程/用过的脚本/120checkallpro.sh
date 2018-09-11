#!/bin/bash
#检查110所有的接口项目和入库项目状态
#每个接口项目下的进程数统计
echo > /home/bin/allprostatus.log
statusnum=`netstat -tunlp | grep 'jsvc' | egrep :::1[6-7][0-9][0-9] | wc -l`
if [ ${statusnum} -eq 14 ];then
	echo '接口全部已经启动' >> /home/bin/allprostatus.log
	#检查各个接口项目
	num=`netstat -tunlp | grep 'jsvc' | egrep -o 1[6-7][0-9][0-9]`
	for pro in ${num}
	do
		#进程数统计
		processnum=`lsof -i:${pro} | wc -l`
		[ ${processnum} -gt 100 ]&&grep ${pro} /home/bin/apiaddr.txt | awk '{print $1}' | xargs -I {}  echo {} '超过安全值，请检查' >> /home/bin/allprostatus.log
	done
else
	 echo '120还有接口项目未启动' >> /home/bin/allprostatus.log
	 echo '120还有接口项目未启动' | mail -s '110还有接口项目未启动' 536418286@qq.com
fi
#定时器检查
citynum=`ps aux | grep 'apache-tomcat-city' | grep -v 'grep' | awk '{print $2}'`
if [ ${citynum} ];then
	echo 'apache-tomcat-city启动正常，进程号为：' ${citynum} >> /home/bin/allprostatus.log
else
	echo 'apache-tomcat-city未启动' >> /home/bin/allprostatus.log
	echo 'apache-tomcat-city未启动' | mail -s 'apache-tomcat-city未启动' 536418286@qq.com
fi
specialnum=`ps aux | grep 'apache-tomcat-special' | grep -v 'grep' | awk '{print $2}'`
if [ ${specialnum} ];then
	echo 'apache-tomcat-special启动正常，进程号为：' ${specialnum} >> /home/bin/allprostatus.log
else
	echo 'apache-tomcat-special未启动' >> /home/bin/allprostatus.log
	echo 'apache-tomcat-special未启动' | mail -s 'apache-tomcat-special未启动' 536418286@qq.com
fi
county1num=`ps aux | grep 'apache-tomcat-county1' | grep -v 'grep' | awk '{print $2}'`
if [ ${county1num} ];then
	echo 'apache-tomcat-county1启动正常，进程号为：' ${county1num} >> /home/bin/allprostatus.log
else
	echo 'apache-tomcat-county1未启动' >> /home/bin/allprostatus.log
	echo 'apache-tomcat-county1未启动' | mail -s 'apache-tomcat-county1未启动' 536418286@qq.com
fi
county2num=`ps aux | grep 'apache-tomcat-county2' | grep -v 'grep' | awk '{print $2}'`
if [ ${county2num} ];then
	echo 'apache-tomcat-county2启动正常，进程号为：' ${county2num} >> /home/bin/allprostatus.log
else
	echo 'apache-tomcat-county2未启动' >> /home/bin/allprostatus.log
	echo 'apache-tomcat-county2未启动' | mail -s 'apache-tomcat-county2未启动' 536418286@qq.com
fi
county3num=`ps aux | grep 'apache-tomcat-county3' | grep -v 'grep' | awk '{print $2}'`
if [ ${county3num} ];then
	echo 'apache-tomcat-county3启动正常，进程号为：' ${county3num} >> /home/bin/allprostatus.log
else
	echo 'apache-tomcat-county3未启动' >> /home/bin/allprostatus.log
	echo 'apache-tomcat-county3未启动' | mail -s 'apache-tomcat-county3未启动' 536418286@qq.com
fi

#统计日志内容行数来判断是否需要发送邮件通知
sed -i '/^\s*$/d' /home/bin/allprostatus.log
lognum=`cat /home/bin/allprostatus.log | wc -l`
[ ${lognum} -gt 5 ]&&mail -s '120有接口项目超过安全进程值，请检查' 536418286@qq.com < /home/bin/allprostatus.log