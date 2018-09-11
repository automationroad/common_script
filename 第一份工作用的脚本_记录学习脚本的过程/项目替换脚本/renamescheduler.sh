#!/bin/bash
outpath='/mnt/d/Workspace/Myeclipse/'
scheduler='/src/com/bidizhaobiao/data/crawl/scheduler/'
num=`ls ${outpath} | grep -v 'metadata' | grep -v 'history'`
for pro in ${num}
do
	find ${outpath}${pro}${scheduler} -type f -name CrawlerTask.java | xargs sed -i "s/CrawlerTask start/${pro} start/g"
	find ${outpath}${pro}${scheduler} -type f -name CrawlerTask.java | xargs sed -i "s/CrawlerTask end/${pro} end/g"
	find ${outpath}${pro}${scheduler} -type f -name CrawlerTask.java | xargs sed -i "s/bxkc_data_storage/${pro}/g"	
done
