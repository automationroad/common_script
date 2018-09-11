#!/bin/bash
# This shell script will create amount of linux login accounts for you.
# 1. check the "accountadd.txt" file exist? you must create that file manually.
#    one account name one line in the "accountadd.txt" file.
# 2. use openssl to create users password.
# 3. User must change his password in his first login.
# 4. more options check the following url:
# http://linux.vbird.org/linux_basic/0410accountmanager.php#manual_amount
# 2015/07/22    VBird
export PATH=/bin:/sbin:/usr/bin:/usr/sbin

# 0. userinput
usergroup=""                   # if your account need secondary group, add here.
pwmech="openssl"               # "openssl" or "account" is needed.
homeperm="no"                  # if "yes" then I will modify home dir permission to 711

# 1. check the accountadd.txt file
action="${1}"                  # "create" is useradd and "delete" is userdel.
if [ ! -f accountadd.txt ]; then
	echo "There is no accountadd.txt file, stop here."
        exit 1
fi

[ "${usergroup}" != "" ] && groupadd -r ${usergroup}
rm -f outputpw.txt
usernames=$(cat accountadd.txt)

for username in ${usernames}
do
    case ${action} in
        "create")
            [ "${usergroup}" != "" ] && usegrp=" -G ${usergroup} " || usegrp=""
            useradd ${usegrp} ${username}               # 新增帳號
            [ "${pwmech}" == "openssl" ] && usepw=$(openssl rand -base64 6) || usepw=${username}
            echo ${usepw} | passwd --stdin ${username}  # 建立密碼
            chage -d 0 ${username}                      # 強制登入修改密碼
            [ "${homeperm}" == "yes" ] && chmod 711 /home/${username}
	    echo "username=${username}, password=${usepw}" >> outputpw.txt
            ;;
        "delete")
            echo "deleting ${username}"
            userdel -r ${username}
            ;;
        *)
            echo "Usage: $0 [create|delete]"
            ;;
    esac
done
