class jmxtrans::service inherits jmxtrans::params {

  service { 'jmxtrans':
    ensure     => running,
    enable     => true,
    hasstatus  => false,
    hasrestart => false,
    subscribe  => Class['jmxtrans::config'],
  }

}
