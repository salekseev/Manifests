#!/bin/bash
file="/tmp/ambari-server-puppet.pid"
if [ -f $file ]; then
        echo "ambari server already running"
else 
        echo "starting ambari-server"
        /etc/init.d/ambari-server start
        /bin/touch '/tmp/ambari-server-puppet.pid'
fi
