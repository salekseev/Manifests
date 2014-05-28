class logstash::package {

  include logstash::params

  package { 'jq':
    ensure => $logstash_jq_version,
  }

  package { 'logstash':
    ensure => $logstash_version,
  }

}
