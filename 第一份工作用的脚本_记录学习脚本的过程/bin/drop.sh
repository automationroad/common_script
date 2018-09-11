#!/bin/bash
#uthor:hj
#lastChangeDate:2017-12-09
#version:0.2
#describe：项目打包更新

#接口测试目录
jkpath='/mnt/d/Workspace/eclipse/'
dsqpath='/mnt/d/Workspace/Myeclipse/'
#更新路径源
updatepath='/mnt/c/Users/User/Desktop/打包更新/更新文件/未更新/'
#指定新增接口存放目录
newjk=xinan
#指定ip
oldip='127.0.0.1:1627'
newip=`cat /mnt/c/Users/User/Desktop/apiaddr.txt | grep "${newjk}[^0-9]" | awk '{print $2}'`
#定时器路径末端名称
impl='/src/com/bidizhaobiao/data/crawl/service/impl/'
#指定新增定时器存放路径
DSdsq=bxkcDS021
QXdsq=bxkcQX009
XXdsq=bxkcE003
YYdsq=bxkcE005
#省级级别区分比较多...
SJAdsq=bxkcA001
SJBdsq=bxkcB001
SJCdsq=bxkcC001
SJDdsq=bxkcD001
SJEdsq=bxkcE001
#记录操作
cat /mnt/c/Users/User/Desktop/接口修改.txt > /mnt/c/Users/User/Desktop/jktemp.txt
cat /mnt/c/Users/User/Desktop/定时器修改.txt > /mnt/c/Users/User/Desktop/dsqtemp.txt
#进入更新路径目录并开始检查操作
protime=`date +%Y`
cd ${updatepath}
updatenum=`ls | grep -v ".*zip" | grep -v ".*rar" | grep -v ".*xlsx" | grep -v ".*xlsm" | grep -v ".*txt" | grep ${protime} | wc -l`
updatename=`ls | grep -v ".*zip" | grep -v ".*rar" | grep -v ".*xlsx" | grep -v ".*xlsm" | grep -v ".*txt" | grep ${protime}`
if [ ${updatenum} -gt 0 ];then
	for path in ${updatename}
		do
			cd ./${path}/
			#新增的处理
			xz=`ls | grep -v ".*xlsx"  | grep -v ".*xlsm" | grep -v ".*txt" | grep '新增'`
			if test -n "${xz}"
			#直接新增，不对接口种类划分
			then 
				#接口处理
				cp -r ./${xz}/接口/src/* ${jkpath}${newjk}/src/
				cp -r ./${xz}/接口/internetware/* ${jkpath}${newjk}/internetware/
				#删除新增的projects配置文件的空白行，很重要！
				sed -i '/^\s*$/d' ./${xz}/接口/project.xml
				#api-rsphandlerb部分复制
				rsphandlertart=`cat -n ./${xz}/接口/project.xml | grep "<api-rsphandler>" | awk '{print $1}' | head -n 1`
				rsphandlerend=`cat -n ./${xz}/接口/project.xml | grep "</api-rsphandler>" | awk '{print $1}' | tail -n 1`
				cat ./${xz}/接口/project.xml | sed -n "${rsphandlertart},${rsphandlerend}p" > /mnt/d/Workspace/test.xml
				sed -i "/<api-rsphandlers>/r /mnt/d/Workspace/test.xml" ${jkpath}${newjk}/project.xml
				#ordered-apis部分复制
				apisstart=`cat -n ./${xz}/接口/project.xml | grep "<ordered-apis>" | awk '{print $1}'`
				apisstend=`cat -n ./${xz}/接口/project.xml | grep "</ordered-apis>" | awk '{print $1}'`
				cat ./${xz}/接口/project.xml | sed -n "${apisstart},${apisstend}p" | grep -v 'ordered-apis' > /mnt/d/Workspace/test.xml
				sed -i "/<ordered-apis>/r /mnt/d/Workspace/test.xml" ${jkpath}${newjk}/project.xml
				#将处理的接口名称写入到文件中
				echo ${newjk} >> /mnt/c/Users/User/Desktop/jktemp.txt
				
				#定时器处理
				#对所有新增的入库文件进行ip替换
				find ./${xz}/入库/ -type f -name *.java | xargs sed -i "s/${oldip}/${newip}/g"
				#判断是否有 其他 这个目录
				dsqname=`ls ./${xz}/入库/  | grep '其'`
				if test -n "${dsqname}"
				then
					DSnum=`ls ./${xz}/入库/${dsqname}/impl/  | grep 'DS'`
					XXnum=`ls ./${xz}/入库/${dsqname}/impl/  | grep 'XX'`
					YYnum=`ls ./${xz}/入库/${dsqname}/impl/  | grep 'Y0'`
					QXnum=`ls ./${xz}/入库/${dsqname}/impl/  | grep 'QX'`
					#根据其他目录里面定时器种类进行区分存放
					if test -n "${DSnum}"
					then
						cp -f ./${xz}/入库/${dsqname}/impl/[DS]* ${dsqpath}${DSdsq}${impl}
						cat ./${xz}/入库/${dsqname}/services.xml | grep 'DS' > /mnt/d/Workspace/test.xml
						sed -i "/<services>/r /mnt/d/Workspace/test.xml" ${dsqpath}${DSdsq}/config/services.xml
						sed -i '/^\s*$/d' ${dsqpath}${DSdsq}/config/services.xml
						echo ${DSdsq} >> /mnt/c/Users/User/Desktop/dsqtemp.txt
					fi
					if test -n "${XXnum}"
					then
						cp -f ./${xz}/入库/${dsqname}/impl/[XX]* ${dsqpath}${XXdsq}${impl}
						cat ./${xz}/入库/${dsqname}/services.xml | grep 'XX' > /mnt/d/Workspace/test.xml
						sed -i "/<services>/r /mnt/d/Workspace/test.xml" ${dsqpath}${XXdsq}/config/services.xml
						sed -i '/^\s*$/d' ${dsqpath}${XXdsq}/config/services.xml
						echo ${XXdsq} >> /mnt/c/Users/User/Desktop/dsqtemp.txt
					fi
					if test -n "${YYnum}"
					then
						cp -f ./${xz}/入库/${dsqname}/impl/*Y0* ${dsqpath}${YYdsq}${impl}
						cat ./${xz}/入库/${dsqname}/services.xml | grep 'Y0' > /mnt/d/Workspace/test.xml
						sed -i "/<services>/r /mnt/d/Workspace/test.xml" ${dsqpath}${YYdsq}/config/services.xml
						sed -i '/^\s*$/d' ${dsqpath}${YYdsq}/config/services.xml
						echo ${YYdsq} >> /mnt/c/Users/User/Desktop/dsqtemp.txt
					fi
					if test -n "${QXnum}"
					then
						cp -f ./${xz}/入库/${dsqname}/impl/[QX]* ${dsqpath}${QXdsq}${impl}
						cat ./${xz}/入库/${dsqname}/services.xml | grep 'QX' > /mnt/d/Workspace/test.xml
						sed -i "/<services>/r /mnt/d/Workspace/test.xml" ${dsqpath}${QXdsq}/config/services.xml
						sed -i '/^\s*$/d' ${dsqpath}${QXdsq}/config/services.xml
						echo ${QXdsq} >> /mnt/c/Users/User/Desktop/dsqtemp.txt
					fi
				fi
				#当有 省级定时器 这个目录情况
				SJname=`ls ./${xz}/入库/ | grep -v '其'`
				if test -n "${SJname}"
				then
					for SJpath in ${SJname}
					do
						newSJ="bxkc${SJpath}001"
						cp -r ./${xz}/入库/${SJpath}/impl/* ${dsqpath}${newSJ}${impl}
						cat ./${xz}/入库/${SJpath}/services.xml | grep 'enable' > /mnt/d/Workspace/test.xml
						sed -i "/<services>/r /mnt/d/Workspace/test.xml" ${dsqpath}${newSJ}/config/services.xml
						sed -i '/^\s*$/d' ${dsqpath}${newSJ}/config/services.xml
						echo ${newSJ} >> /mnt/c/Users/User/Desktop/dsqtemp.txt
					done
				fi
			fi
			
			#修改的处理
			xg=`ls | grep '修改' | grep -v ".*xlsx" | grep -v ".*xlsm" | grep -v ".*txt"`
			if test -n "${xg}"
			then
				#处理修改接口
				jkname=`ls ./${xg}/接口/`
				if test -n "${jkname}"
				then
				for projectname in ${jkname}
				do
					echo ${projectname} >> /mnt/c/Users/User/Desktop/jktemp.txt
					[ -d ./${xg}/接口/${projectname}/src/ ]
					cp -rf ./${xg}/接口/${projectname}/src/* ${jkpath}${projectname}/src/
					[ -d ./${xg}/接口/${projectname}/internetware/ ]
					cp -rf ./${xg}/接口/${projectname}/internetware/* ${jkpath}${projectname}/internetware/
					#删除新增的projects配置文件的空白行，很重要！
					[ -f ./${xg}/接口/${projectname}/project.xml ]
					sed -i '/^\s*$/d' ./${xg}/接口/${projectname}/project.xml
					#api-rsphandlerb部分复制
					rsphandlertart1=`cat -n ./${xg}/接口/${projectname}/project.xml | grep "<api-rsphandler>" | awk '{print $1}' | head -n 1`
					rsphandlerend1=`cat -n ./${xg}/接口/${projectname}/project.xml | grep "</api-rsphandler>" | awk '{print $1}' | tail -n 1`
					cat ./${xg}/接口/${projectname}/project.xml | sed -n "${rsphandlertart1},${rsphandlerend1}p" > /mnt/d/Workspace/test.xml
					sed -i "/<api-rsphandlers>/r /mnt/d/Workspace/test.xml" ${jkpath}${projectname}/project.xml
					#ordered-apis部分复制
					apisstart1=`cat -n ./${xg}/接口/${projectname}/project.xml | grep "<ordered-apis>" | awk '{print $1}'`
					apisstend1=`cat -n ./${xg}/接口/${projectname}/project.xml | grep "</ordered-apis>" | awk '{print $1}'`
					cat ./${xg}/接口/${projectname}/project.xml | sed -n "${apisstart1},${apisstend1}p" | grep -v 'ordered-apis' > /mnt/d/Workspace/test.xml
					sed -i "/<ordered-apis>/r /mnt/d/Workspace/test.xml" ${jkpath}${projectname}/project.xml
				done
				fi
				#处理修改入库
				changedsq=`ls ./${xg}/入库/`
				if test -n "${changedsq}"
				then
				for newdsq in ${changedsq}
				do
					echo "${newdsq}" >> /mnt/c/Users/User/Desktop/dsqtemp.txt
					cp -rf ./${xg}/入库/${newdsq}/impl/* ${dsqpath}${newdsq}${impl}
					#去除空白行首行尾字符串
					[ -f ./${xg}/入库/${newdsq}/services.xml ]
					sed -i 's/^[ \t]*//g' ${dsqpath}${newdsq}/config/services.xml
					sed -i 's/^[ \t]*//g' ./${xg}/入库/${newdsq}/services.xml
					sed -i 's/[ \t]*$//g' ${dsqpath}${newdsq}/config/services.xml
					sed -i 's/[ \t]*$//g' ./${xg}/入库/${newdsq}/services.xml
					#对比不同的文本行以及写入
					grep -vwf ${dsqpath}${newdsq}/config/services.xml ./${xg}/入库/${newdsq}/services.xml > /mnt/d/Workspace/test.xml
					sed -i "/<services>/r /mnt/d/Workspace/test.xml" ${dsqpath}${newdsq}/config/services.xml
					sed -i '/^\s*$/d' ${dsqpath}${newdsq}/config/services.xml
				done
				fi
			fi
			#回到未更新这个目录
			cd -
		done
fi
#去重项目名 
sort -d /mnt/c/Users/User/Desktop/jktemp.txt | uniq > /mnt/c/Users/User/Desktop/接口修改.txt
rm -rf /mnt/c/Users/User/Desktop/jktemp.txt
sort -d /mnt/c/Users/User/Desktop/dsqtemp.txt | uniq > /mnt/c/Users/User/Desktop/定时器修改.txt
rm -rf /mnt/c/Users/User/Desktop/dsqtemp.txt