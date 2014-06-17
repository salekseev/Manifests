class logstash::hadooplogcleanup_zkeeper  inherits logstash::params {

file { "/usr/local/share/hadooplogcleanup_zkeeper.sh":
    ensure  => present,
    owner   => root,
    group   => root,
    mode    => "0644",
    content => template("logstash/hadooplogcleanup_zkeeper.sh.erb"),
  }

cron { "logcleanzkeeper":
  ensure  => present,
  command => "/usr/local/share/hadooplogcleanup_zkeeper.sh > /dev/null 2>&1",
  user    => 'root',
  minute  => '0',
  hour    => '0',
  date    => '*',
  month   => '*',
  weekday => '*',
  require => File["/usr/local/share/hadooplogcleanup_zkeeper.sh"],    
}

}
