#!/bin/bash
file="/var/run/hadoop/hdfs/hdfs-format.pid"
if [ -d $file ]; then
	echo "hdfs-formated already"
else 
	echo "runing hdfs format"
	su hdfs nohup /usr/lib/hadoop/bin/hadoop namenode -format
	touch /var/run/hadoop/hdfs/hdfs-format.pid
fi
