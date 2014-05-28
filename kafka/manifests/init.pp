class kafka (

  $broker_id         = undef,
  $datastore         = '/var/kafka',
  $package_dir       = '/var/lib/kafka',
  $package_url       = undef,
  $install_dir       = '/usr/share',
  $log_dir           = '/data/vol1/app/logs/kafka',
  $log_dir_link      = '/var/log/kafka',
  $zookeeper_connect = 'localhost:2181',
  $user              = 'kafka',
  $group             = 'hadoop'

) {

  anchor { 'kafka::begin': } ->
  class { '::kafka::package': } ->
  class { '::kafka::install': } ->
  class { '::kafka::config': } ->
  class { '::kafka::service': } ->
  anchor { 'kafka::end': }

}
