class ganglia::package inherits ganglia::params {

  package { 'ganglia-gmond':
    ensure => '3.5.0-99',
  }

  if $is_master {

    package { 'ganglia-gmetad':
      ensure => '3.5.0-99',
    }

    package { 'ganglia-web':
      ensure => '3.5.7-99',
    }

  }

}
