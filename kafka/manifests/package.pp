class kafka::package inherits kafka::params {

  package { "kafka":
    ensure => $kafka_version,
  }

}
