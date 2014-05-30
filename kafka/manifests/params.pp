class kafka::params (

  $kafka_broker_id         = undef,
  $kafka_version           = "2.8.0_0.8.0-1",
  $kafka_heap_size         = "4G",

  $kafka_datastore         = '/var/kafka',

  $kafka_install_dir       = '/usr/share',
  $kafka_install_dir_perms = "0640",

  $kafka_bin_dir_perms     = "0750",

  $kafka_log_dir           = '/data/vol1/app/logs/kafka',
  $kafka_log_dir_link      = '/var/log/kafka',
  $kafka_log_dir_perms     = "0750",

  $kafka_conf_perms        = "0640",

  $kafka_user              = 'kafka',
  $kafka_group             = 'hadoop',

  $kafka_zookeeper_connect = 'localhost:2181',

  $kafka_data_dirs = ["/data/vol3/kafka",
                      "/data/vol4/kafka",
                      "/data/vol5/kafka",
                      "/data/vol6/kafka",
                      "/data/vol7/kafka",
                      "/data/vol8/kafka",
                      "/data/vol9/kafka",
                      "/data/vol10/kafka",
                      "/data/vol11/kafka",
                      "/data/vol12/kafka"]
) { }
