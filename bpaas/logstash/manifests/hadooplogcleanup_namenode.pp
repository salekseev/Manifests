class logstash::hadooplogcleanup_namenode  inherits logstash::params {

file { "/usr/local/share/hadooplogcleanup_namenode.sh":
    ensure  => present,
    owner   => root,
    group   => root,
    mode    => "0644",
    content => template("logstash/hadooplogcleanup_namenode.sh.erb"),
  }

cron { "logcleannamenode":
  ensure  => present,
  command => "/usr/local/share/hadooplogcleanup_namenode.sh > /dev/null 2>&1",
  user    => 'root',
  minute  => '0',
  hour    => '0',
  date    => '*',
  month   => '*',
  weekday => '*',
  require => File["/usr/local/share/hadooplogcleanup_namenode.sh"],    
}

}
