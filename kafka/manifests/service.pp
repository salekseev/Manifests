class kafka::service inherits kafka::params {

  include kafka::config

  service { 'kafka':
    ensure    => running,
    enable    => true,
    subscribe => [File[$kafka::config::conf_file],File[$kafka::config::log4j_config],File["${kafka_install_dir}/kafka/bin/kafka-server-start.sh"],File["/etc/init.d/kafka"]],
  }
}
