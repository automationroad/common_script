#!/bin/bash

#****************************格式建议
# 第一，重要步骤多点注释
# 第二，代码空行不需要那么多
# 第三，变量命名最好有实际意义，前缀可以长些
# 第四，一段功能，可以像我上面那样用****************注释起来，这样看起来明显

#****************************逻辑建议
# 第一，执行用户判断，可以写在前面，不是root直接退出
# 第二，整个脚本依赖联网，如果没有网络环境，肯定会失败，可以先看看能不能联网，不能联网直接退出
# 第三，执行功能，定义在function函数里面，直接调用，case不适合写太多逻辑处理，后期维护困难
# 第四，扩展性：可以先检查一下系统上是否安装了对应中间件，如果安装了，可以退出，这样完整性上、通用性上好一些

N_YUM="pcre pcre-devel zlib zlib-devel"

M_YUM="gcc gcc-c++ bison-devel ncurses-devel"

P_YUM="xz xz-devel zlib zlib-devel libxml2 libxml2-devel libjpeg-devel libpng-devel"

echo -e "\033[33m开始运行 $0 脚本\033[0m"

if [[ $UID -eq 0 ]]

	then
					
		yum -y install $N_YUM $M_YUM $P_YUM

		echo -e "\033[35m您本次环境的所有依赖库已经全部安装完成\033[0m"

	else

        	echo "\033[32m请您使用root账户登录 并再次重试 \033[0m"

        	exit 0

fi


echo -e "\033[34m++++++++++++++++++++++++++++++++++++++++++++++++++++++\033[0m"

N="nginx"

M="mysql"

P="php"

read -p "输入 数字 1 我们将为您创建本次环境所需要的所有运行用户: " U

case $U in

        
	1)


        	useradd -M -s /sbin/nologin $N && useradd -M -s /sbin/nologin $M && useradd -M -s /sbin/nologin $P

        	echo -e "\033[33m+++++++++++++++++++++++++++++++++++++++\033[0m"

        	echo -e "\033[32m您本次环境所有的运行用户已经全部创建完成\033[0m"

        	tail -3 /etc/passwd
;;


			
       	*)

        	echo -e "\033[32m您的输入有误 请您检查后并重试 \033[0m"
	
		exit 0			

esac

echo -e "\033[36m++++++++++++++++++++++++++++++++++++++++++++\033[0m"

N_URL="http://mirrors.sohu.com/nginx/nginx-1.12.2.tar.gz"

N_FILE="nginx-1.12.2.tar.gz"

N_DIR="nginx-1.12.2"

N_PREFIX="/usr/local/nginx"

N_P=`pgrep -l nginx | wc -l`

N_S="/usr/local/nginx/sbin/nginx"

N_T="/usr/local/sbin/"

read -p "输入 数字 2 我们将为您安装 Nginx服务: " NGINX

case $NGINX in

	2 )

	if [ ! -e $N_PREFIX ]

		then

			/usr/bin/wget -c $N_URL && /usr/bin/tar zxf $N_FILE

		else

       			echo -e "\033[32m您的目录已经存在 请删除后重试\033[0m"

			exit 0
	fi


	
	if [ $N_P -eq 0 ]
		
		then

			cd $N_DIR && ./configure --prefix=$N_PREFIX --user=$N --group=$N --with-http_stub_status_module

		else
			echo -e "\033[32m您的服务已经启动 或者端口已经被占用 请您杀掉进程后重试\033[0m"
			
			exit 0

	fi



	if [ $? -le 0 ]

		then

			make -j 4 && make install && /usr/bin/ln -s  $N_S $N_T 

			echo -e "\033[35+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++\033[0m"

			nginx -t && nginx && cd ~

		else

			echo -e "\033您的上步配置有误 请检查后重试\033[0"

			exit 0

	fi


	if [ $? -le 0 ]

		then

			echo -e "\033[33m+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++\033[0m"

			echo -e "\033[32m您的Nginx服务安装完成\033[0m"

			echo -e "\033[31m+++++++++++++++++++++\033[0m"
			
			netstat -anpt | grep "nginx" && cd ~


		else

			echo -e "\033[32m您的服务尚未启动 请启动后重试"
			
			exit 0
	fi


;;

	* )

			echo -e "\033[32m您的输入有误 请您重新输入\033[0m"
			
			exit 0

	esac



M_URL="http://mirrors.163.com/mysql/Downloads/MySQL-5.6/mysql-5.6.39.tar.gz"

M_FILE="mysql-5.6.39.tar.gz"

M_DIR="mysql-5.6.39"

M_PREFIX="/usr/local/mysql"

M_C="-DCMAKE_INSTALL_PREFIX=/usr/local/mysql -DSYSCONFDIR=/etc -DDEFAULT_CHARSET=utf8 -DDEFAULT_COLLATION=utf8_general_ci -DWITH_EXTRA_CHARSETS=all"

C_URL="https://cmake.org/files/v2.8/cmake-2.8.6.tar.gz"

C_FILE="cmake-2.8.6.tar.gz"

C_DIR="cmake-2.8.6"

M_P=`pgrep -l mysql | wc -l`

C_P=`pgrep -l cmake | wc -l`

echo -e "\033[36m++++++++++++++++++++++++++++++++++++++++++++\033[0m"

read -p "输入 数字 3 我们将为您安装 MySQL服务: " MYSQL

case $MYSQL in

	3 )

	if [ ! -e $M_PREFIX ]

		then

			/usr/bin/wget -c $C_URL && /usr/bin/tar zxf $C_FILE && cd $C_DIR && ./configure && gmake && gmake install && cd ~

		else

       			echo -e "\033[32m您的目录已经存在 请删除后重试\033[0m"

			exit 0
	fi


	
	if [ $M_P -eq 0 ]
		
		then

			/usr/bin/wget -c $M_URL && /usr/bin/tar zxf $M_FILE && cd $M_DIR && cmake $M_C

		else
			echo -e "\033[32m您的服务已经启动 或者端口已经被占用 请您杀掉进程后重试\033[0m"
			
			exit 0

	fi



	if [ $? -le 0 ]

		then

			make -j 4 && make install && chown -R $M:$M $M_PREFIX


		else

			echo -e "\033您的上步配置有误 请检查后重试\033[0"

			exit 0

	fi


	if [ $? -le 0 ]

		then

			if [ -e /etc/my.cnf ]
		
				then

					/usr/bin/mkdir /var/my.cnf_bak && /usr/bin/mv /etc/my.cnf /var/my.cnf_bak && cp support-files/my-default.cnf /etc/my.cnf


			fi

		else

			echo -e "\033[32m您的服务未安装成功 请检查后重试"
			
			exit 0
	fi


	if [ $? -eq 0 ]

		then
			cd ~ && cd $M_DIR

			/usr/local/mysql/scripts/mysql_install_db --basedir=/usr/local/mysql --datadir=/usr/local/mysql/data/ --user=mysql

		else
		
			echo -e "\033[32m请检查MySQL的主配置文件 my.cnf\033[0m"	

	fi


	if [ $? -le 0 ]


		then

			cp support-files/mysql.server /etc/rc.d/init.d/mysqld && chmod +x /etc/rc.d/init.d/mysqld && chkconfig --add mysqld

			echo "PATH=$PATH:/usr/local/mysql/bin" >> /etc/profile && source /etc/profile && cd ~

		else

			echo -e "\033[32m您的数据库尚未初始化 请初始化后重试"

	fi


	if [ $? -eq 0 ]

		
		then
		
			/usr/bin/systemctl start mysqld && mysqladmin -u root password 'abc-123'

			echo -e "\033[32m您的MySQL服务 安装完成\033[0m"

			netstat -anpt | grep "mysql" && cd ~

			echo -e "\033[34m+++++++++++++++++++++++++++++++++++++++++++++++++++++++++\033[0m"

		else

			echo -e "033[32m您的脚本文件有误 请检查权限\033[0m"

	fi


;;

	* )

			echo -e "\033[32m您的输入有误 请您重新输入\033[0m"
			
			exit 0

	esac



P_URL="http://mirrors.sohu.com/php/php-5.6.38.tar.gz"

Zend_URL="http://downloads.zend.com/guard/7.0.0/zend-loader-php5.5-linux-x86_64_update1.tar.gz"

Zend_FILE="zend-loader-php5.5-linux-x86_64_update1.tar.gz"

Zend_DIR="zend-loader-php5.5-linux-x86_64"

P_FILE="php-5.6.38.tar.gz"

P_DIR="php-5.6.38"

P_PREFIX="/usr/local/php5"

P_C="--with-gd --with-zlib --with-mysql=/usr/local/mysql --with-mysqli=/usr/local/mysql/bin/mysql_config --with-config-file-path=/usr/local/php5 --enable-mbstring --enable-fpm --with-jpeg-dir=/usr/lib"

P_P=`pgrep -l php | wc -l`


read -p "输入 数字 4 我们将为您安装 PHP服务: " PHP

case $PHP in

4 )

if [ $P_P -eq 0 ]

	then

		/usr/bin/wget -c $P_URL && /usr/bin/tar zxf $P_FILE && cd $P_DIR


	else

		echo -e "\033[32m您的服务已经启用 或者端口已经被占用 请您杀掉进程后重试\033[0m"

fi


if [ $? -le 0 ]

	then

		if [ ! -e $P_PREFIX ]

			then

				./configure --prefix=$P_PREFIX $P_C && make -j 4 && make install && cd ~

			else
		
				echo -e "\033[32m您的目录已经存在 请删除后重试\033[0m"
	
				exit 0
			
		fi


	else

			echo -e "\033[32m请检查您的上步配置\033[32m"

			exit 0

	fi


if [ $? -eq 0 ]

	then

		cd $P_DIR && /usr/bin/cp php.ini-development $P_PREFIX/php.ini

		/usr/bin/ln -s /usr/local/php5/bin/* /usr/local/bin/ && /usr/bin/ln -s /usr/local/php5/sbin/* /usr/local/sbin/

		cd ~

		/usr/bin/wget -c $Zend_URL && /usr/bin/tar zxf $Zend_FILE && cd $Zend_DIR && /usr/bin/cp ZendGuardLoader.so $P_PREFIX/lib/php/ && cd ~

                echo zend_extension=/usr/local/php5/lib/php/ZendGuardLoader.so >> $P_PREFIX/php.ini

                echo zend_loader.enable=1 >> $P_PREFIX/php.ini && cd ~

		echo -e "\033[32m您的PHP服务 已经安装完成\033[0m"


	else

		echo -e "\033[32m编译安装PHP失败 请检查您的配置\033[0m"

		exit 0

fi


;;

	* )

		echo -e "\033[32m您的输入有误 请您重新输入\033[0m"

esac


read -p "输入 数字 5 我们将为您配置Nginx支持PHP环境: " NGINX_PHP


case $NGINX_PHP in

5 )

	if [ $? -eq 0 ]

		then

			cd $P_PREFIX/etc && /usr/bin/cp php-fpm.conf.default  php-fpm.conf

			sed -i '25s/;//g' php-fpm.conf

			sed -i '149s/nobody/php/g' php-fpm.conf && sed -i '150s/nobody/php/g' php-fpm.conf

			/usr/local/sbin/php-fpm

			echo -e "\033[32m您的php-fpm服务启动成功\033[0m"

			netstat -anpt | grep "php-fpm"

		else

			echo -e "\033[31m请检查您的配置文件 php-fpm.conf\033[0m"


	fi


	if [ $? -le 0 ]

		then	

			cd $N_PREFIX/conf && sed -i '65s/#//g' nginx.conf  &&  sed -i '66s/#//g' nginx.conf

			sed -i 's/#    fastcgi_pass   127.0.0.1:9000;/fastcgi_pass   127.0.0.1:9000;/g' nginx.conf

			sed -i 's/#    fastcgi_index  index.php;/fastcgi_index  index.php;/g' nginx.conf

			sed -i 's/#    include        fastcgi_params;/include        fastcgi.conf;/g' nginx.conf  &&  sed -i '71s/#//g' nginx.conf 

			echo "<?php" > $N_PREFIX/html/test.php && echo "phpinfo();" >> $N_PREFIX/html/test.php && echo "?>" >> $N_PREFIX/html/test.php	

			/usr/bin/pkill nginx && nginx && 

			echo -e "\033[32m您的服务已经 全部配置完成\033[0m"

		else

			
			echo -e "\033[32m您的 php-fpm服务 尚未启动 请检查后重试\033[32m"

			exit 0

	fi

;;


* )

	echo -e "\033[31m您的输入有误 请您重新输入\033[0m"

esac
