class kafka::install inherits kafka {
  
  exec { "untar ${kafka::package::basefilename}":
    command => "tar xfvz ${package_dir}/${kafka::package::basefilename}",
    cwd     => "${install_dir}",
    creates => "${install_dir}/${kafka::package::basename}/config",
    alias   => "untar-kafka",
    require => [File["${package_dir}/${kafka::package::basefilename}"]],
    path    => ["/bin", "/usr/bin", "/usr/sbin"],
  }
  
  file { "${install_dir}/${kafka::package::basename}":
    ensure  => "directory",
    mode    => 0644,
    owner   => $user,
    group   => $group,
    alias   => "kafka-app-dir",
    recurse => true,
    require => Exec["untar-kafka"],
  }

  file { "${install_dir}/${kafka::package::basename}/bin":
    ensure  => "directory",
    mode    => 0755,
    owner   => $user,
    group   => $group,
    alias   => "kafka-app-dir-bin",
    recurse => true,
    require => File["kafka-app-dir"],
  }
  
  file { "${install_dir}/kafka":
    force   => true,
    ensure  => "${install_dir}/${kafka::package::basename}",
    alias   => "kafka-symlink",
    owner   => $user,
    group   => $group,
    require => File["kafka-app-dir"]
  }

  exec { "${log_dir}":
    command => "mkdir -p ${log_dir}",
    creates => $log_dir,
    path    => ["/bin", "/usr/bin", "/usr/sbin"],
    require => Exec["untar-kafka"],
  }

  file { "${log_dir}":
    ensure  => directory,
    owner   => $user,
    group   => $group,
    require => Exec["${log_dir}"],
  }

  file { "${log_dir_link}":
    ensure => link,
    force  => true,
    owner  => $user,
    group  => $group,
    target => $log_dir,
    require => Exec["${log_dir}"],
  }
}
