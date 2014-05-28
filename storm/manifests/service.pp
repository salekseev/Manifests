class storm::service inherits storm::params {

    include storm::config

    service { 'supervisord':
      ensure     => running,
      enable     => true,
      hasrestart => true,
      hasstatus  => true,
      subscribe  => [File["${storm_config_dir}/storm.yaml"],File["/etc/supervisord.conf"]],
    }

}
