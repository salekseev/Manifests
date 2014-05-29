class logstash::params (

  $logstash_version       = "1.3.3-1",
  $logstash_jq_version    = "1.3-1.el6",
  $logstash_indexer       = "10.119.135.53",
  $logstash_indexer_port  = "6300",
  $logstash_log_dir       = "/var/log/logstash",
  $logstash_log_dir_perms = "0755",
  $logstash_conf_perms    = "0644",
  $logstash_user          = "root",
  $logstash_group         = "root",
 
  ### Configuration parameters that are used but not configured. Do not change unless they are needed because the rpm changes
  $logstash_install_dir = "/opt/logstash",

  ### Storm Nimbus Configuration
  $logstash_storm_nimbus              = false,
  $logstash_storm_nimbus_log_dir      = "/var/log/storm",
  $logstash_storm_nimbus_apikey       = "2cc27f1d-fbf8-48d8-821d-fe182cd1622e",
  $logstash_storm_nimbus_tenantid     = "7ea8403061b043de92f9bf140afb1fe3",
  $logstash_storm_nimbus_debug_format = "json",
  $logstash_storm_nimbus_heap         = "256m",

  ### Storm UI Configuration
  $logstash_storm_ui              = false,
  $logstash_storm_ui_log_dir      = "/var/log/storm",
  $logstash_storm_ui_apikey       = "2cc27f1d-fbf8-48d8-821d-fe182cd1622e",
  $logstash_storm_ui_tenantid     = "7ea8403061b043de92f9bf140afb1fe3",
  $logstash_storm_ui_debug_format = "json",
  $logstash_storm_ui_heap         = "256m",

  ### Storm Supervisor Configuration
  $logstash_storm_supervisor              = false,
  $logstash_storm_supervisor_log_dir      = "/var/log/storm",
  $logstash_storm_supervisor_apikey       = "2cc27f1d-fbf8-48d8-821d-fe182cd1622e",
  $logstash_storm_supervisor_tenantid     = "7ea8403061b043de92f9bf140afb1fe3",
  $logstash_storm_supervisor_debug_format = "json",
  $logstash_storm_supervisor_heap         = "256m",

  ### Storm Worker Configuration
  $logstash_storm_worker              = false,
  $logstash_storm_worker_log_dir      = "/var/log/storm",
  $logstash_storm_worker_apikey       = "2cc27f1d-fbf8-48d8-821d-fe182cd1622e",
  $logstash_storm_worker_tenantid     = "7ea8403061b043de92f9bf140afb1fe3",
  $logstash_storm_worker_debug_format = "json",
  $logstash_storm_worker_heap         = "256m",

  ### Zookeeper Configuration
  $logstash_zookeeper              = false,
  $logstash_zookeeper_log_dir      = "/var/log/zookeeper",
  $logstash_zookeeper_apikey       = "2cc27f1d-fbf8-48d8-821d-fe182cd1622e",
  $logstash_zookeeper_tenantid     = "7ea8403061b043de92f9bf140afb1fe3",
  $logstash_zookeeper_debug_format = "json",
  $logstash_zookeeper_heap         = "256m",

  ### Kafka Configuration
  $logstash_kafka              = false,
  $logstash_kafka_log_dir      = "/var/log/kafka",
  $logstash_kafka_apikey       = "2cc27f1d-fbf8-48d8-821d-fe182cd1622e",
  $logstash_kafka_tenantid     = "7ea8403061b043de92f9bf140afb1fe3",
  $logstash_kafka_debug_format = "json",
  $logstash_kafka_heap         = "512m",

) { }
