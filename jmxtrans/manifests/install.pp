class jmxtrans::install inherits jmxtrans::params {

  if ! defined(File[$puppet_files_dir]) {
    file { $puppet_files_dir:
      ensure => directory,
      path   => $puppet_files_dir,
      owner  => 'root',
      group  => 'root',
      mode   => '0755',
    }
  }

  file { 'jmxtrans-rpm':
    ensure => file,
    path   => "${puppet_files_dir}/${jmxtrans_rpm_name}",
    source => "puppet:///modules/jmxtrans/${jmxtrans_rpm_name}",
    owner  => 'root',
    group  => 'root',
    mode   => '0644',
    require => File[$puppet_files_dir],
  }

  package { 'jmxtrans-20121016.145842.6a28c97fbb-0.noarch':
    ensure   => installed,
    provider => 'rpm',
    alias    => 'jmxtrans-install',
    source   => "${puppet_files_dir}/${jmxtrans_rpm_name}",
    require  => File['jmxtrans-rpm'],
  }

  file { 'log-dir':
    ensure => directory,
    path   => '/var/log/jmxtrans',
    require => Package['jmxtrans-install'],
  }

  file { 'run-dir':
    ensure => directory,
    path   => '/var/run/jmxtrans',
    require => Package['jmxtrans-install'],
  }

  file { 'conf-dir':
    ensure => directory,
    path   => "${jmxtrans_home}/conf",
    require => Package['jmxtrans-install'],
  }

  file { 'bin-dir':
    ensure => directory,
    path   => "${jmxtrans_home}/bin",
    require => Package['jmxtrans-install'],
  } 

}
