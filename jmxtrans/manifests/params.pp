class jmxtrans::params (

  $puppet_files_dir     = hiera('puppet_files_dir', '/etc/puppet/files'),
  $jmxtrans_rpm_name    = hiera('jmxtrans_rpm_name', 'jmxtrans-20121016.noarch.rpm'),
  $jmxtrans_home        = hiera('jmxtrans_home', '/usr/share/jmxtrans'),
  $kafka_jmx_trans_port = hiera('kafka_jmx_trans_port', '9093'),
  $ganglia_server_host  = hiera('ganglia_server_host'),
  $ganglia_server_port  = hiera('ganglia_server_port', '8663'),

) { }
