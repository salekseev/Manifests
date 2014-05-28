class zookeeper::package inherits zookeeper::params {

  package { "zookeeper":
    ensure  => $zookeeper_version,
  }

}
