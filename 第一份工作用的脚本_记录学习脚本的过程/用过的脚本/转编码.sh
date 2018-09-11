#!/bin/bash
impl='/src/com/bidizhaobiao/data/crawl/service/impl/'
dsqpath='/mnt/d/Workspace/Myeclipse/'
#find ${dsqpath}*${impl} -type f -name  *Service.java* | grep '程序员'
#cat ${dsqpath}bxkcDS015${impl}DS_03636_1_ZhaobGgService.java
#cat ${dsqpath}bxkcDS015${impl}DS_00607_1_ZhongbXxService.java
#iconv -f GB2312 -t UTF-8 -o DS_03636_1_ZhaobGgService.java DS_03636_1_ZhaobGgService.java
find ${dsqpath}*${impl} -type f -name  *Service.java* | xargs -n 1 -I {} iconv -f GB2312 -t UTF-8 -o {} {}