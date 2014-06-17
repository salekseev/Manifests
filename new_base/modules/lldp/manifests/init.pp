class lldp ($ensure       = 'present',
            $autoupdate   = $lldp::defaults::autoupdate,
            $package_name = $lldp::defaults::package_name,
            $service_name = $lldp::defaults::service_name,
           ) inherits lldp::defaults {
  case $ensure {
    'present': {
      if $autoupdate {
        $pkg_ensure = 'latest'
      } else {
        $pkg_ensure = 'present'
      }
      $svc_ensure   = 'running'
      $svc_enable   = true
      $file_ensure  = 'present'
    }
    'absent': {
      $pkg_ensure   = 'absent'
      $svc_ensure   = 'stopped'
      $svc_enable   = false
      $file_ensure  = 'absent'
    }
    'purged': {
      $pkg_ensure   = 'purged'
      $svc_ensure   = 'stopped'
      $svc_enable   = false
      $file_ensure  = 'absent'
    }
  }

  package {$package_name:
    ensure => $pkg_ensure,
  }

  file {$config_file_path:
    ensure  => $file_ensure,
    content => inline_template($config_file_data),
    require => Package[$package_name],
    notify  => Service[$service_name],
  }

  service {$service_name:
    ensure => $svc_ensure,
    enable => $svc_enable,
    require => File[$config_file_path],
    hasstatus => false,
    hasrestart => true,
  }

}

