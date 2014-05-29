class logstash::storm_nimbus inherits logstash::params {

  file { "${logstash_install_dir}/storm_nimbus.conf":
    ensure  => present,
    owner   => $logstash_user,
    group   => $logstash_group,
    mode    => $logstash_conf_perms,
    content => template("logstash/logstash-storm-nimbus.conf.erb"),
  }

  file { "/etc/init/logstash-storm-nimbus.conf":
    ensure  => present,
    owner   => $logstash_user,
    group   => $logstash_group,
    mode    => "0644",
    content => template("logstash/logstash-storm-nimbus.upstart.erb"),
    require => File["${logstash_install_dir}/storm_nimbus.conf"],
  }

  service { "logstash-storm-nimbus":
    ensure     => running,
    enable     => true,
    hasrestart => true,
    hasstatus  => true,
    provider   => upstart,
    require    => File["/etc/init/logstash-storm-nimbus.conf"],
  }

}
