class logstash::hadooplogcleanup_oozie  inherits logstash::params {

file { "/usr/local/share/hadooplogcleanup_oozie.sh":
    ensure  => present,
    owner   => root,
    group   => root,
    mode    => "0644",
    content => template("logstash/hadooplogcleanup_oozie.sh.erb"),
  }

cron { "logcleanoozie":
  ensure  => present,
  command => "/usr/local/share/hadooplogcleanup_oozie.sh > /dev/null 2>&1",
  user    => 'root',
  minute  => '0',
  hour    => '0',
  date    => '*',
  month   => '*',
  weekday => '*',
  require => File["/usr/local/share/hadooplogcleanup_oozie.sh"],    
}

}
