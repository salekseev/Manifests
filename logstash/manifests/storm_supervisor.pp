class logstash::storm_supervisor inherits logstash::params {

  file { "${logstash_install_dir}/storm_supervisor.conf":
    ensure  => present,
    owner   => $logstash_user,
    group   => $logstash_group,
    mode    => $logstash_conf_perms,
    content => template("logstash/logstash-storm-supervisor.conf.erb"),
  }

  file { "/etc/init/logstash-storm-supervisor.conf":
    ensure  => present,
    owner   => $logstash_user,
    group   => $logstash_group,
    mode    => "0644",
    content => template("logstash/logstash-storm-supervisor.upstart.erb"),
    require => File["${logstash_install_dir}/storm_supervisor.conf"],
  }

  service { "logstash-storm-supervisor":
    ensure     => running,
    enable     => true,
    hasrestart => true,
    hasstatus  => true,
    provider   => upstart,
    require    => File["/etc/init/logstash-storm-supervisor.conf"],
    subscribe  => [File["/etc/init/logstash-storm-supervisor.conf"],File["${logstash_install_dir}/storm_supervisor.conf"]],
  }

}
