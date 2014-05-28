class zookeeper inherits zookeeper::params {

  if ! defined(Class["hdp-util"]) {
    class { "hdp-util": }
  }

  class { "zookeeper::package":
    require => Class["hdp-util"]
  } ->

  class { "zookeeper::directories": } ->
  class { "zookeeper::config": } ->
  class { "zookeeper::service": }

}
