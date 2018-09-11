#!/bin/bash
#uthor:hj
#lastChangeDate:2018-03-26
#version:0.1
#describe：实现110服务器上的接口项目和定时器自动打包更新

#项目更新util和ProclamationService
update_path='/packs/update/'
updatenum=`ls ${update_path} | wc -l`
if [ ${updatenum} -gt 0 ];then
/bin/bash /home/bin/shutdownalltomcat.sh
ls ${update_path} | grep ^Util*.class
if [ $? -eq 0 ];then
	cp -f ${update_path}^Util*.class /opt/apache-tomcat-special/webapps/bxkcA001/WEB-INF/classes/com/bidizhaobiao/data/crawl/util/
	cp -f ${update_path}^Util*.class /opt/apache-tomcat-special/webapps/bxkcA002/WEB-INF/classes/com/bidizhaobiao/data/crawl/util/
	cp -f ${update_path}^Util*.class /opt/apache-tomcat-special/webapps/bxkcA011/WEB-INF/classes/com/bidizhaobiao/data/crawl/util/
	cp -f ${update_path}^Util*.class /opt/apache-tomcat-special/webapps/bxkcA012/WEB-INF/classes/com/bidizhaobiao/data/crawl/util/
	cp -f ${update_path}^Util*.class /opt/apache-tomcat-province/webapps/bxkcB001/WEB-INF/classes/com/bidizhaobiao/data/crawl/util/
	cp -f ${update_path}^Util*.class /opt/apache-tomcat-province/webapps/bxkcB002/WEB-INF/classes/com/bidizhaobiao/data/crawl/util/
	cp -f ${update_path}^Util*.class /opt/apache-tomcat-province/webapps/bxkcC001/WEB-INF/classes/com/bidizhaobiao/data/crawl/util/
	cp -f ${update_path}^Util*.class /opt/apache-tomcat-province/webapps/bxkcD001/WEB-INF/classes/com/bidizhaobiao/data/crawl/util/
	cp -f ${update_path}^Util*.class /opt/apache-tomcat-province/webapps/bxkcE001/WEB-INF/classes/com/bidizhaobiao/data/crawl/util/
	cp -f ${update_path}^Util*.class /opt/apache-tomcat-city/webapps/bxkcDS001/WEB-INF/classes/com/bidizhaobiao/data/crawl/util/
	cp -f ${update_path}^Util*.class /opt/apache-tomcat-city/webapps/bxkcDS002/WEB-INF/classes/com/bidizhaobiao/data/crawl/util/
	cp -f ${update_path}^Util*.class /opt/apache-tomcat-city/webapps/bxkcDS003/WEB-INF/classes/com/bidizhaobiao/data/crawl/util/
	cp -f ${update_path}^Util*.class /opt/apache-tomcat-city/webapps/bxkcDS004/WEB-INF/classes/com/bidizhaobiao/data/crawl/util/
fi
ls ${update_path} | grep ^ProclamationService*.class
if [ $? -eq 0 ];then
	cp -f ${update_path}^ProclamationService*.class /opt/apache-tomcat-special/webapps/bxkcA001/WEB-INF/classes/com/bidizhaobiao/data/crawl/service/
	cp -f ${update_path}^ProclamationService*.class /opt/apache-tomcat-special/webapps/bxkcA002/WEB-INF/classes/com/bidizhaobiao/data/crawl/service/
	cp -f ${update_path}^ProclamationService*.class /opt/apache-tomcat-special/webapps/bxkcA011/WEB-INF/classes/com/bidizhaobiao/data/crawl/service/
	cp -f ${update_path}^ProclamationService*.class /opt/apache-tomcat-special/webapps/bxkcA012/WEB-INF/classes/com/bidizhaobiao/data/crawl/service/
	cp -f ${update_path}^ProclamationService*.class /opt/apache-tomcat-province/webapps/bxkcB001/WEB-INF/classes/com/bidizhaobiao/data/crawl/service/
	cp -f ${update_path}^ProclamationService*.class /opt/apache-tomcat-province/webapps/bxkcB002/WEB-INF/classes/com/bidizhaobiao/data/crawl/service/
	cp -f ${update_path}^ProclamationService*.class /opt/apache-tomcat-province/webapps/bxkcC001/WEB-INF/classes/com/bidizhaobiao/data/crawl/service/
	cp -f ${update_path}^ProclamationService*.class /opt/apache-tomcat-province/webapps/bxkcD001/WEB-INF/classes/com/bidizhaobiao/data/crawl/service/
	cp -f ${update_path}^ProclamationService*.class /opt/apache-tomcat-province/webapps/bxkcE001/WEB-INF/classes/com/bidizhaobiao/data/crawl/service/
	cp -f ${update_path}^ProclamationService*.class /opt/apache-tomcat-city/webapps/bxkcDS001/WEB-INF/classes/com/bidizhaobiao/data/crawl/service/
	cp -f ${update_path}^ProclamationService*.class /opt/apache-tomcat-city/webapps/bxkcDS002/WEB-INF/classes/com/bidizhaobiao/data/crawl/service/
	cp -f ${update_path}^ProclamationService*.class /opt/apache-tomcat-city/webapps/bxkcDS003/WEB-INF/classes/com/bidizhaobiao/data/crawl/service/
	cp -f ${update_path}^ProclamationService*.class /opt/apache-tomcat-city/webapps/bxkcDS004/WEB-INF/classes/com/bidizhaobiao/data/crawl/service/
fi
/bin/bash /home/bin/startalltomcat.sh
rm -rf /packs/update/*
fi

#special定时器打包更新
warPacksPath='/packs/opt/'
cd ${warPacksPath}
bxkcA_num=`ls | grep 'A0' | wc -l`
	if [ ${bxkcA_num} -gt 0 ];then
	kill -9 $(ps -ef | grep -v 'grep' | grep -v 'tail' | grep 'special' | awk '{print $2}')
	bxkcA_name=`ls | grep 'A0'`
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
#province定时器打包更新
bxkcOth_num=`ls | grep -v 'DS0' | grep -v 'A0' | wc -l`
	if [ ${bxkcOth_num} -gt 0 ];then
	kill -9 $(ps -ef | grep -v 'grep' | grep -v 'tail' | grep 'province' | awk '{print $2}')
	bxkcOth_name=`ls | grep -v 'DS0' | grep -v 'A0'`
		for Oth_name in ${bxkcOth_name}
			do
				Othtmp=${Oth_name%.*}
				rm -rf /opt/apache-tomcat-province/webapps/${Othtmp}*
				mv -f ${warPacksPath}${Oth_name} /opt/apache-tomcat-province/webapps/
			done
	/opt/apache-tomcat-province/bin/startup.sh
	fi
	
#接口打包更新
iwaPacksPath='/packs/projects/'
cd ${iwaPacksPath}
if [ -f bxkcA1.iwa ];then
        echo bxkcA1
        /projects/bxkcA1/internetware-phone-reactor/run-reactor-jsvc.sh stop
        sleep 2s
        mv -f /projects/bxkcA1/bxkcA1/bxkcA1.iwa /projects/bxkcA1/bxkcA1/bxkcA1.iwa.bak
        mv -f /packs/projects/bxkcA1.iwa /projects/bxkcA1/bxkcA1/bxkcA1.iwa
        /projects/bxkcA1/internetware-phone-reactor/run-reactor-jsvc.sh start
fi

iwasNum=`ls | wc -l`
iwaName=`ls`
if [ ${iwasNum} -gt 0 ];then
	for iwaPath in ${iwaName}
		do
			projectsName=${iwaPath%.*}
                        echo bxkc${projectsName}
			/projects/bxkc${projectsName}/internetware-phone-reactor/run-reactor-jsvc.sh stop
			sleep 2s
			mv -f /projects/bxkc${projectsName}/bxkc${projectsName}/${iwaPath} /projects/bxkc${projectsName}/bxkc${projectsName}/${iwaPath}.bak
			mv -f ${iwaPacksPath}${iwaPath} /projects/bxkc${projectsName}/bxkc${projectsName}/
			/projects/bxkc${projectsName}/internetware-phone-reactor/run-reactor-jsvc.sh start
		done
fi