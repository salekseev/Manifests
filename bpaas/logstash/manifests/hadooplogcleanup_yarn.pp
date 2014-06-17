class logstash::hadooplogcleanup_yarn  inherits logstash::params {

file { "/usr/local/share/hadooplogcleanup_yarn.sh":
    ensure  => present,
    owner   => root,
    group   => root,
    mode    => "0644",
    content => template("logstash/hadooplogcleanup_yarn.sh.erb"),
  }

cron { "logcleanyarn":
  ensure  => present,
  command => "/usr/local/share/hadooplogcleanup_yarn.sh > /dev/null 2>&1",
  user    => 'root',
  minute  => '0',
  hour    => '0',
  date    => '*',
  month   => '*',
  weekday => '*',
  require => File["/usr/local/share/hadooplogcleanup_yarn.sh"],    
}

}
