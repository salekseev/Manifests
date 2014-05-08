#!/bin/bash
file="/tmp/ambari-agentstart.pid"
if [ -f $file ]; then
        echo "ambari agent already started"
else 
        echo "starting ambari-agent"
        /etc/init.d/ambari-agent start
	/bin/touch '/tmp/ambari-agentstart.pid'
fi
