class logstash::package {

#  include logstash::params

#  package { 'jq':
#    ensure => $logstash_jq_version,
# }

#  package { 'logstash':
#    ensure => $logstash_version,
#  }
#



exec {'Downloadjq':
        command =>'wget http://stedolan.github.io/jq/download/linux64/jq -P /tmp',
        path => ['/usr/bin'],
  }
  
exec {'Movejq':
      command => '/bin/mv /tmp/jq /usr/local/sbin',
      onlyif => "/usr/bin/test -f /tmp/jq",
      require  => EXEC["Downloadjq"],
 }

file {"/usr/local/sbin/jq":
      mode => 755,
      require => Exec["Movejq"],
}

exec {'Downloadjar':
        command =>'wget https://download.elasticsearch.org/logstash/logstash/logstash-1.3.3-flatjar.jar -P /tmp',
        path => ['/usr/bin'],
  }
  
exec {'Movejar':
      command => '/bin/mv /tmp/logstash-1.3.3-flatjar.jar /opt/logstash',
      onlyif => "/usr/bin/test -f /tmp/logstash-1.3.3-flatjar.jar",
      require  => EXEC["Downloadjar"],
      path => ['/usr/bin', '/bin'],
 }

}
