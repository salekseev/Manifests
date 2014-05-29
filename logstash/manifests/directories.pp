class logstash::directories inherits logstash::params {

  exec { $logstash_log_dir:
    command => "mkdir -p ${logstash_log_dir}",
    path    => "/usr/local/bin/:/usr/bin/:/bin/",
    creates => $logstash_log_dir,
  }

  file { $logstash_log_dir:
    ensure  => directory,
    owner   => $logstash_user,
    group   => $logstash_group,
    mode    => $logstash_log_dir_perms,
    require => Exec[$logstash_log_dir],
  }
}
