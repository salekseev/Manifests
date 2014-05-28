class jmxtrans::config inherits jmxtrans::params {

  file { "${jmxtrans_home}/conf/kafka_jmxtrans.properties":
    ensure  => file,
    content => template('jmxtrans/kafka_jmxtrans.properties.erb'),
  }

  file { "${jmxtrans_home}/conf/kafka_server_jmxtrans.json":
    ensure  => file,
    content => template('jmxtrans/kafka_server_jmxtrans.json.erb'),
  }

  file { "${jmxtrans_home}/bin/jmxtrans_common.sh":
    ensure  => file,
    content => template('jmxtrans/jmxtrans_common.sh.erb'),
    mode    => '0755',
  }

  file { "${jmxtrans_home}/bin/start_jmxtrans.sh":
    ensure  => file,
    content => template('jmxtrans/start_jmxtrans.sh.erb'),
    mode    => '0755',
  }

  file { "${jmxtrans_home}/bin/stop_jmxtrans.sh":
    ensure  => file,
    content => template('jmxtrans/stop_jmxtrans.sh.erb'),
    mode    => '0755',
  }

  file { '/etc/init.d/jmxtrans':
    ensure  => file,
    content => template('jmxtrans/jmxtrans.init.erb'),
    mode    => '0755',
  }

}
