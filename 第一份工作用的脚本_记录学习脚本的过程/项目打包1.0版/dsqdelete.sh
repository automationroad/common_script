#!/bin/bash
#指定定时器项目路径
myeclipse='/mnt/d/Workspace/Myeclipse/'
impl='/src/com/bidizhaobiao/data/crawl/service/impl/'
#获取需要删除编号名称
dsqname=`cat /mnt/d/Workspace/定时器备注.xml | grep -v '编号' | awk '{print $1}'`
if test -n "${dsqname}"
then
	for dsqnum in ${dsqname}
	do
		echo ${dsqnum}
		#匹配编号的定时器项目名称
		dsqname=`cat /mnt/d/Workspace/定时器备注.xml | grep  ${dsqnum} | awk '{print $2}'`
		echo ${dsqname} >> /mnt/c/Users/User/Desktop/dsqtemp.txt
		find ${myeclipse}${dsqname}${impl} -type f -name *${dsqnum}*.java | xargs rm -rf
		sed -i "/.*${dsqnum}.*/"d ${myeclipse}${dsqname}/config/services.xml
	done
fi
#去重项目名
sort -d /mnt/c/Users/User/Desktop/dsqtemp.txt | uniq >> /mnt/c/Users/User/Desktop/定时器修改.txt | uniq
rm -rf /mnt/c/Users/User/Desktop/dsqtemp.txt