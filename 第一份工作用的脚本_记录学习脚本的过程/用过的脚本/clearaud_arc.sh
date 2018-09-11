#!/bin/bash
#uthor:hj
#lastChangeDate:2017-10-10
#version:0.1
#保留一个月的文件
path=/oracle/app/oracle/admin/yanphone/adump
cd ${path}
rm -rf $(ls -t --full-time | grep $(date -d "-30 days" +%Y-%m) | awk '{print $9}')
#保留一个星期的文件
path1=/arch1
cd ${path1}
rm -rf $(ls -t --full-time | grep 'arc' | grep $(date -d "-7 days" +%Y-%m-%d) | awk '{print $9}')