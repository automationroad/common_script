#!/bin/bash
#定义定时器工作路径
myeclipse='/mnt/d/Workspace/Myeclipse/'
impl='/src/com/bidizhaobiao/data/crawl/service/impl/'
#定义接口工作路径
eclipse='/mnt/d/Workspace/eclipse/'
#读取需要删除的编号
name=`cat /mnt/d/Workspace/需要删除的编号.xml | awk '{print $1}' | sed "s/-.*//g" | sort -d | uniq`
for project in ${name}
do
	#得到去重后的定时器项目名称
	#echo ${project}
	num=`grep "${project}" ${myeclipse}*/config/services.xml | awk '{print $1}' | sed "s/Myeclipse\//Myeclipse\/ /g" | sed "s/\/config/ \/config/g" | awk '{print $2}' | uniq`
	if test -n "${num}"
	then
		echo ${project}		${num}
		#echo ${project}		${num}>>/mnt/d/Workspace/定时器备注.xml
		#得到编号所在定时器ip
		ip=`find ${myeclipse}${num}${impl} -type f -name *${project}* | head -n 1 | xargs cat | grep 'listUrl' | ag -o "(?<=//)([^/]+)(?=/)"`
		#得到编号所属接口项目
		projects=`grep ${ip} /mnt/c/Users/User/Desktop/apiaddr.txt | awk '{print $1}'`
		echo ${project}		${projects}
		#echo ${project}		${projects}>>/mnt/d/Workspace/接口备注.xml
	fi
done

