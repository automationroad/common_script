#!/bin/bash
#实现每天更新接口项目和定时器项目

#接口和定时器项目存放目录
jkpath='/mnt/d/Workspace/eclipse/'
dsqpath='/mnt/d/Workspace/Myeclipse/'
#接口和定时器项目存放目录-备份
bakjkpath='/mnt/d/Workspace/jktest/'
bakdsqpath='/mnt/d/Workspace/dsqtest/'
impl='/src/com/bidizhaobiao/data/crawl/service/impl/'
#备份接口项目
jknum=`ls ${bakjkpath}`
for proname in ${jknum}
do
	#列出src目录下的文件夹名单
	ls ${jkpath}${proname}/src > /mnt/d/jksrc.txt
	ls ${bakjkpath}${proname}/src > /mnt/d/bakjksrc.txt
	#通过对比，得出备份src下多出的目录名称即为正式环境中删除的，并以删除
	grep -vwf /mnt/d/jksrc.txt /mnt/d/bakjksrc.txt | xargs -n 1 -I {} rm -rf ${bakjkpath}${proname}/src/{}
	#通过比较每个文件夹下的java文件日期差异来更新文件
	#ls ${jkpath}${proname}/src | xargs -n -I {} cp -u ${jkpath}${proname}/src/{}/* ${bakjkpath}${proname}/src/{}/*
	name=`cat /mnt/d/jksrc.txt`
	for pro in ${name}
	do
		cp -uv ${jkpath}${proname}/src/${pro}/* ${bakjkpath}${proname}/src/${pro}/ > /mnt/d/update.txt
	done
	#列出internetware目录下的文件夹名单
	ls ${jkpath}${proname}/internetware > /mnt/d/jkint.txt
	ls ${bakjkpath}${proname}/internetware >  /mnt/d/bakjkint.txt
	grep -vwf /mnt/d/jkint.txt /mnt/d/bakjkint.txt | xargs -n 1 -I {} rm -rf ${bakjkpath}${proname}/internetware/{}
	#ls ${jkpath}${proname}/internetware | xargs -n 1 -I {} cp -u ${jkpath}${proname}/internetware/{} ${bakjkpath}${proname}/internetware/{}
	#通过比较日期差异更新project.xml
	cp -u ${jkpath}${proname}/project.xml ${bakjkpath}${proname}/project.xml
	rm -rf /mnt/d/jksrc.txt /mnt/d/bakjksrc.txt /mnt/d/jkint.txt /mnt/d/bakjkint.txt
done
#备份定时器项目
dsqnum=`ls ${bakdsqpath}`
for dsqproname in ${dsqnum}
do
	#列出impl目录下的文件名单
	ls ${dsqpath}${dsqproname}${impl} > /mnt/d/dsqimpl.txt
	ls ${bakdsqpath}${dsqproname}${impl} > /mnt/d/bakdsqimpl.txt
	grep -vwf /mnt/d/dsqimpl.txt /mnt/d/bakdsqimpl.txt | xargs -n -I {} rm -rf ${bakdsqpath}${dsqproname}${impl}{}
	cp -u ${dsqpath}${dsqproname}${impl}* ${bakdsqpath}${dsqproname}${impl}
	cp -u ${dsqpath}${dsqproname}/config/services.xml ${bakdsqpath}${dsqproname}/config/services.xml
	rm -rf /mnt/d/dsqimpl.txt /mnt/d/bakdsqimpl.txt
done
