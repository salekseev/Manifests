class kafka {

  if ! defined(Class["hdp-util"]) {
    class { "hdp-util": }
  }

  class { "kafka::package":
    require => Class["hdp-util"],
  } ->

  class { "kafka::directories": } ->
  class { "kafka::config": } ->
  class { "kafka::service": }

}
