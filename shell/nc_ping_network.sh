#!/bin/bash
# auth: 浪子尘心
# create_time: 2018-09-17
# descript: 批量测试网络端口是否连通
# 目标端口路径
# TCP:192.168.1.2 2049 ,TCP样板
# UDP:192.168.1.2 111,UDP 样板

# 测试的IP和端口存放路径，这个根据实际情况修改，样板在前面的注释中
file_path='/home/socscan/script/162.txt'

function tcp_nc()
{
	cat ${file_path} | grep 'TCP' | awk -F '[:]' '{print $2}' | while read tcp_ip_port
	do
		nc -v -w 5 ${tcp_ip_port} < /dev/null
		if [ $? -eq 0 ];then
			echo "TCP ${tcp_ip_port} ok"
		else
			echo "TCP ${tcp_ip_port} fail" >> /home/socscan/script/fail.txt
		fi
	done
}
tcp_nc

function udp_nc()
{
	cat ${file_path} | grep 'UDP' | awk -F '[:]' '{print $2}'  | while read udp_ip_port
	do
		nc -uv -w 5 ${udp_ip_port} < /dev/null
		if [ $? -eq 0 ];then
			echo "UCP ${udp_ip_port} ok"
		else
			echo "UCP ${udp_ip_port} fail" >> /home/socscan/script/fail.txt
		fi
	done
}
udp_nc
