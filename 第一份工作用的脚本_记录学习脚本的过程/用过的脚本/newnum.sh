#!/bin/bash
#部署历史数据
jkpath='/mnt/d/Workspace/eclipse/'
dsqpath='/mnt/d/Workspace/Myeclipse/'
impl='/src/com/bidizhaobiao/data/crawl/service/impl/'
updatepath='/mnt/c/Users/User/Desktop/打包更新/更新文件/已更新/'

#cd ${updatepath}12月/
#find ./*/*/新增/ -type f -name *Service.java | xargs -I {} cp {} ../12new/impl

name=`ls ${updatepath}12new/impl/`
#cd ${dsqpath}
#for project in ${name}
#do
#	find ./*/${impl} -type f -name ${project} | xargs -I {} cp {} ${updatepath}12new/implid/
#done

#cd ${updatepath}12new/
#ls ./implid/ | xargs -n 1 -I {} echo '<service enable="true">'{}'</service>' >> ./services.xml
#sed -i 's/.java//g' ./services.xml