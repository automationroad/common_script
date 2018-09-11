#!/bin/bash
#注释service.xml配置文件
myeclipse='/mnt/d/Workspace/Myeclipse/'
impl='/src/com/bidizhaobiao/data/crawl/service/impl/'
cat /mnt/d/Workspace/需要删除的编号.xml | grep '执行异常' | sed 's/"//g' | awk '{print $1}' > /mnt/d/Workspace/note.xml
note=`cat /mnt/d/Workspace/note.xml`
zuo='<!--'
you='-->'
for project in ${note}
do
	temp=`grep "${project}" ${myeclipse}*/config/services.xml`
	#echo ${temp}
	if test -n "${temp}"
	then
	path=`grep "${project}" ${myeclipse}*/config/services.xml | awk '{print $1}' | sed "s/Myeclipse\//Myeclipse\/ /g" | sed "s/\/config/ \/config/g" | awk '{print $2}' | uniq`
	echo ${project} ${path} >> /mnt/d/Workspace/定时器备注.xml
	fi
	#得到去重后的定时器项目名称
	#num=`grep "${project}" ${myeclipse}*/config/services.xml | awk '{print $1}' | sed "s/Myeclipse\//Myeclipse\/ /g" | sed "s/\/config/ \/config/g" | awk '{print $2}' | uniq`
	#得到所在行数
	#hang=`grep -n "${project}" ${myeclipse}${num}/config/services.xml | sed 's/:/ :/g' | awk '{print $1}'`
	#sed -i ${hang}s/\<ser/${zuo}\<ser/g ${myeclipse}${num}/config/services.xml
	#sed -i ${hang}s/ice\>/ice\>${you}/g ${myeclipse}${num}/config/services.xml
	#echo ${num} >> /mnt/c/Users/User/Desktop/dsqtemp.txt
done
dsqname=`cat /mnt/d/Workspace/定时器备注.xml | grep -v '编号' | awk '{print $1}'`
if test -n "${dsqname}"
then
	for dsqnum in ${dsqname}
	do
		echo ${dsqnum}
		#匹配编号的定时器项目名称
		dsqname=`cat /mnt/d/Workspace/定时器备注.xml | grep  ${dsqnum} | awk '{print $2}'`
		echo ${dsqname} >> /mnt/c/Users/User/Desktop/dsqtemp.txt
		#find ${myeclipse}${dsqname}${impl} -type f -regex ${dsqnum} | xargs rm -rf
		#sed -i "/*\[^0]${dsqnum}_*/"d ${myeclipse}${dsqname}/config/services.xml
		egrep -n .*${dsqnum}_* ${myeclipse}${dsqname}/config/services.xml | sed  's/:/ :/g' | awk '{print $1}' | \
		sort -r | xargs -I {} sed -i {}d ${myeclipse}${dsqname}/config/services.xml
	done
fi
sort -d /mnt/c/Users/User/Desktop/dsqtemp.txt | uniq > /mnt/c/Users/User/Desktop/定时器修改.txt
rm -rf /mnt/c/Users/User/Desktop/dsqtemp.txt