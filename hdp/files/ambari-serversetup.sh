#!/bin/bash
file="/tmp/ambari-server-setup.pid"
if [ -f $file ]; then
        echo "ambari server setup already completed"
else 
        echo "setting up ambari-server" 
        /etc/init.d/ambari-server setup -s -j /usr/java/jdk1.7.0_51 
        /bin/touch /tmp/ambari-server-setup.pid 
fi
