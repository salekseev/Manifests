class storm::config inherits storm::params
{
    if ($storm_is_nimbus) {
      $supervisord_version = "master"
    } else {
      $supervisord_version = "worker"
    }

    file { "/etc/supervisord.conf":
      ensure  => present,
      owner   => $storm_user,
      group   => $storm_group,
      mode    => $storm_config_dir_perms,
      content => template("storm/supervisord.conf.${supervisord_version}.erb"),
    }

    file { "${storm_config_dir}/storm.yaml" :
      ensure  => present,
      owner   => $storm_user,
      group   => $storm_group,
      mode    => $storm_config_dir_perms,
      content => template('storm/storm.yaml.erb') ,
    }

}
