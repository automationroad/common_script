#�鿴ϵͳ��������
cat /proc/sys/kernel/pid_max
#�鿴ϵͳ��ǰ��������
ps -ef | wc -l
ps -A | wc -lh
#�鿴ϵͳ����߳�
cat /proc/sys/kernel/threads-max
#�鿴ϵͳ��ǰ�߳�����
pstree -p | wc -l
#�鿴�ڴ�ʹ�����
df -lh
#�鿴��Ӧ�������汾��ǰ����ϵͳ���а���Ϣ
cat /etc/issue
cat /etc/redhat-release
#�鿴ϵͳ�ں˰汾�Լ���Ϊ�ײ�İ汾��Ϣ
cat /proc/version
#ͳ�Ƴ�һ���ж��ٺ�
cat /proc/cpuinfo | grep "model name" | wc -l
#�鿴 CPU �������
grep 'physical id' /proc/cpuinfo | sort -u | wc -l
#�鿴 CPU ��������
grep 'core id' /proc/cpuinfo | sort -u | wc -l
#�鿴 CPU �߳���
grep 'processor' /proc/cpuinfo | sort -u | wc -l
#�鿴 CPU  �ͺ�
dmidecode -s processor-version
#�鿴 CPU ����ϸ��Ϣ
cat /proc/cpuinfo

#Windows�±༭��*.sh�ļ���Linux�ϲ������еĽ������
busybox dos2unix *.sh
