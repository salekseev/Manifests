class hdp::params(
$role = hiera('role',''),
$NAMENODE_HOSTNAME = hiera('NAMENODE_HOSTNAME',''),
$COUNT_HOSTNAME = '3',
$STANDBYNAMENODE_HOSTNAME = hiera('STANDBYNAMENODE_HOSTNAME',''),
$RESOURCEMANAGER_HOSTNAME = hiera('RESOURCEMANAGER_HOSTNAME',''),
$MONITOR_HOSTNAME = hiera('MONITOR_HOSTNAME',''),
$HIVE_HOSTNAME = hiera('HIVE_HOSTNAME',''),
$OOZIE_HOSTNAME = hiera('OOZIE_HOSTNAME',''),
$hdp_slaves = hiera('hdp_slaves'),
$SLAVES1_HOSTNAME = hiera('SLAVES1_HOSTNAME',''),
$SLAVES2_HOSTNAME = hiera('SLAVES2_HOSTNAME',''),
$SLAVES3_HOSTNAME = hiera('SLAVES1_HOSTNAME',''),
$SLAVES4_HOSTNAME = hiera('SLAVES1_HOSTNAME',''),
$SLAVES5_HOSTNAME = hiera('SLAVES1_HOSTNAME',''),
$SLAVES6_HOSTNAME = hiera('SLAVES1_HOSTNAME',''),
$SLAVES7_HOSTNAME = hiera('SLAVES1_HOSTNAME',''),
$SLAVES8_HOSTNAME = hiera('SLAVES1_HOSTNAME',''),
$SLAVES9_HOSTNAME = hiera('SLAVES1_HOSTNAME',''),
$SLAVES10_HOSTNAME = hiera('SLAVES1_HOSTNAME',''),
$SLAVES11_HOSTNAME = hiera('SLAVES1_HOSTNAME',''),
$SLAVES12_HOSTNAME = hiera('SLAVES1_HOSTNAME',''),
$SLAVES13_HOSTNAME = hiera('SLAVES1_HOSTNAME',''),
$SLAVES14_HOSTNAME = hiera('SLAVES1_HOSTNAME',''),
$SLAVES15_HOSTNAME = hiera('SLAVES1_HOSTNAME',''),
$SLAVES16_HOSTNAME = hiera('SLAVES1_HOSTNAME',''),
$SLAVES17_HOSTNAME = hiera('SLAVES1_HOSTNAME',''),
$SLAVES18_HOSTNAME = hiera('SLAVES1_HOSTNAME',''),
$SLAVES19_HOSTNAME = hiera('SLAVES1_HOSTNAME',''),
$SLAVES20_HOSTNAME = hiera('SLAVES1_HOSTNAME',''),
$SLAVES21_HOSTNAME = hiera('SLAVES1_HOSTNAME',''),
$SLAVES22_HOSTNAME = hiera('SLAVES1_HOSTNAME',''),
$SLAVES23_HOSTNAME = hiera('SLAVES1_HOSTNAME',''),
$SLAVES24_HOSTNAME = hiera('SLAVES1_HOSTNAME',''),
$SLAVES25_HOSTNAME = hiera('SLAVES1_HOSTNAME',''),
$SLAVES26_HOSTNAME = hiera('SLAVES1_HOSTNAME',''),
$SLAVES27_HOSTNAME = hiera('SLAVES1_HOSTNAME',''),
$SLAVES28_HOSTNAME = hiera('SLAVES1_HOSTNAME',''),
$BDCP_HOSTNAME = hiera('BDCP_HOSTNAME',''),
$BASTON_HOSTNAME = hiera('BASTON_HOSTNAME',''),
$MYSQLSERVER_HOSTNAME = hiera('MYSQLSERVER_HOSTNAME',''),
$AMBARISERVER_HOSTNAME = hiera('AMBARISERVER_HOSTNAME',''),

$PASSWORD = hiera('PASSWORD','nji9(IJN'),
$BACKUP_DIR = hiera('BACKUP_DIR','/applogs/'),
$AMBARI_PASSWORD = hiera('AMBARI_PASSWORD','bigdata'),

$BLUEPRINT_PATH = hiera('BLUEPRINT_PATH','/etc/ambari-server/conf/ambari-blueprint.conf.singlemaster'),
$CLUSTER_CONF_PATH = hiera('CLUSTER_CONF_PATH','/etc/ambari-server/conf/ambari-clustertemplate.conf.singlemaster'),
$CLUSTER_NAME = hiera('CLUSTER_NAME','hdpambariauto')
) {


}
