#!/bin/bash
while [ 1 ]
do
    tasks=`curl -s -u admin:admin -H 'X-Requested-By: ambari' 'http://<%= scope.lookupvar('ambariinstallcluster::AMBARISERVER_HOSTNAME') %>:8080/api/v1/clusters/hadoopcluster/requests/1?fields=tasks/Tasks/*'|python /tmp/check_status.py`
    if [[ $? -eq 0 ]]
    then
        exit
    elif [[ $? -eq <%= scope.lookupvar('ambariinstallcluster::COUNRT_HOSTNAME') %> ]]
    then
        exit 1;
    else
        sleep 15
    fi
done
