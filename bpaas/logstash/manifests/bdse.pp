class logstash::bdse inherits logstash::params {

  file { "${logstash_install_dir}/bdse.conf":
    ensure  => present,
    owner   => $logstash_user,
    group   => $logstash_group,
    mode    => $logstash_conf_perms,
    content => template("logstash/logstash-bdse.conf.erb"),
  }

  file { "/etc/init/logstash-bdse.conf":
    ensure  => present,
    owner   => $logstash_user,
    group   => $logstash_group,
    mode    => "0644",
    content => template("logstash/logstash-bdse.upstart.erb"),
    require => File["${logstash_install_dir}/bdse.conf"],
  }

  service { "logstash-bdse":
    ensure     => running,
    enable     => true,
    hasrestart => true,
    hasstatus  => true,
    provider   => upstart,
    require    => File["/etc/init/logstash-bdse.conf"],
    subscribe  => [File["/etc/init/logstash-bdse.conf"], File["${logstash_install_dir}/bdse.conf"]],
  }

}
