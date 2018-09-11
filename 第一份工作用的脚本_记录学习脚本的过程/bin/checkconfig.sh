#!/bin/bash
dsqpath='/mnt/d/Workspace/Myeclipse/'
impl='/src/com/bidizhaobiao/data/crawl/service/impl/'
configpath='/mnt/d/bin/config.txt'
#开始循环读取
proname=`cat config.txt`
for pro in ${proname}
do
	#ls ${dsqpath}${pro}${impl} | sed 's/\.java//g' | grep -v 'DataExtract' | sort >> ./temp/allpro.xml
	#cat ${dsqpath}${pro}/config/services.xml | sed  's/Service/Service /g' | sed 's/>/> /g' | awk '{print $3}' | grep 'Service' | sort >> ./temp/allproservice.xml
	#grep '00467' ./temp/bxkc*service.xml
	#ag '<!.*>' /mnt/d/Workspace/Myeclipse/bxkcDS001/config/services.xml
	#grep ${pro} /mnt/d/Workspace/Myeclipse/bxkc*/config/services.xml;echo $? ${pro}
	#num=`grep "${pro}" /mnt/d/Workspace/Myeclipse/bxkc*/config/services.xml | sed 's/bxkc/ bxkc/g' | sed 's/\/config/ config/g' | awk '{print $2}'`
	#echo ${pro} ${num} >> temp.xml
	num=`grep -c -o "enable" ${dsqpath}${pro}/config/services.xml`
	
done
