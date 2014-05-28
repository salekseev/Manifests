class kafka::config inherits kafka {

  $conf_file = "${install_dir}/kafka/config/server.properties"
  $log4j_config = "${install_dir}/kafka/config/log4j.properties"
  
  file { $conf_file:
    owner => $user,
    group => $group,
    mode => "644",
    alias => "kafka-cfg",
    require => File["kafka-app-dir"],
    content => template("kafka/config/server.properties.erb"),
  }

  file { $log4j_config:
    owner => $user,
    group => $group,
    mode => "644",
    alias => "log4j-cfg",
    require => File["kafka-app-dir"],
    content => template("kafka/config/log4j.properties.erb"),
  }
  
  file { "${install_dir}/kafka/bin/kafka-server-start.sh":
    content => template("kafka/init/kafka-server-start.sh.erb"),
    mode => "0755",
    owner => $user,
    group => $group,
    alias => 'kafka-init',
    require => File[$conf_file],
  }

  file { '/etc/init.d/kafka':
    content => template("kafka/init/kafka.sh.erb"),
    mode => "0755",
    owner => 'root',
    group => 'root',
    require => [File[$conf_file],File["${install_dir}/kafka/bin/kafka-server-start.sh"]],
  }

  $data_dirs = ["/data/vol3/kafka",
                "/data/vol4/kafka",
                "/data/vol5/kafka",
                "/data/vol6/kafka",
                "/data/vol7/kafka",
                "/data/vol8/kafka",
                "/data/vol9/kafka",
                "/data/vol10/kafka",
                "/data/vol11/kafka",
                "/data/vol12/kafka"]

  file { $data_dirs:
    ensure => directory,
    owner  => $user,
    group  => $group,
    recurse => true,
    require => File['/etc/init.d/kafka'],
  }

}
