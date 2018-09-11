#!/bin/bash
#uthor:hj
#lastChangeDate:2018-03-26
#version:0.1
#describe：实现120服务器上的接口项目和定时器自动打包更新

#项目更新
update_path='/packs/update/'
updatenum=`ls ${update_path} | wc -l`
if [ ${updatenum} -gt 0 ];then
/bin/bash /home/bin/shutdownalltomcat.sh
ls ${update_path} | grep ^Util*.class
if [ $? -eq 0 ];then
	cp -f ${update_path}^Util*.class /opt/apache-tomcat-special/webapps/bxkc03757/WEB-INF/classes/com/bidizhaobiao/data/crawl/util/
	cp -f ${update_path}^Util*.class /opt/apache-tomcat-special/webapps/bxkc03760/WEB-INF/classes/com/bidizhaobiao/data/crawl/util/
	cp -f ${update_path}^Util*.class /opt/apache-tomcat-city/webapps/bxkcDS005/WEB-INF/classes/com/bidizhaobiao/data/crawl/util/
	cp -f ${update_path}^Util*.class /opt/apache-tomcat-city/webapps/bxkcDS006/WEB-INF/classes/com/bidizhaobiao/data/crawl/util/
	cp -f ${update_path}^Util*.class /opt/apache-tomcat-city/webapps/bxkcDS007/WEB-INF/classes/com/bidizhaobiao/data/crawl/util/
	cp -f ${update_path}^Util*.class /opt/apache-tomcat-city/webapps/bxkcDS008/WEB-INF/classes/com/bidizhaobiao/data/crawl/util/
	cp -f ${update_path}^Util*.class /opt/apache-tomcat-county1/webapps/bxkcQX001/WEB-INF/classes/com/bidizhaobiao/data/crawl/util/
	cp -f ${update_path}^Util*.class /opt/apache-tomcat-county1/webapps/bxkcQX002/WEB-INF/classes/com/bidizhaobiao/data/crawl/util/
	cp -f ${update_path}^Util*.class /opt/apache-tomcat-county1/webapps/bxkcQX003/WEB-INF/classes/com/bidizhaobiao/data/crawl/util/
	cp -f ${update_path}^Util*.class /opt/apache-tomcat-county1/webapps/bxkcQX004/WEB-INF/classes/com/bidizhaobiao/data/crawl/util/
	cp -f ${update_path}^Util*.class /opt/apache-tomcat-county2/webapps/bxkcQX005/WEB-INF/classes/com/bidizhaobiao/data/crawl/util/
	cp -f ${update_path}^Util*.class /opt/apache-tomcat-county2/webapps/bxkcQX006/WEB-INF/classes/com/bidizhaobiao/data/crawl/util/
	cp -f ${update_path}^Util*.class /opt/apache-tomcat-county2/webapps/bxkcQX007/WEB-INF/classes/com/bidizhaobiao/data/crawl/util/
	cp -f ${update_path}^Util*.class /opt/apache-tomcat-county2/webapps/bxkcQX008/WEB-INF/classes/com/bidizhaobiao/data/crawl/util/
	cp -f ${update_path}^Util*.class /opt/apache-tomcat-county2/webapps/bxkcQX009/WEB-INF/classes/com/bidizhaobiao/data/crawl/util/
	cp -f ${update_path}^Util*.class /opt/apache-tomcat-county3/webapps/bxkcE002/WEB-INF/classes/com/bidizhaobiao/data/crawl/util/
	cp -f ${update_path}^Util*.class /opt/apache-tomcat-county3/webapps/bxkcE003/WEB-INF/classes/com/bidizhaobiao/data/crawl/util/
	cp -f ${update_path}^Util*.class /opt/apache-tomcat-county3/webapps/bxkcE004/WEB-INF/classes/com/bidizhaobiao/data/crawl/util/
	cp -f ${update_path}^Util*.class /opt/apache-tomcat-county3/webapps/bxkcE005/WEB-INF/classes/com/bidizhaobiao/data/crawl/util/
fi
ls ${update_path} | grep ^ProclamationService*.class
if [ $? -eq 0 ];then
	cp -f ${update_path}^ProclamationService*.class /opt/apache-tomcat-special/webapps/bxkc03757/WEB-INF/classes/com/bidizhaobiao/data/crawl/service/
	cp -f ${update_path}^ProclamationService*.class /opt/apache-tomcat-special/webapps/bxkc03760/WEB-INF/classes/com/bidizhaobiao/data/crawl/service/
	cp -f ${update_path}^ProclamationService*.class /opt/apache-tomcat-city/webapps/bxkcDS005/WEB-INF/classes/com/bidizhaobiao/data/crawl/service/
	cp -f ${update_path}^ProclamationService*.class /opt/apache-tomcat-city/webapps/bxkcDS006/WEB-INF/classes/com/bidizhaobiao/data/crawl/service/
	cp -f ${update_path}^ProclamationService*.class /opt/apache-tomcat-city/webapps/bxkcDS007/WEB-INF/classes/com/bidizhaobiao/data/crawl/service/
	cp -f ${update_path}^ProclamationService*.class /opt/apache-tomcat-city/webapps/bxkcDS008/WEB-INF/classes/com/bidizhaobiao/data/crawl/service/
	cp -f ${update_path}^ProclamationService*.class /opt/apache-tomcat-county1/webapps/bxkcQX001/WEB-INF/classes/com/bidizhaobiao/data/crawl/service/
	cp -f ${update_path}^ProclamationService*.class /opt/apache-tomcat-county1/webapps/bxkcQX002/WEB-INF/classes/com/bidizhaobiao/data/crawl/service/
	cp -f ${update_path}^ProclamationService*.class /opt/apache-tomcat-county1/webapps/bxkcQX003/WEB-INF/classes/com/bidizhaobiao/data/crawl/service/
	cp -f ${update_path}^ProclamationService*.class /opt/apache-tomcat-county1/webapps/bxkcQX004/WEB-INF/classes/com/bidizhaobiao/data/crawl/service/
	cp -f ${update_path}^ProclamationService*.class /opt/apache-tomcat-county2/webapps/bxkcQX005/WEB-INF/classes/com/bidizhaobiao/data/crawl/service/
	cp -f ${update_path}^ProclamationService*.class /opt/apache-tomcat-county2/webapps/bxkcQX006/WEB-INF/classes/com/bidizhaobiao/data/crawl/service/
	cp -f ${update_path}^ProclamationService*.class /opt/apache-tomcat-county2/webapps/bxkcQX007/WEB-INF/classes/com/bidizhaobiao/data/crawl/service/
	cp -f ${update_path}^ProclamationService*.class /opt/apache-tomcat-county2/webapps/bxkcQX008/WEB-INF/classes/com/bidizhaobiao/data/crawl/service/
	cp -f ${update_path}^ProclamationService*.class /opt/apache-tomcat-county2/webapps/bxkcQX009/WEB-INF/classes/com/bidizhaobiao/data/crawl/service/
	cp -f ${update_path}^ProclamationService*.class /opt/apache-tomcat-county3/webapps/bxkcE002/WEB-INF/classes/com/bidizhaobiao/data/crawl/service/
	cp -f ${update_path}^ProclamationService*.class /opt/apache-tomcat-county3/webapps/bxkcE003/WEB-INF/classes/com/bidizhaobiao/data/crawl/service/
	cp -f ${update_path}^ProclamationService*.class /opt/apache-tomcat-county3/webapps/bxkcE004/WEB-INF/classes/com/bidizhaobiao/data/crawl/service/
	cp -f ${update_path}^ProclamationService*.class /opt/apache-tomcat-county3/webapps/bxkcE005/WEB-INF/classes/com/bidizhaobiao/data/crawl/service/
fi
/bin/bash /home/bin/startalltomcat.sh
rm -rf /packs/update/*
fi

#special定时器打包更新
warPacksPath='/packs/opt/'
cd ${warPacksPath}
bxkcA_num=`ls | grep 'bxkc03' | wc -l`
	if [ ${bxkcA_num} -gt 0 ];then
	kill -9 $(ps -ef | grep -v 'grep' | grep -v 'tail' | grep 'special' | awk '{print $2}')
	bxkcA_name=`ls | grep 'bxkc03'`
		for A_name in ${bxkcA_name}
			do
				Atmp=${A_name%.*}
				rm -rf /opt/apache-tomcat-special/webapps/${Atmp}*
				mv -f ${warPacksPath}${A_name} /opt/apache-tomcat-special/webapps/
			done
	/opt/apache-tomcat-special/bin/startup.sh
	cd ${warPacksPath}
	fi
#city定时器打包更新
bxkcDS_num=`ls | grep 'DS0' | wc -l`
	if [ ${bxkcDS_num} -gt 0 ];then
	kill -9 $(ps -ef | grep -v 'grep' | grep -v 'tail' | grep 'city' | awk '{print $2}')
	bxkcDS_name=`ls | grep 'DS0'`
		for DS_name in ${bxkcDS_name}
			do
				DStmp=${DS_name%.*}
				rm -rf /opt/apache-tomcat-city/webapps/${DStmp}*
				mv -f ${warPacksPath}${DS_name} /opt/apache-tomcat-city/webapps/
			done
	/opt/apache-tomcat-city/bin/startup.sh
	cd ${warPacksPath}
	fi
#county1定时器打包更新
bxkcQX_num=`ls | grep 'QX00[1324]' | wc -l`
	if [ ${bxkcQX_num} -gt 0 ];then
	kill -9 $(ps -ef | grep -v 'grep' | grep -v 'tail' | grep 'county1' | awk '{print $2}')
	bxkcQX_name=`ls | grep 'QX00[1324]'`
		for QX_name in ${bxkcQX_name}
			do
				QXtmp=${QX_name%.*}
				rm -rf /opt/apache-tomcat-county1/webapps/${QXtmp}*
				mv -f ${warPacksPath}${QX_name} /opt/apache-tomcat-county1/webapps/
			done
	/opt/apache-tomcat-county1/bin/startup.sh
	fi
#county2定时器打包更新
bxkcQX2_num=`ls | grep 'QX00[56789]' | wc -l`
	if [ ${bxkcQX2_num} -gt 0 ];then
	kill -9 $(ps -ef | grep -v 'grep' | grep -v 'tail' | grep 'county2' | awk '{print $2}')
	bxkcQX2_name=`ls | grep 'QX00[56789]'`
		for QX2_name in ${bxkcQX2_name}
			do
				QX2tmp=${QX2_name%.*}
				rm -rf /opt/apache-tomcat-county2/webapps/${QX2tmp}*
				mv -f ${warPacksPath}${QX2_name} /opt/apache-tomcat-county2/webapps/
			done
	/opt/apache-tomcat-county2/bin/startup.sh
	fi
#county3定时器打包更新
	bxkcOth_num=`ls | grep 'E00' | wc -l`
	if [ ${bxkcOth_num} -gt 0 ];then
	kill -9 $(ps -ef | grep -v 'grep' | grep -v 'tail' | grep 'county3' | awk '{print $2}')
	bxkcOth_name=`ls | grep 'E00'`
		for Oth_name in ${bxkcOth_name}
			do
				Othtmp=${Oth_name%.*}
				rm -rf /opt/apache-tomcat-county3/webapps/${Othtmp}*
				mv -f ${warPacksPath}${Oth_name} /opt/apache-tomcat-county3/webapps/
			done
	/opt/apache-tomcat-county3/bin/startup.sh
	fi

#接口打包更新
iwaPacksPath='/packs/projects/'
cd ${iwaPacksPath}
iwasNum=`ls | wc -l`
if [ ${iwasNum} -gt 0 ];then
	iwaName=`ls`
	for iwaPath in ${iwaName}
		do
			projectsName=${iwaPath%.*}
			echo ${projectsName}
			/projects/${projectsName}/internetware-phone-reactor/run-reactor-jsvc.sh stop
			sleep 2s
			#备份iwa
			mv -f /projects/${projectsName}/${projectsName}/${iwaPath} /projects/${projectsName}/${projectsName}/${iwaPath}.bak
			mv -f ${iwaPacksPath}${iwaPath} /projects/${projectsName}/${projectsName}/
			/projects/${projectsName}/internetware-phone-reactor/run-reactor-jsvc.sh start
		done
fi
