class kafka::config inherits kafka::params {

  $conf_file = "${kafka_install_dir}/kafka/config/server.properties"
  $log4j_config = "${kafka_install_dir}/kafka/config/log4j.properties"
  
  file { $conf_file:
    owner   => $kafka_user,
    group   => $kafka_group,
    mode    => $kafka_conf_perms,
    content => template("kafka/config/server.properties.erb"),
  }

  file { $log4j_config:
    ensure  => present,
    owner   => $user,
    group   => $group,
    mode    => $kafka_conf_perms,
    content => template("kafka/config/log4j.properties.erb"),
  }
  
  file { "${kafka_install_dir}/kafka/bin/kafka-server-start.sh":
    ensure  => present,
    owner   => $kafka_user,
    group   => $kafka_group,
    mode    => $kafka_bin_dir_perms,
    content => template("kafka/init/kafka-server-start.sh.erb"),
    require => File[$conf_file],
  }

  file { '/etc/init.d/kafka':
    content => template("kafka/init/kafka.sh.erb"),
    mode => "0755",
    owner => 'root',
    group => 'root',
    require => [File[$conf_file],File["${kafka_install_dir}/kafka/bin/kafka-server-start.sh"]],
  }

  file { $kafka_data_dirs:
    ensure  => directory,
    owner   => $kafka_user,
    group   => $kafka_group,
    recurse => true,
    require => File['/etc/init.d/kafka'],
  }

}
