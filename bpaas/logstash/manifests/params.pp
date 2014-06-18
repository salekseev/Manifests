class logstash::params (

  $logstash_version       = "1.3.3",
  $logstash_jq_version    = "1.3-1.el6",
  $logstash_indexer       = "10.119.135.53",
  $logstash_indexer_port  = "6300",
  $logstash_log_dir       = "/var/log/logstash",
  $logstash_log_dir_perms = "0755",
  $logstash_conf_perms    = "0644",
  $logstash_user          = "root",
  $logstash_group         = "root",
  $logstash_api_key		= "5afa20f9-09c8-4066-9b67-bfcd9aec1f0b",
  $logstash_tenant_id	= "17bbe11a3bbc495ca61034f72fda1453",
  $logstash_heap			= "256m",
  $lmm_broker_list 	= "10.50.130.47:9092, 10.50.130.48:9092, 10.50.130.49:9092",
 
  ### Configuration parameters that are used but not configured. Do not change unless they are needed because the rpm changes
  $logstash_install_dir = "/opt/logstash",

  ### default log directory
  $log_dir	= "/var/log",
  
  ### default hadoop log directory
  $hadoop_log_dir	= "/appdata/log",
  
  ### bdse log Configuration
  $logstash_bdse	              = false,
  $bdse_log_dir	      = "/var/log/bdcp",

  ### uWSGI log Configuration
  $logstash_uwsgi	              = false,
  $uwsgi_log_dir	      = "/var/log",

  ### nginx log Configuration
  $logstash_nginx	              = false,
  $nginx_log_dir	      = "/var/log/nginx",

  ### NN hdfs log Configuration
  $logstash_hdfs_namenode	         	= false,
  $hdfs_namenode_log_dir      	= "/appdata/log/hadoop/hdfs",
  
  ### DN hdfs log Configuration
  $logstash_hdfs_datanode	         	= false,
  $hdfs_datanode_log_dir      	= "/appdata/log/hadoop/hdfs",
  
  ### YARN resource manager log Configuration
  $logstash_yarn_resourcemanager	         	= false,
  $yarn_resourcemanager_log_dir      			= "/appdata/log/hadoop-yarn/yarn",  

  ### YARN node manager log Configuration
  $logstash_yarn_nodemanager	         	= false,
  $yarn_nodemanager_log_dir      			= "/appdata/log/hadoop-yarn/yarn",
  
  ### history server log Configuration
  $logstash_yarn_historyserver	         	= false,
  $yarn_historyserver_log_dir      			= "/appdata/log/hadoop-yarn/yarn",
 
  ### MR job summary log Configuration
  $logstash_MR	         	= false,
  $MR_log_dir      			= "/appdata/log/hadoop-yarn/yarn",
  
  ### Oozie log Configuration
  $logstash_oozie	         	= false,
  $oozie_log_dir      			= "/appdata/log/oozie",
  
  ### Hive log Configuration
  $logstash_hive	         	= false,
  $hive_log_dir      			= "/appdata/log/hive",  

  ### Hadoop Cleanup Params
  $ambari_agent_log_dir	= "/var/log/ambari-agent/"
  $ambari_server_log_dir = "/var/log/ambari-server/"
  $hive_log_dir = "/var/log/hive/"
  $hcat_log_dir = "/var/log/webhcat/"
  $oozie_log_dir = "/var/log/oozie/"
  $hdfs_log_dir_prefix = "/var/log/hadoop/hdfs"
  $yarn_log_dir_prefix = "/var/log/hadoop-yarn/yarn"
  $mapred_log_dir_prefix = "/var/log/hadoop-mapred/mapred/"
  $zk_log_dir = "/var/log/zookeeper/"
  
    

) { }
