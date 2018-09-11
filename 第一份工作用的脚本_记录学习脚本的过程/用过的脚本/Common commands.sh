#查看系统最大进程数
cat /proc/sys/kernel/pid_max
#查看系统当前进程总数
ps -ef | wc -l
ps -A | wc -lh
#查看系统最大线程
cat /proc/sys/kernel/threads-max
#查看系统当前线程总数
pstree -p | wc -l
#查看内存使用情况
df -lh
#查看对应服务器版本当前操作系统发行版信息
cat /etc/issue
cat /etc/redhat-release
#查看系统内核版本以及更为底层的版本信息
cat /proc/version
#统计出一共有多少核
cat /proc/cpuinfo | grep "model name" | wc -l
#查看 CPU 物理个数
grep 'physical id' /proc/cpuinfo | sort -u | wc -l
#查看 CPU 核心数量
grep 'core id' /proc/cpuinfo | sort -u | wc -l
#查看 CPU 线程数
grep 'processor' /proc/cpuinfo | sort -u | wc -l
#查看 CPU  型号
dmidecode -s processor-version
#查看 CPU 的详细信息
cat /proc/cpuinfo

#Windows下编辑的*.sh文件在Linux上不能运行的解决方法
busybox dos2unix *.sh
