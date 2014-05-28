class zookeeper::service inherits zookeeper::params {

  include zookeeper::config

  file { "/etc/init.d/zookeeper":
    ensure  => file,
    content => template("zookeeper/zookeeper.init.erb"),
    owner   => "root",
    group   => "root",
    mode    => 0755,
  }

  service { 'zookeeper':
    ensure     => running,
    enable     => true,
    hasstatus  => true,
    hasrestart => true,
    require    => File['/etc/init.d/zookeeper'],
    subscribe  => [File["${zookeeper_data_dir}/myid"],File["${zookeeper_config_dir}/zookeeper-env.sh"],File["${zookeeper_config_dir}/zoo.cfg"]],
  }

}
