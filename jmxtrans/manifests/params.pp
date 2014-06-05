class jmxtrans::params (

  $jmxtrans_version     = "20121016.145842.6a28c97fbb-0",
  $jmxtrans_home        = "/usr/share/jmxtrans",
  $jmxtrans_user        = "jmxtrans",
  $jmxtrans_group       = "jmxtrans",

  $jmxtrans_log_dir       = "/var/log/jmxtrans",
  $jmxtrans_log_dir_perms = "0750",

  $jmxtrans_run_dir        = "/var/run/jmxtrans",
  $jmxtrans_run_dir_perms  = "0750",

  $jmxtrans_conf_dir_perms = "0750",
  $jmxtrans_bin_dir_perms  = "0750",

  $jmxtrans_kafka_jmx_trans_port = 9093,
  $jmxtrans_ganglia_server_host  = undef,
  $jmxtrans_ganglia_server_port  = 8663,

) { }
