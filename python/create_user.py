#!/usr/bin/env python
# -*- coding: utf-8 -*-

#########################################################################
# File Name: create_user.py
# file_path: 
# Author: 浪子尘心
# Mail: hj536418286@gmail.com
# Created Time: 2018-12-14 09:35:16
# Last Modified: 2018-12-14 10:03:18
# Description: create a user and set the user's password
# Version: 0.1
#########################################################################

import os
user = 'python'
password = '123456!Ab'
os.system("useradd %s" %user)
os.system("echo %s | passwd --stdin %s" %(password, user))
