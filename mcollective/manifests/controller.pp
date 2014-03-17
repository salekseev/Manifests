class mcollective::controller {
    include mcollective::base

    $datacenter = $datacenter ? { undef => "st2", default => $datacenter }

    package { mcollective-client:         ensure => latest }
    package { mcollective-puppet-client:  ensure => latest }
    package { mcollective-nettest-client: ensure => latest }
    package { mcollective-package-client: ensure => latest }
    package { mcollective-nrpe-client:    ensure => latest }
    package { mcollective-service-client: ensure => latest }
    package { mcollective-filemgr-client: ensure => latest }

    file { "/etc/mcollective/client.cfg":
        owner          => root,
        group          => root,
        mode           => 0644,
        checksum       => md5,
        content        => template( "mcollective/client.cfg.erb" ),
        require        => Package["mcollective-client"],
     }

    file { "/usr/libexec/mcollective/mcollective/agent/service.ddl":
        owner   => root,
        group   => root,
        mode    => 644,
        source  => "puppet:///modules/mcollective/service.ddl",
        require => Package["mcollective"],
    }

    file { "/usr/libexec/mcollective/mcollective/application/mc-service":
        owner   => root,
        group   => root,
        mode    => 755,
        source  => "puppet:///modules/mcollective/mc-service",
        require => Package["mcollective"],
    }

    file { "/usr/sbin/mc-service":
        owner   => root,
        group   => root,
        mode    => 755,
        source  => "puppet:///modules/mcollective/mc-service",
        require => Package["mcollective"],
    }
}
