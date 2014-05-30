class kafka::directories inherits kafka::params {

  ### This is a bit of trickery due to the rpm versioning scheme. It cannot contain
  ### dashes and adds an iteration. This converts the rpm version back to the real
  ### version since that is the directory Kafka is installed to. If the iteration
  ### goes higher than 1 character, this will have to be modified.

  $kafka_rpm_version = regsubst($kafka_version, '_', '-')
  $kafka_home = regsubst("${kafka_install_dir}/kafka_${kafka_rpm_version}", '\S{2}$', '')
  
  file { $kafka_home:
    ensure  => "directory",
    mode    => $kafka_install_dir_perms,
    owner   => $kafka_user,
    group   => $kafka_group,
    recurse => true,
  }

  file { "${kafka_install_dir}/kafka":
    ensure  => link,
    force   => true,
    owner   => $kafka_user,
    group   => $kafka_group,
    target  => $kafka_home,
    require => File[$kafka_home],
  }

  file { "${kafka_home}/bin":
    ensure  => "directory",
    mode    => $kafka_bin_dir_perms,
    owner   => $kafka_user,
    group   => $kafka_group,
    recurse => true,
    require => File[$kafka_home],
  }
  
  exec { $kafka_log_dir:
    command => "mkdir -p ${kafka_log_dir}",
    creates => $kafka_log_dir,
    path    => ["/bin", "/usr/bin", "/usr/sbin"],
  }

  file { $kafka_log_dir:
    ensure  => directory,
    owner   => $kafka_user,
    group   => $kafka_group,
    mode    => $kafka_log_dir_perms,
    require => Exec[$kafka_log_dir],
  }

  file { "${kafka_log_dir_link}":
    ensure  => link,
    force   => true,
    owner   => $kafka_user,
    group   => $kafka_group,
    target  => $kafka_log_dir,
    require => Exec[$kafka_log_dir],
  }
}
