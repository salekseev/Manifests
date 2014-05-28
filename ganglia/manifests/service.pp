class ganglia::service inherits ganglia::params {

  if $is_master {

    service { 'httpd':
      ensure     => running,
      enable     => true,
      hasstatus  => true,
      hasrestart => true,
    }

    file { 'hdp-gmetad':
      ensure  => file,
      path    => '/etc/init.d/hdp-gmetad',
      owner   => 'root',
      group   => 'root',
      mode    => '0755',
      content => template('ganglia/hdp-gmetad.erb'),
      require => File['manage-run-dir'],
    }

    service { 'hdp-gmetad':
      ensure     => running,
      enable     => true,
      hasstatus  => true,
      hasrestart => true,
      require    => [File['hdp-gmetad'],Exec['create-run-dir']],
    }

    file { '/etc/init.d/gmetad':
      ensure     => absent,
    }
  }

  file { 'hdp-gmond':
    ensure  => file,
    path    => '/etc/init.d/hdp-gmond',
    owner   => 'root',
    group   => 'root',
    mode    => '0755',
    content => template('ganglia/hdp-gmond.erb'),
    require => File['manage-run-dir']
  }

  service { 'hdp-gmond':
    ensure     => running,
    enable     => true,
    hasstatus  => true,
    hasrestart => true,
    require    => File['hdp-gmond'],
  }

  file { '/etc/init.d/gmond':
    ensure     => absent,
  }

}
