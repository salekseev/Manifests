class logstash::hadoop inherits logstash::params {

  file { "${logstash_install_dir}/hadoop.conf":
    ensure  => present,
    owner   => $logstash_user,
    group   => $logstash_group,
    mode    => $logstash_conf_perms,
    content => template("logstash/logstash-hadoop.conf.erb"),
  }

  file { "/etc/init/logstash-hadoop.conf":
    ensure  => present,
    owner   => $logstash_user,
    group   => $logstash_group,
    mode    => "0644",
    content => template("logstash/logstash-hadoop.upstart.erb"),
    require => File["${logstash_install_dir}/hadoop.conf"],
  }

  service { "logstash-hadoop":
    ensure     => running,
    enable     => true,
    hasrestart => true,
    hasstatus  => true,
    provider   => upstart,
    require    => File["/etc/init/logstash-hadoop.conf"],
    subscribe  => [File["/etc/init/logstash-hadoop.conf"], File["${logstash_install_dir}/hadoop.conf"]],
  }

}
