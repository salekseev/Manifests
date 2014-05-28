class storm
{

  if ! defined(Class['hdp-util']) {
    class { 'hdp-util': }
  }  

  class { 'storm::package':
    require => Class['hdp-util'],
  } ->
  class { "storm::directories": } ->
  class { "storm::config": } ->
  class { "storm::service": }

}
