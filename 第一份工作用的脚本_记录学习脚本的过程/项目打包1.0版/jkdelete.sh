#!/bin/bash
#指定接口项目路径
eclipse='/mnt/d/Workspace/eclipse/'
#eclipse='/mnt/d/Workspace/jktest/'
#获取需要删除编号名称
projectname=`cat /mnt/d/Workspace/接口备注.xml | grep -v '编号' | awk '{print $1}'`
if test -n "${projectname}"
then
	for projectpath in ${projectname}
	do
		echo ${projectpath}
		#匹配编号对应的接口项目名称
		name=`cat /mnt/d/Workspace/接口备注.xml | grep ${projectpath} | awk '{print $2}'`
		echo ${name} >> /mnt/c/Users/User/Desktop/jktemp.txt
		#if [ ! ^0${projectpath} ]
		ls ${eclipse}${name}/src/ | egrep *[^0-9]${projectpath}[^0-9]* | xargs -I {} rm -rf ${eclipse}${name}/src/{}
		ls ${eclipse}${name}/internetware/ -R | egrep .*[^0-9]${projectpath}[^0-9]* | xargs -I {} rm -rf ${eclipse}${name}/internetware/{}
		egrep -n *[^0-9]${projectpath}[^0-9]* ${eclipse}${name}/project.xml | sed  's/:/ :/g' | awk '{print $1}' | \
		sort -r | xargs -I {} sed -i {}d ${eclipse}${name}/project.xml
		sum=`ag '<api-rsphandler>\s*</api-rsphandler>' ${eclipse}${name}/project.xml | sed  's/://g' | awk '{print $1}' | sort -r`
		for line in ${sum}
		do
			#echo ${line}
			sed -i ${line}d ${eclipse}${name}/project.xml
		done
	done
fi
#去重项目名
sort -d /mnt/c/Users/User/Desktop/jktemp.txt | uniq >> /mnt/c/Users/User/Desktop/接口修改.txt
rm -rf /mnt/c/Users/User/Desktop/jktemp.txt