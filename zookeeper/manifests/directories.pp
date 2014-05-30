class zookeeper::directories inherits zookeeper::params {

  exec { "create_data_dir":
    path    => "/usr/local/bin/:/usr/bin/:/bin/",
    command => "mkdir -p ${zookeeper_data_dir}",
    creates => $zookeeper_data_dir,
  }

  file { $zookeeper_data_dir:
    ensure  => directory,
    owner   => $zookeeper_user,
    group   => $zookeeper_group,
    mode    => $zookeeper_data_dir_perms,
    require => Exec["create_data_dir"],
  }

  exec { "create_data_log_dir":
    path    => "/usr/local/bin/:/usr/bin/:/bin/",
    command => "mkdir -p ${zookeeper_data_dir}",
    creates => $zookeeper_data_log_dir,
  }

  file { $zookeeper_data_log_dir:
    ensure  => directory,
    owner   => $zookeeper_user,
    group   => $zookeeper_group,
    mode    => $zookeeper_data_dir_perms,
    require => Exec["create_data_log_dir"],
  }

  exec { "create_log_dir":
    path    => "/usr/local/bin/:/usr/bin/:/bin/",
    command => "mkdir -p ${zookeeper_log_dir}",
    creates => $zookeeper_log_dir,
  }

  file { $zookeeper_log_dir:
    ensure  => directory,
    owner   => $zookeeper_user,
    group   => $zookeeper_group,
    mode    => $zookeeper_log_dir_perms,
    require => Exec["create_log_dir"],
  }

  file { $zookeeper_log_dir_link:
    ensure  => link,
    target  => $zookeeper_log_dir,
    owner   => $zookeeper_user,
    group   => $zookeeper_group,
    force   => true,
    require => File[$zookeeper_log_dir],
  }

  file { $zookeeper_config_dir:
    ensure => directory,
    owner  => $zookeeper_user,
    group  => $zookeeper_group,
    mode   => $zookeeper_config_dir_perms,
  }

}
