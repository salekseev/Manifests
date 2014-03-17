class mcollective::base {
    $datacenter = $datacenter ? { undef => "st2", default => $datacenter }

    package { mcollective: ensure              => latest }
    package { mcollective-common: ensure       => latest }
    package { mcollective-facter-facts: ensure => latest }

    service { "mcollective": ensure => running, enable => true }

    file { "/etc/mcollective/facts.yaml":
        owner    => root,
        group    => root,
        mode     => 0400,
        loglevel => debug,
        content  => template( 'mcollective/mcollective_facts.erb' ),
        require  => Package["mcollective"],
    }

    file { "/usr/libexec/mcollective/mcollective/registration/meta.rb":
        owner    => root,
        group    => root,
        mode     => 0644,
        source  => "puppet:///modules/mcollective/meta.rb",
        require  => Package["mcollective"],
    }

    file { "/etc/mcollective/server.cfg":
        owner          => root,
        group          => root,
        mode           => 0644,
        checksum       => md5,
        content        => template( "mcollective/server.cfg.erb" ),
        require        => Package["mcollective"],
        notify         => Service["mcollective"],
     }

    file { "/usr/libexec/mcollective/mcollective/agent/puppetral.rb":
        ensure  => absent,
        notify         => Service["mcollective"],
    }

    #    file { "/usr/libexec/mcollective/mcollective/agent/service.rb":
    #    ensure  => absent,
    #    require => Package["mcollective"],
    #    notify         => Service["mcollective"],
    #}

}
