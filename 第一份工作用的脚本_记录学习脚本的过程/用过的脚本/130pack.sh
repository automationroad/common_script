#!/bin/bash
#uthor:hj
#lastChangeDate:2018-03-26
#version:0.1
#describe：实现120服务器上的接口项目和定时器自动打包更新

#项目更新，util和ProclamationService
update_path='/packs/update/'
updatenum=`ls ${update_path} | wc -l`
if [ ${updatenum} -gt 0 ];then
/bin/bash /home/bin/shutdownalltomcat.sh
ls ${update_path} | grep ^Util*.class
if [ $? -eq 0 ];then
	cp -f ${update_path}^Util*.class /opt/apache-tomcat-city1/webapps/bxkcDS009/WEB-INF/classes/com/bidizhaobiao/data/crawl/util/
	cp -f ${update_path}^Util*.class /opt/apache-tomcat-city1/webapps/bxkcDS010/WEB-INF/classes/com/bidizhaobiao/data/crawl/util/
	cp -f ${update_path}^Util*.class /opt/apache-tomcat-city1/webapps/bxkcDS011/WEB-INF/classes/com/bidizhaobiao/data/crawl/util/
	cp -f ${update_path}^Util*.class /opt/apache-tomcat-city1/webapps/bxkcDS012/WEB-INF/classes/com/bidizhaobiao/data/crawl/util/
	cp -f ${update_path}^Util*.class /opt/apache-tomcat-city2/webapps/bxkcDS013/WEB-INF/classes/com/bidizhaobiao/data/crawl/util/
	cp -f ${update_path}^Util*.class /opt/apache-tomcat-city2/webapps/bxkcDS014/WEB-INF/classes/com/bidizhaobiao/data/crawl/util/
	cp -f ${update_path}^Util*.class /opt/apache-tomcat-city2/webapps/bxkcDS015/WEB-INF/classes/com/bidizhaobiao/data/crawl/util/
	cp -f ${update_path}^Util*.class /opt/apache-tomcat-city2/webapps/bxkcDS016/WEB-INF/classes/com/bidizhaobiao/data/crawl/util/
	cp -f ${update_path}^Util*.class /opt/apache-tomcat-city3/webapps/bxkcDS017/WEB-INF/classes/com/bidizhaobiao/data/crawl/util/
	cp -f ${update_path}^Util*.class /opt/apache-tomcat-city3/webapps/bxkcDS018/WEB-INF/classes/com/bidizhaobiao/data/crawl/util/
	cp -f ${update_path}^Util*.class /opt/apache-tomcat-city3/webapps/bxkcDS019/WEB-INF/classes/com/bidizhaobiao/data/crawl/util/
	cp -f ${update_path}^Util*.class /opt/apache-tomcat-city3/webapps/bxkcDS020/WEB-INF/classes/com/bidizhaobiao/data/crawl/util/
	cp -f ${update_path}^Util*.class /opt/apache-tomcat-city3/webapps/bxkcDS021/WEB-INF/classes/com/bidizhaobiao/data/crawl/util/
fi
ls ${update_path} | grep ^ProclamationService*.class
if [ $? -eq 0 ];then
	cp -f ${update_path}^ProclamationService*.class /opt/apache-tomcat-city1/webapps/bxkcDS009/WEB-INF/classes/com/bidizhaobiao/data/crawl/service/
	cp -f ${update_path}^ProclamationService*.class /opt/apache-tomcat-city1/webapps/bxkcDS010/WEB-INF/classes/com/bidizhaobiao/data/crawl/service/
	cp -f ${update_path}^ProclamationService*.class /opt/apache-tomcat-city1/webapps/bxkcDS011/WEB-INF/classes/com/bidizhaobiao/data/crawl/service/
	cp -f ${update_path}^ProclamationService*.class /opt/apache-tomcat-city1/webapps/bxkcDS012/WEB-INF/classes/com/bidizhaobiao/data/crawl/service/
	cp -f ${update_path}^ProclamationService*.class /opt/apache-tomcat-city2/webapps/bxkcDS013/WEB-INF/classes/com/bidizhaobiao/data/crawl/service/
	cp -f ${update_path}^ProclamationService*.class /opt/apache-tomcat-city2/webapps/bxkcDS014/WEB-INF/classes/com/bidizhaobiao/data/crawl/service/
	cp -f ${update_path}^ProclamationService*.class /opt/apache-tomcat-city2/webapps/bxkcDS015/WEB-INF/classes/com/bidizhaobiao/data/crawl/service/
	cp -f ${update_path}^ProclamationService*.class /opt/apache-tomcat-city2/webapps/bxkcDS016/WEB-INF/classes/com/bidizhaobiao/data/crawl/service/
	cp -f ${update_path}^ProclamationService*.class /opt/apache-tomcat-city3/webapps/bxkcDS017/WEB-INF/classes/com/bidizhaobiao/data/crawl/service/
	cp -f ${update_path}^ProclamationService*.class /opt/apache-tomcat-city3/webapps/bxkcDS018/WEB-INF/classes/com/bidizhaobiao/data/crawl/service/
	cp -f ${update_path}^ProclamationService*.class /opt/apache-tomcat-city3/webapps/bxkcDS019/WEB-INF/classes/com/bidizhaobiao/data/crawl/service/
	cp -f ${update_path}^ProclamationService*.class /opt/apache-tomcat-city3/webapps/bxkcDS020/WEB-INF/classes/com/bidizhaobiao/data/crawl/service/
	cp -f ${update_path}^ProclamationService*.class /opt/apache-tomcat-city3/webapps/bxkcDS021/WEB-INF/classes/com/bidizhaobiao/data/crawl/service/
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
#city1定时器打包更新
bxkcDS_num=`ls | egrep 'DS009|DS010|DS011|DS012' | wc -l`
	if [ ${bxkcDS_num} -gt 0 ];then
	kill -9 $(ps -ef | grep -v 'grep' | grep -v 'tail' | grep 'city1' | awk '{print $2}')
	bxkcDS_name=`ls | egrep 'DS009|DS010|DS011|DS012'`
		for DS_name in ${bxkcDS_name}
			do
				DStmp=${DS_name%.*}
				rm -rf /opt/apache-tomcat-city1/webapps/${DStmp}*
				mv -f ${warPacksPath}${DS_name} /opt/apache-tomcat-city1/webapps/
			done
	/opt/apache-tomcat-city1/bin/startup.sh
	cd ${warPacksPath}
	fi
#city2定时器打包更新
bxkcQX_num=`ls | egrep 'DS01[3-6]' | wc -l`
	if [ ${bxkcQX_num} -gt 0 ];then
	kill -9 $(ps -ef | grep -v 'grep' | grep -v 'tail' | grep 'city2' | awk '{print $2}')
	bxkcQX_name=`ls | egrep 'DS01[3-6]'`
		for QX_name in ${bxkcQX_name}
			do
				QXtmp=${QX_name%.*}
				rm -rf /opt/apache-tomcat-city2/webapps/${QXtmp}*
				mv -f ${warPacksPath}${QX_name} /opt/apache-tomcat-city2/webapps/
			done
	/opt/apache-tomcat-city2/bin/startup.sh
	fi
#city3定时器打包更新
bxkcOth_num=`ls | egrep 'DS017|DS018|DS019|DS020|DS021' | wc -l`
	if [ ${bxkcOth_num} -gt 0 ];then
	kill -9 $(ps -ef | grep -v 'grep' | grep -v 'tail' | grep 'city3' | awk '{print $2}')
	bxkcOth_name=`ls | egrep 'DS017|DS018|DS019|DS020|DS021'`
		for Oth_name in ${bxkcOth_name}
			do
				Othtmp=${Oth_name%.*}
				rm -rf /opt/apache-tomcat-city3/webapps/${Othtmp}*
				mv -f ${warPacksPath}${Oth_name} /opt/apache-tomcat-city3/webapps/
			done
	/opt/apache-tomcat-city3/bin/startup.sh
	fi