class logstash::hadooplogcleanup_ambariserver  inherits logstash::params {

file { "/usr/local/share/hadooplogcleanup_ambariserver.sh":
    ensure  => present,
    owner   => root,
    group   => root,
    mode    => "0644",
    content => template("logstash/hadooplogcleanup_ambariserver.sh.erb"),
  }

cron { "logcleanambariserver":
  ensure  => present,
  command => "/usr/local/share/hadooplogcleanup_ambariserver.sh > /dev/null 2>&1",
  user    => 'root',
  minute  => '0',
  hour    => '0',
  date    => '*',
  month   => '*',
  weekday => '*',
  require => File["/usr/local/share/hadooplogcleanup_ambariserver.sh"],    
}

}
