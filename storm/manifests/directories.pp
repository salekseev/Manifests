class storm::directories inherits storm::params
{

    file { $storm_config_dir:
      ensure  => "directory",
      owner   => $storm_user,
      group   => $storm_group,
      mode    => $storm_config_dir_perms,
    }
    
    exec { $storm_log_dir:
      path    => "/usr/local/bin/:/usr/bin/:/bin/",
      command => "mkdir -p ${storm_log_dir}",
      creates => $storm_log_dir,
    }

    file { $storm_log_dir:
      ensure  => "directory",
      owner   => $storm_user,
      group   => $storm_group,
      mode    => $storm_log_dir_perms,
      require => Exec[$storm_log_dir],
    }

    file { $storm_log_dir_link:
      ensure  => link,
      target  => $storm_log_dir,
      owner   => $storm_user,
      group   => $storm_group,
      force   => true,
      require => File[$storm_log_dir],
    }

    exec { $storm_data_dir:
      path    => "/usr/local/bin/:/usr/bin/:/bin/",
      command => "mkdir -p ${storm_data_dir}",
      creates => $storm_data_dir,
    }

    file { $storm_data_dir:
      ensure  => "directory",
      owner   => $storm_user,
      group   => $storm_group,
      mode    => $storm_data_dir_perms,
      require => Exec[$storm_data_dir],
    }

}
