#!/bin/bash
#指定定时器项目路径
#myeclipse='/mnt/d/Workspace/Myeclipse/'
impl='/src/com/bidizhaobiao/data/crawl/service/impl/'
#获取需要删除编号名称
cat /mnt/d/Workspace/定时器备注.xml | grep -v '编号' | awk '{print $1}' | sed -i s/^0/_0/g /mnt/d/Workspace/定时器备注.xml
dsqname=`cat /mnt/d/Workspace/定时器备注.xml | grep -v '编号' | awk '{print $1}'`
if test -n "${dsqname}"
then
	for dsqnum in ${dsqname}
	do
		echo ${dsqnum}
		#匹配编号的定时器项目名称
		dsqname=`cat /mnt/d/Workspace/定时器备注.xml | grep  ${dsqnum} | awk '{print $2}'`
		echo ${dsqname} >> /mnt/c/Users/User/Desktop/dsqtemp.txt
		find ${myeclipse}${dsqname}${impl} -type f -regex .*${dsqnum}_.* | xargs rm -rf
		#sed -i "/*\[^0]${dsqnum}_*/"d ${myeclipse}${dsqname}/config/services.xml
		egrep -n .*${dsqnum}_* ${myeclipse}${dsqname}/config/services.xml | sed  's/:/ :/g' | awk '{print $1}' | \
		sort -r | xargs -I {} sed -i {}d ${myeclipse}${dsqname}/config/services.xml
	done
fi
#去重项目名
sort -d /mnt/c/Users/User/Desktop/dsqtemp.txt | uniq >> /mnt/c/Users/User/Desktop/定时器修改.txt | uniq
rm -rf /mnt/c/Users/User/Desktop/dsqtemp.txt