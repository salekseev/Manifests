### Syslog 
class syslog (
    $syslog_package   = $syslog::params::syslog_package,
    $syslog_service   = $syslog::params::syslog_service,
    $syslog_version   = $syslog::params::syslog_version,
    $syslog_conf_path = $syslog::params::syslog_conf_path,
    $syslog_template  = $syslog::params::syslog_template
) inherits syslog::params {

    package { $syslog_package: ensure => $syslog_version }

    service { $syslog_service:
        ensure  => 'running',
        enable  => true,
        require => Package[ $syslog_package ],
    }

    file { $syslog_conf_path:
        owner   => 'root',
        group   => 'root',
        mode    => '0644',
        content => template( $syslog_template ),
    }

    file { "/var/log/nds":
        ensure => directory,
        owner  => "root",
        group  => "root",
        mode   => 1777,
    }
}

### EOF
