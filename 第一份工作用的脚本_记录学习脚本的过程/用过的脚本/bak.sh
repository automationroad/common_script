#!/bin/bash
#uthor:hj
#lastChangeDate:2017-11-30
#version:0.1
date=`date -d "+1 days" +%Y%m%d`
tar -zpcv -f /usr/local/apache-tomcat-7.0.67/webapps/ROOT/bak/${date}_client.tar.gz /usr/local/apache-tomcat-7.0.67/webapps/ROOT/client/
tar -zpcv -f /usr/local/apache-tomcat-7.0.67/webapps/ROOT/bak/${date}_WEB-INF.tar.gz /usr/local/apache-tomcat-7.0.67/webapps/ROOT/WEB-INF/
tar -zpcv -f /usr/local/apache-tomcat-7.0.67/webapps/ROOT/bak/${date}_basedata.tar.gz /usr/local/apache-tomcat-7.0.67/webapps/ROOT/basedata/
previous=`date -d "-7 days" +%Y%m%d`
rm -rf $(ls | grep ${previous})
month=`date -d "-2 months" +%Y%m`
rm -rf $(ls | grep ${month})