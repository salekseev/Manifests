class zookeeper::config inherits zookeeper::params {

  file { "${zookeeper_data_dir}/myid":
    owner   => $zookeeper_user,
    group   => $zookeeper_group,
    mode    => 0640,
    content => $zookeeper_id,
  }

  file { "${zookeeper_config_dir}/zookeeper-env.sh":
    owner   => $zookeeper_user,
    group   => $zookeeper_group,
    mode    => 0640,
    content => template("zookeeper/zookeeper-env.sh.erb"),
  }

  file { "${zookeeper_config_dir}/zoo.cfg":
    owner   => $zookeeper_user,
    group   => $zookeeper_group,
    mode    => 0640,
    content => template("zookeeper/zoo.cfg.erb"),
  }

}
