class logstash::package {

#  include logstash::params

#  package { 'jq':
#    ensure => $logstash_jq_version,
# }

#  package { 'logstash':
#    ensure => $logstash_version,
#  }
#

# copy a remote file to /etc/sudoers
file { "/usr/local/sbin/jq":
    mode   => 755,
    source => "puppet:///modules/logstash/jq"
}


# copy a remote file to /opt/logstash
file { "/opt/logstash/logstash/logstash-1.3.3-flatjar.jar":
    mode   => 755,
    source => "puppet:///modules/logstash/logstash/logstash-1.3.3-flatjar.jar"
}

}
