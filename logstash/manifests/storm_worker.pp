class logstash::storm_worker inherits logstash::params {

  file { "${logstash_install_dir}/storm_worker.conf":
    ensure  => present,
    owner   => $logstash_user,
    group   => $logstash_group,
    mode    => $logstash_conf_perms,
    content => template("logstash/logstash-storm-worker.conf.erb"),
  }

  file { "/etc/init/logstash-storm-worker.conf":
    ensure  => present,
    owner   => "root",
    group   => "root",
    mode    => "0644",
    content => template("logstash/logstash-storm-worker.upstart.erb"),
    require => File["${logstash_install_dir}/storm_worker.conf"],
  }

  service { "logstash-storm-worker":
    ensure     => running,
    enable     => true,
    hasrestart => true,
    hasstatus  => true,
    provider   => upstart,
    require    => File["/etc/init/logstash-storm-worker.conf"],
    subscribe  => [File["/etc/init/logstash-storm-worker.conf"],File["${logstash_install_dir}/storm_worker.conf"]],
  }

}
