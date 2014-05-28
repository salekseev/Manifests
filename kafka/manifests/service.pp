class kafka::service inherits kafka {

  service { 'kafka':
    ensure  => running,
    enable  => true,
    require => File['kafka-init'],
  }
}
