#!/bin/bash
#定义120服务器上各个Tomcat的路径
special='/opt/apache-tomcat-special/logs/'
tail -n 10000 ${special}catalina.out | grep 'Connection reset' | mail -s '110special_reset' 536418286@qq.com
province='/opt/apache-tomcat-province/logs/'
city='/opt/apache-tomcat-city/logs/'
#tail -n 10000 ${province}catalina.out | grep 'Connection reset' | mail -s '110province_reset' 536418286@qq.com
#tail -n 10000 ${city}catalina.out | grep 'Connection reset' | mail -s '110city_reset' 536418286@qq.com
