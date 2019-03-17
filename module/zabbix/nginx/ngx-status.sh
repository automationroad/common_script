#!/bin/bash

#########################################################################
# File Name: ngx-status.sh
# file_path: 
# Author: 浪子尘心
# Mail: 536418286@qq.com
# Created Time: 2019-03-17 17:41:24
# Last Changed: 2019-03-17 17:41:50
# Description: 
# Version: 
#########################################################################

ST="127.0.0.1"
PORT="80"

# 检测nginx相关参数
case $1 in
    ping)
    result=`/bin/pidof nginx 2>/dev/null| wc -l`
    echo $result
    ;;
    active)
    result=`/usr/bin/curl "http://$HOST:$PORT/ngx_status/" 2>/dev/null| grep 'Active' | awk '{print $NF}'`
    echo $result
    ;;
    reading)
    result=`/usr/bin/curl "http://$HOST:$PORT/ngx_status/" 2>/dev/null| grep 'Reading' | awk '{print $2}'`
    echo $result
    ;;
    writing)
    result=`/usr/bin/curl "http://$HOST:$PORT/ngx_status/" 2>/dev/null| grep 'Writing' | awk '{print $4}'`
    echo $result
    ;;
    waiting)
    result=`/usr/bin/curl "http://$HOST:$PORT/ngx_status/" 2>/dev/null| grep 'Waiting' | awk '{print $6}'`
    echo $result
    ;;
    accepts)
    result=`/usr/bin/curl "http://$HOST:$PORT/ngx_status/" 2>/dev/null| awk NR==3 | awk '{print $1}'`
    echo $result
    ;;
    handled)
    result=`/usr/bin/curl "http://$HOST:$PORT/ngx_status/" 2>/dev/null| awk NR==3 | awk '{print $2}'`
    echo $result
    ;;
    requests)
    result=`/usr/bin/curl "http://$HOST:$PORT/ngx_status/" 2>/dev/null| awk NR==3 | awk '{print $3}'`
    echo $result
    ;;
    dropped)
    result=`/usr/bin/curl "http://$HOST:$PORT/ngx_status/" 2>/dev/null| awk NR==3 | awk '{print $1-$2}'`
    echo $result
    ;;
    *)
     echo "Usage:$0(ping|active|reading|writing|waiting|accepts|handled|requests|dropped)"
    ;;
esac
