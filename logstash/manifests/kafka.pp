class logstash::kafka inherits logstash::params {

  file { "${logstash_install_dir}/kafka.conf":
    ensure  => present,
    owner   => $logstash_user,
    group   => $logstash_group,
    mode    => $logstash_conf_perms,
    content => template("logstash/logstash-kafka.conf.erb"),
  }

  file { "/etc/init/logstash-kafka.conf":
    ensure  => present,
    owner   => $logstash_user,
    group   => $logstash_group,
    mode    => "0644",
    content => template("logstash/logstash-kafka.upstart.erb"),
    require => File["${logstash_install_dir}/kafka.conf"],
  }

  service { "logstash-kafka":
    ensure     => running,
    enable     => true,
    hasrestart => true,
    hasstatus  => true,
    provider   => upstart,
    require    => File["/etc/init/logstash-kafka.conf"],
    subscribe  => [File["/etc/init/logstash-kafka.conf"],File["${logstash_install_dir}/kafka.conf"]],
  }

}
