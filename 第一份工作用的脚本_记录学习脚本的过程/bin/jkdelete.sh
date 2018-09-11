#!/bin/bash
#指定接口项目路径
eclipse='/mnt/d/Workspace/eclipse/'
#eclipse='/mnt/d/Workspace/jktest/'
rm -rf /mnt/d/temp/project/*/*
rm -rf /mnt/d/temp/src/*/*
rm -rf /mnt/d/temp/internetware/*/*
echo > /mnt/d/temp/inte.log
#将开头是0的编号分离
#sed -i ""s/\r//"" /mnt/d/Workspace/接口备注.xml
cat /mnt/d/Workspace/接口备注.xml | grep -v '编号' | grep ^0 > /mnt/d/bin/zero.xml
cat /mnt/d/Workspace/接口备注.xml | grep -v '编号' | grep ^[^0] > /mnt/d/bin/nozero.xml
cat /mnt/c/Users/User/Desktop/接口修改.txt > /mnt/c/Users/User/Desktop/jktemp.txt
#删除编号开头为0的编号
if [ -f /mnt/d/bin/zero.xml ];then
projectname=`cat /mnt/d/bin/zero.xml | awk '{print $1}'`
	for projectpath in ${projectname}
	do
		echo ${projectpath}
		#匹配编号对应的接口项目名称
		name=`cat /mnt/d/bin/zero.xml | grep ${projectpath} | awk '{print $2}'`
		echo ${name} >> /mnt/c/Users/User/Desktop/jktemp.txt
		#异常情况判断，例如有一些以前的0开头编号命名的文件夹确实含有X、Y等字眼
		pronum=`egrep -n ${projectpath} ${eclipse}${name}/project.xml | grep -v 'DX' | grep -v 'Y0' | grep -v 'XX' | wc -l`
		[ ${pronum} -lt 5 ]&&echo ${projectpath} '异常'
		[ ${pronum} -lt 5 ]&&echo ${projectpath} '异常' >> /mnt/d/temp/inte.log
		#操作文件所在行备份
		egrep -n ${projectpath} ${eclipse}${name}/project.xml | grep -v 'DX' | grep -v 'Y0' | grep -v 'XX' > /mnt/d/temp/project/${name}/${projectpath}project.xml
		#编号所在行替换为空白行
		egrep -n ${projectpath} ${eclipse}${name}/project.xml| grep -v 'DX' | grep -v 'Y0' | grep -v 'XX' | sed 's/:/ :/g' | awk '{print $1}' | xargs -I {} sed -i {}s/.*//g ${eclipse}${name}/project.xml
		#备份src
		find ${eclipse}${name}/src/ -type d -name *[^0XY]${projectpath}* | grep -q ${projectpath}
		if [ $? -ne 0 ];then
			echo ${projectpath}' 未找到src文件夹' ${name}
			echo ${projectpath}' 未找到src文件夹' ${name} >> /mnt/d/temp/inte.log
		fi
		find ${eclipse}${name}/src/ -type d -name *[^0XY]${projectpath}* | xargs -I {} mv -f {} /mnt/d/temp/src/${name}
		#备份internetware
		#find ${eclipse}${name}/internetware/ -type d -name *[^0XY]${projectpath}* | xargs -I {} mv -f {} /mnt/d/temp/internetware/
		find ${eclipse}${name}/internetware/ -maxdepth 1 -name *[^0XY]${projectpath}* | grep -q ${projectpath}
		if [ $? -eq 0 ]; then
			find ${eclipse}${name}/internetware/ -maxdepth 1 -name *[^0XY]${projectpath}* | xargs -I {} mv -f {} /mnt/d/temp/internetware/${name}
		else
			#统计编号的第一个internetware所在行含有1个还是2个编号
			sum=`egrep *${projectpath}* /mnt/d/temp/project/${name}/${projectpath}project.xml | grep 'internetware' | head -n 1 | grep -o ${projectpath} | grep -c ${projectpath}`
			#echo ${sum}
			if [ ${sum} -eq 2 ];then
				#得到编号的internetware第一级路径
				#onepath=`egrep *${projectpath}* /mnt/d/temp/${projectpath}project.xml | grep 'internetware' | head -n 1 | sed 's/.*ware\\//g' | sed 's/\\api.*//g'`
				#移动一级目录
				#mv -f ${eclipse}${name}/internetware/${onepath} /mnt/d/temp/internetware/
				egrep *${projectpath}* /mnt/d/temp/project/${name}/${projectpath}project.xml | grep 'internetware' | head -n 1 | sed 's/.*ware\\//g' | sed 's/\\api.*//g' | xargs -I {} mv -f ${eclipse}${name}/internetware/{} /mnt/d/temp/internetware/${name}
			elif [ ${sum} -eq 1 ];then
				#得到编号的internetware第二级路径，并移动所有的二级目录
				egrep *${projectpath}* /mnt/d/temp/project/${name}/${projectpath}project.xml | grep 'internetware' | grep 'internetware' | sed 's/.*>\\//g' | sed 's/<.*//' | sed 's/\\/\//g' | xargs -I {} mv -f ${eclipse}${name}/{} /mnt/d/temp/internetware/${name}
			else
				echo ${projectpath}' 未找到internetware文件夹' ${name}
				echo ${projectpath}' 未找到internetware文件夹' ${name} >> /mnt/d/temp/inte.log
			fi
		fi
	done
fi

#删除编号开头非0的编号
if [ -f /mnt/d/bin/nozero.xml ]; then
projectname1=`cat /mnt/d/bin/nozero.xml | awk '{print $1}'`
	for projectpath1 in ${projectname1}
	do
		echo ${projectpath1}
		#匹配编号对应的接口项目名称
		name1=`cat /mnt/d/bin/nozero.xml | grep ${projectpath1} | awk '{print $2}'`
		echo ${name1} >> /mnt/c/Users/User/Desktop/jktemp.txt
		#操作文件所在行备份
		egrep -n ${projectpath1} ${eclipse}${name1}/project.xml > /mnt/d/temp/project/${name1}/${projectpath1}project.xml
		#编号所在行替换为空白行
		egrep -n ${projectpath1} ${eclipse}${name1}/project.xml | sed 's/:/ :/g' | awk '{print $1}' | xargs -I {} sed -i {}s/.*//g ${eclipse}${name1}/project.xml
		#备份src
		find ${eclipse}${name1}/src/ -type d -name *${projectpath1}* | xargs -I {} mv -f {} /mnt/d/temp/src/${name1}
		#备份internetware
		find ${eclipse}${name1}/internetware/ -maxdepth 1 -name *${projectpath1}* | xargs -I {} mv -f {} /mnt/d/temp/internetware/${name1}
	done
fi

#去重项目名
sort -d /mnt/c/Users/User/Desktop/jktemp.txt | uniq >> /mnt/c/Users/User/Desktop/接口修改.txt
rm -rf /mnt/c/Users/User/Desktop/jktemp.txt
rm -rf /mnt/d/bin/zero.xml
rm -rf /mnt/d/bin/nozero.xml

#清除所有修改项目下的project.xml空值标签
proname=`cat /mnt/c/Users/User/Desktop/接口修改.txt`
for pro in ${proname}
do
	sed -i '/^\s*$/d' ${eclipse}${pro}/project.xml
	ag '<api-rsphandler>\s*?</api-rsphandler>' ${eclipse}${pro}/project.xml | sed 's/:/ :/g' | awk '{print $1}' | sort -brn | xargs -I {} sed -i {}d ${eclipse}${pro}/project.xml
done