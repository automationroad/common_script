#!/bin/bash

#########################################################################
# File Name: tcp_status.sh
# file_path: 
# Author: 浪子尘心
# Mail: 536418286@qq.com
# Created Time: 2019-03-18 14:01:34
# Last Changed: 2019-03-18 17:22:58
# Description: TCP状态采集
# Version: 
#########################################################################

[ $# -ne 1 ] && echo "Usage:CLOSE-WAIT|CLOSED|CLOSING|ESTAB|FIN-WAIT-1|FIN-WAIT-2|LAST-ACK|LISTEN|SYN-RECV SYN-SENT|TIME-WAIT" && exit 1
ss_file=/tmp/ss.txt
tcp_status_fun(){
    [ $1 == "ESTABLISHED" ] && TCP_STAT="ESTAB" || TCP_STAT=$1    #可能大家习惯了看ESTABLISHED，所以我做了个小小的转换。
        ss -ant | awk 'NR>1 {++s[$1]} END {for(k in s) print k,s[k]}' > $ss_file
        TCP_STAT_VALUE=$(grep ${TCP_STAT} $ss_file|awk {'print $NF'})
        if [ -z "$TCP_STAT_VALUE" ];then
           TCP_STAT_VALUE=0
        fi
        echo $TCP_STAT_VALUE
}
tcp_status_fun $1
