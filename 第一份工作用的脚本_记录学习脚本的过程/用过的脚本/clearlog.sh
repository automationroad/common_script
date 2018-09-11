log_path=/opt/apache-tomcat-special/logs
d=`date +%Y-%m-%d`
d90=`date -d'30 day ago' +%Y-%m-%d`
cd ${log_path} && cp catalina.out $log_path/catalina.out.$d.log
echo > catalina.out
rm -rf $log_path/catalina.out.${d90}.log

#!/bin/bash  
log_path=/opt/apache-tomcat-special/logs
cd `dirname $0`  
d=`date +%Y-%m-%d`  
d30=`date -d'30 day ago' +%Y-%m-%d`  
  
cd ${log_path}  
  
cp catalina.out catalina.out.${d}  
cat /dev/null > catalina.out  
rm -rf catalina.out.${d30} 