#!/bin/bash
#内存溢出报警
sum=`free -g | grep -v 'buffers/cache' | grep -v 'total' | awk '{print $3}' | awk '{sum += $1};END {print sum}'`
if [ ${sum} -gt 5 ];then
echo "Memory is about to overflow" | mail -s 'memoryout' 536418286@qq.com
fi
