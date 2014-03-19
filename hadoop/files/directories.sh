#!/bin/sh

# Space separated list of directories where NameNode will store file system image.
DFS_NAME_DIR="/hdfs/nn"

# Space separated list of directories where DataNodes will store the blocks.
DFS_DATA_DIR="/hdfs/dn"

# Space separated list of directories where SecondaryNameNode will store checkpoint image.
FS_CHECKPOINT_DIR="/hdfs/snn"

# Directory to store the Hadoop configuration files.
HADOOP_CONF_DIR="/etc/hadoop/conf"

# Directory to store the HDFS logs.
HDFS_LOG_DIR="/var/log/hadoop/hdfs"

# Directory to store the HDFS process ID.
HDFS_PID_DIR="/var/run/hadoop/hdfs"

#
# Hadoop Service - MapReduce
#

# Space separated list of directories where MapReduce will store temporary data.
MAPREDUCE_LOCAL_DIR="/hdfs/mapred"

# Directory to store the MapReduce logs.
MAPRED_LOG_DIR="/var/log/hadoop/mapred"

# Directory to store the MapReduce process ID.
MAPRED_PID_DIR="/var/run/hadoop/mapred"

#
# Hadoop Service - Hive
#

# Directory to store the Hive configuration files.
HIVE_CONF_DIR="/etc/hive/conf"

# Directory to store the Hive logs.
HIVE_LOG_DIR="/var/log/hive"

# Directory to store the Hive process ID.
HIVE_PID_DIR="/var/run/hive"

#
# Hadoop Service - Templeton
#

# Directory to store the Templeton configuration files.
WEBHCAT_CONF_DIR="/usr/lib/hcatalog/conf"

# Directory to store the Templeton logs.
WEBHCAT_LOG_DIR="/var/log/webhcat"

# Directory to store the Templeton process ID.
WEBHCAT_PID_DIR="/var/run/webhcat"

#
# Hadoop Service - HBase
#

# Directory to store the HBase configuration files.
HBASE_CONF_DIR="/etc/hbase/conf"

# Directory to store the HBase logs.
HBASE_LOG_DIR="/var/log/hbase"

# Directory to store the HBase process ID.
HBASE_PID_DIR="/var/run/hbase"

#
# Hadoop Service - ZooKeeper
#

# Directory where ZooKeeper will store data.
ZOOKEEPER_DATA_DIR="/hdfs/zookeeper/data"

# Directory to store the ZooKeeper configuration files.
ZOOKEEPER_CONF_DIR="/etc/zookeeper/conf"

# Directory to store the ZooKeeper logs.
ZOOKEEPER_LOG_DIR="/var/log/zookeeper"

# Directory to store the ZooKeeper process ID.
ZOOKEEPER_PID_DIR="/var/run/zookeeper"

#
# Pig
#

# Directory to store the Pig configuration files.
PIG_CONF_DIR="/etc/pig/conf"


#
# Hadoop Service - Oozie
#

# Directory to store the Oozie configuration files.
OOZIE_CONF_DIR="/etc/oozie/conf"

# Directory to store the Oozie data.
OOZIE_DATA="/var/db/oozie"

# Directory to store the Oozie logs.
OOZIE_LOG_DIR="/var/log/oozie"

# Directory to store the Oozie process ID.
OOZIE_PID_DIR="/var/run/oozie"

# Directory to store the Oozie temporary files.
OOZIE_TMP_DIR="/var/tmp/oozie"

#
# Hadoop Service - Sqoop
#
SQOOP_CONF_DIR="/etc/sqoop/conf"

JAVA_HOME=/usr/java/default
PATH=$JAVA_HOME/bin:$PATH
