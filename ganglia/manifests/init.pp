class ganglia {

  if ! defined(Class['hdp-util']) {
    class { 'hdp-util': }
  }
  class { 'ganglia::package':
    require => Class['hdp-util'],
  } ->
  class { 'ganglia::config': } ->
  class { 'ganglia::service': }

}
