#!/bin/bash
file="/tmp/mysql-puppet.pid"
if [ -f $file ]; then
        echo "mysql server already running"
else 
        echo "starting mysql"
        /bin/touch '/tmp/mysql-puppet.pid'
fi
