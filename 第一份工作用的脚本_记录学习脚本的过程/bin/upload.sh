#!/bin/bash
path='/mnt/c/Users/User/Desktop/pack/'
#上传本地接口和入库
ls ${path} | egrep bxkcSpecial.iwa | xargs -I {} scp ${path}{} root@192.168.2.65:/packs/localprojects/projects/
ls ${path} | egrep 'bxkcA005|bxkcA014|bxkcB003|bxkcSpecial00[4-5].war' | xargs -I {} scp ${path}{} root@192.168.2.65:/packs/localprojects/opt/

#上传到65的110文件夹
ls ${path} | egrep ^[0-9]\{1,2\}.iwa | xargs -I {} scp ${path}{} root@192.168.2.65:/packs/110/
ls ${path} | egrep bxkcA1.iwa | xargs -I {} scp ${path}{} root@192.168.2.65:/packs/110/
#上传到65的120文件夹
ls ${path} | egrep -v bxkcSpecial.iwa | egrep -v bxkcA1.iwa | egrep -v ^[0-9]\{1,2\}.iwa | grep -v 'war' | xargs -I {} scp ${path}{} root@192.168.2.65:/packs/120/
#更新65上的iwa项目
ssh root@192.168.2.65 /home/bin/pack.sh

#上传到110的iwa
ls ${path} | egrep ^[0-9]\{1,2\}.iwa | xargs -I {} scp -P 11022 ${path}{} appuser@121.46.18.113:/packs/projects/
ls ${path} | egrep bxkcA1.iwa | xargs -I {} scp -P 11022 ${path}{} appuser@121.46.18.113:/packs/projects/
#上传文件到110上pack目录下的war包
ls ${path} | egrep 'bxkc(A00[1-2]|A01[1-2]|B00[1-2]|C001|D001|E001|DS00[1-4]).war' | xargs -I {} scp -P 11022 ${path}{} appuser@121.46.18.113:/packs/opt/
#上传到120的iwa
ls ${path} | egrep -v bxkcSpecial.iwa | egrep -v bxkcA1.iwa | egrep -v ^[0-9]\{1,2\}.iwa | grep -v 'war' | xargs -I {} scp -P 12022 ${path}{} appuser@121.46.18.113:/packs/projects/
#上传文件到120上pack目录下的war包
ls ${path} | egrep 'bxkc(DS00[5-8]|QX00[1-9]|E00[2-5]|03757|03760).war' | xargs -I {} scp -P 12022 ${path}{} appuser@121.46.18.113:/packs/opt/
#上传文件到130上pack目录下的war包
ls ${path} | egrep 'bxkc(DS009|DS01[0-9]|DS02[0-1]|A00[6-9]).war' | xargs -I {} scp -P 13022 ${path}{} appuser@121.46.18.113:/packs/opt/
rm -rf ${path}*