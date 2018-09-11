#!/bin/bash
ps -ef | grep tomcat | grep -v 'grep' | grep -v 'tail' | grep province | awk '{print $2}' | xargs kill -9
