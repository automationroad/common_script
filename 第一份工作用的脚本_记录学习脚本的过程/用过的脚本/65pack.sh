#!/bin/bash
#uthor:hj
#lastChangeDate:2018-01-03
#version:0.1
#describe：接口项目打包更新

#定义更新包路径
pack_110='/packs/110/'
pack_120='/packs/120'

cd ${pack_110}
iwasNum=`ls | wc -l`
iwaName=`ls`
if [ ${iwasNum} -gt 0 ];then
	for iwaPath in ${iwaName}
		do
			projectsName=${iwaPath%.*}
            echo bxkc${projectsName}
			/projects/110bxkc/bxkc${projectsName}/internetware-phone-reactor/run-reactor-jsvc.sh stop
			sleep 2s
			mv -f /projects/110bxkc/bxkc${projectsName}/bxkc${projectsName}/${iwaPath} /projects/110bxkc/bxkc${projectsName}/bxkc${projectsName}/${iwaPath}.bak
			mv -f ${iwaPacksPath}${iwaPath} /projects/110bxkc/bxkc${projectsName}/bxkc${projectsName}/
			/projects/110bxkc/bxkc${projectsName}/internetware-phone-reactor/run-reactor-jsvc.sh start
		done
fi

cd ${pack_120}
iwasNum1=`ls | wc -l`
if [ ${iwasNum1} -gt 0 ];then
	iwaName1=`ls`
	for iwaPath1 in ${iwaName1}
		do
			projectsName1=${iwaPath1%.*}
			echo ${projectsName1}
			/projects/120bxkc/${projectsName1}/internetware-phone-reactor/run-reactor-jsvc.sh stop
			sleep 2s
			#备份iwa
			mv -f /projects/120bxkc/${projectsName1}/${projectsName1}/${iwaPath1} /projects/120bxkc/${projectsName1}/${projectsName1}/${iwaPath1}.bak
			mv -f ${iwaPacksPath1}${iwaPath1} /projects/120bxkc/${projectsName1}/${projectsName1}/
			/projects/120bxkc/${projectsName1}/internetware-phone-reactor/run-reactor-jsvc.sh start
		done
fi