#!/bin/bash
#uthor:hj
#lastChangeDate:2018-01-26
#version:0.1
#describe：打包更新新增类型的
#清除旧的备注内容
echo '编号	接口项目名' > /mnt/d/Workspace/接口备注.xml
echo '编号	定时器名称' > /mnt/d/Workspace/定时器备注.xml
echo > /mnt/d/temp/checkdsq.log
#打包项目路径
updatepath='/mnt/c/Users/User/Desktop/打包更新/更新文件/未更新/'
#正式环境路径
dsqpath='/mnt/d/Workspace/Myeclipse/'
eclipse='/mnt/d/Workspace/eclipse/'
impl='/src/com/bidizhaobiao/data/crawl/service/impl/'
protime=`date +%Y`
cd ${updatepath}
#解压压缩包
ls | grep ${protime} | grep 'rar' | xargs -n 1 -I {} unrar x -inul {} ${updatepath}
ls | grep ${protime} | grep 'zip' | xargs -n 1 -I {}  unzip -qO CP936 {} -d ${updatepath}
items=`ls | grep ${protime} | grep -v 'rar' | grep -v 'zip' | grep -v 'xls' | grep -v 'txt'`
for path in ${items}
do
	#先判断,将所有的文件夹下面的备注集中到一处
	[ -f ${path}/接口备注.txt ]&&grep -v '编号' ${path}/接口备注.txt >> /mnt/c/Users/User/Desktop/jktemp.txt
	[ -f ${path}/定时器备注.txt ]&&grep -v '编号' ${path}/定时器备注.txt >> /mnt/c/Users/User/Desktop/dsqtemp.txt
	if [ -d ${path}/修改/ ];then
		#入库对比，得到入库项目名
		ls ./${path}/修改/入库/ | grep -q '其' && echo ${path}' 修改入库含有 其他 这个目录' >> /mnt/d/temp/checkdsq.log
		dsqnum=`ls ./${path}/修改/入库/ | grep -v '其'`
		for dsqname in ${dsqnum}
		do
			#编号对比
			pronum=`ls ./${path}/修改/入库/${dsqname}/impl/ | egrep -o .*[0-9]\{4,6\} | uniq`
			for proname in ${pronum}
			do
				ls ${dsqpath}${dsqname}${impl} | grep -q ${proname} 
				if [ $? -ne 0 ] ;then
					echo ${path}' 修改入库 '${dsqname}' 下的 '${proname}' 路径错误' >> /mnt/d/temp/checkdsq.log
				fi
			done
		done
	fi
	if [ -d ${path}/新增/入库/其他/impl/ ];then
		ls ${path}/新增/入库/其他/impl/ | grep -q 'DX' && echo '新增其他入库含有不合法入库DX'
		ls ${path}/新增/入库/其他/impl/ | grep -q 'SJ' && echo '新增其他入库含有不合法入库SJ'
		ls ${path}/新增/入库/其他/impl/ | grep -q 'GJ' && echo '新增其他入库含有不合法入库GJ'
	fi
	[ -d ${path}/新增/入库/[A-E]/impl/ ] && ls ${path}/新增/入库/[A-E]/impl/ | egrep -q 'Y0|YY|XX|QX|DS' && echo '新增省级入库含有 非省级 入库'
	
done
#删除空白行
sed -i '/^\s*$/d' /mnt/c/Users/User/Desktop/jktemp.txt
sed -i '/^\s*$/d' /mnt/c/Users/User/Desktop/dsqtemp.txt
#排序备注
cat /mnt/c/Users/User/Desktop/jktemp.txt | sort -r -n -k1 >> /mnt/d/Workspace/接口备注.xml
cat /mnt/c/Users/User/Desktop/dsqtemp.txt | sort -r -n -k1 >> /mnt/d/Workspace/定时器备注.xml
rm -rf /mnt/c/Users/User/Desktop/jktemp.txt
rm -rf /mnt/c/Users/User/Desktop/dsqtemp.txt
#Windows文件格式转换成Linux格式
busybox dos2unix /mnt/d/Workspace/接口备注.xml
busybox dos2unix /mnt/d/Workspace/定时器备注.xml

cat /mnt/d/temp/checkdsq.log