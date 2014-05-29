class logstash::storm_ui inherits logstash::params {

  file { "${logstash_install_dir}/storm_ui.conf":
    ensure  => present,
    owner   => $logstash_user,
    group   => $logstash_group,
    mode    => $logstash_conf_perms,
    content => template("logstash/logstash-storm-ui.conf.erb"),
  }

  file { "/etc/init/logstash-storm-ui.conf":
    ensure  => present,
    owner   => $logstash_user,
    group   => $logstash_group,
    mode    => "0644",
    content => template("logstash/logstash-storm-ui.upstart.erb"),
    require => File["${logstash_install_dir}/storm_ui.conf"],
  }

  service { "logstash-storm-ui":
    ensure     => running,
    enable     => true,
    hasrestart => true,
    hasstatus  => true,
    provider   => upstart,
    require    => File["/etc/init/logstash-storm-ui.conf"],
  }

}
