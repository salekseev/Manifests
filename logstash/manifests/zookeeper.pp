class logstash::zookeeper inherits logstash::params {

  file { "${logstash_install_dir}/zookeeper.conf":
    ensure  => present,
    owner   => $logstash_user,
    group   => $logstash_group,
    mode    => $logstash_conf_perms,
    content => template("logstash/logstash-zookeeper.conf.erb"),
  }

  file { "/etc/init/logstash-zookeeper.conf":
    ensure  => present,
    owner   => $logstash_user,
    group   => $logstash_group,
    mode    => "0644",
    content => template("logstash/logstash-zookeeper.upstart.erb"),
    require => File["${logstash_install_dir}/zookeeper.conf"],
  }

  service { "logstash-zookeeper":
    ensure     => running,
    enable     => true,
    hasrestart => true,
    hasstatus  => true,
    provider   => upstart,
    require    => File["/etc/init/logstash-zookeeper.conf"],
  }

}
