#!/bin/bash
#注释service.xml配置文件
myeclipse='/mnt/d/Workspace/Myeclipse/'
impl='/src/com/bidizhaobiao/data/crawl/service/impl/'
note=`cat /mnt/d/Workspace/需要删除的编号.xml | grep '执行异常' | sed 's/"//g' | awk '{print $1}'`
zuo='<!--'
you='-->'
for project in ${note}
do
	#得到去重后的定时器项目名称
	num=`grep "${project}" ${myeclipse}*/config/services.xml | awk '{print $1}' | sed "s/Myeclipse\//Myeclipse\/ /g" | sed "s/\/config/ \/config/g" | awk '{print $2}' | uniq`
	#得到所在行数
	hang=`grep -n "${project}" ${myeclipse}${num}/config/services.xml | sed 's/:/ :/g' | awk '{print $1}'`
	sed -i ${hang}s/\<ser/${zuo}\<ser/g ${myeclipse}${num}/config/services.xml
	sed -i ${hang}s/ice\>/ice\>${you}/g ${myeclipse}${num}/config/services.xml
	echo ${num} >> /mnt/c/Users/User/Desktop/dsqtemp.txt
done
sort -d /mnt/c/Users/User/Desktop/dsqtemp.txt | uniq > /mnt/c/Users/User/Desktop/定时器修改.txt
rm -rf /mnt/c/Users/User/Desktop/dsqtemp.txt