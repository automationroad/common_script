import time
import psutil
#获取CPU的完整信息
psutil.cpu_times()
#查看CPU的逻辑个数
psutil.cpu_count
#查看CPU的物理个数
psutil.cpu_count(logical=False)
#查看内存使用
memObj = psutil.virtual_memory();
totalMem=memObj.total;
usedMem=memObj.used;
print("total Memory %d MB"%(totalMem/1024/1024));
print("usedMem Memory %d MB"%(usedMem/1024/1024));
#查看系统开机时间
print (u'电脑开机时间：{}'.format(time.strftime('%y-%m-%d %H:%M:%S', time.localtime(psutil.boot_time()))))
