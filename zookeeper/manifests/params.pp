class zookeeper::params (

  ### General Parameters
  $zookeeper_version                   = "3.4.5.2.1.1.0-385.el6",
  $zookeeper_log_dir                   = "/data/vol2/app/logs/zookeeper",
  $zookeeper_log_dir_perms             = "0750",
  $zookeeper_log_dir_link              = "/var/log/zookeeper",
  $zookeeper_data_log_dir              = "/data/vol2/zookeeper",

  $zookeeper_config_dir_perms          = "0750",

  ### Host specific parameters
  $zookeeper_id                        = undef,

  ### Zoo.cfg parameters
  $zookeeper_tickTime                  = "2000",
  $zookeeper_initLimit                 = "10",
  $zookeeper_syncLimit                 = "5",
  $zookeeper_autopurge_snapRetainCount = "3",
  $zookeeper_autopurge_purgeInterval   = "6",
  $zookeeper_data_dir                  = "/data/vol1/app/zookeeper/data",
  $zookeeper_data_dir_perms            = "0750",
  $zookeeper_clientPort                = "2181",

  ### Must be an array in the form ["node1.example.com","node2.example.com",....]
  $zookeeper_servers                   = undef,

  ### Provided by RPM, place here for ease of changing if the rpm changes
  ### DO NOT MODIFY UNLESS THE HDP RPM CHANGES
  $zookeeper_install_dir               = "/usr/lib/zookeeper",
  $zookeeper_config_dir                = "/etc/zookeeper/conf.dir",
  $zookeeper_user                      = "zookeeper",
  $zookeeper_group                     = "hadoop",

) {}
