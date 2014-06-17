class logstash::hadooplogcleanup_slaves  inherits logstash::params {

file { "/usr/local/share/hadooplogcleanup_slaves.sh":
    ensure  => present,
    owner   => root,
    group   => root,
    mode    => "0644",
    content => template("logstash/hadooplogcleanup_slaves.sh.erb"),
  }

cron { "logcleanslaves":
  ensure  => present,
  command => "/usr/local/share/hadooplogcleanup_slaves.sh > /dev/null 2>&1",
  user    => 'root',
  minute  => '0',
  hour    => '0',
  date    => '*',
  month   => '*',
  weekday => '*',
  require => File["/usr/local/share/hadooplogcleanup_slaves.sh"],    
}

}
