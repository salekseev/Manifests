class kafka::params {

  $datastore    = '/var/kafka'
  $package_dir  = '/var/lib/kafka'
  $package_url  = undef
  $install_dir  = '/usr/local/kafka'
  $log_dir      = '/data/vol1/app/logs/kafka'
  $log_dir_link = '/var/log/kafka'
#  $hostname     = $::ipaddress
  $zookeeper_connect = '10.119.225.12:2181,10.119.225.13:2181,10.119.225.14:2181'
}
