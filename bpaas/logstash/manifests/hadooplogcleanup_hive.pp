class logstash::hadooplogcleanup_hive  inherits logstash::params {

file { "/usr/local/share/hadooplogcleanup_hive.sh":
    ensure  => present,
    owner   => root,
    group   => root,
    mode    => "0644",
    content => template("logstash/hadooplogcleanup_hive.sh.erb"),
  }

cron { "logcleanhive":
  ensure  => present,
  command => "/usr/local/share/hadooplogcleanup_hive.sh > /dev/null 2>&1",
  user    => 'root',
  minute  => '0',
  hour    => '0',
  date    => '*',
  month   => '*',
  weekday => '*',
  require => File["/usr/local/share/hadooplogcleanup_hive.sh"],    
}

}
