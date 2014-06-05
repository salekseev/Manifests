class jmxtrans::install inherits jmxtrans::params {

  package { "jmxtrans":
    ensure   => $jmxtrans_version,
  }

  file { $jmxtrans_log_dir:
    ensure  => directory,
    path    => $jmxtrans_log_dir,
    owner   => $jmxtrans_user,
    group   => $jmxtrans_group,
    mode    => $jmxtrans_log_dir_perms,
    require => Package["jmxtrans"],
  }

  file { $jmxtrans_run_dir:
    ensure  => directory,
    path    => $jmxtrans_run_dir,
    owner   => $jmxtrans_user,
    group   => $jmxtrans_group,
    mode    => $jmxtrans_run_dir_perms,
    require => Package["jmxtrans"],
  }

  file { "${jmxtrans_home}/conf":
    ensure  => directory,
    path    => "${jmxtrans_home}/conf",
    owner   => $jmxtrans_user,
    group   => $jmxtrans_group,
    mode    => $jmxtrans_conf_dir_perms,
    require => Package["jmxtrans"],
  }

  file { "${jmxtrans_home}/bin":
    ensure  => directory,
    path    => "${jmxtrans_home}/bin",
    owner   => $jmxtrans_user,
    group   => $jmxtrans_group,
    mode    => $jmxtrans_bin_dir_perms,
    require => Package["jmxtrans"],
  }

}
