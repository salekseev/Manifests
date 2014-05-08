#!/bin/bash
while [ 1 ]
do
    hosts=`curl -i -H 'X-Requested-By: ambari' -u admin:admin localhost:8080/api/v1/hosts| grep host_name | wc -l`
    if [ $hosts -eq 3 ]
    then
        exit
    else
        sleep 5
    fi
done
