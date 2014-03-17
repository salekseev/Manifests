# puppet/modules/puppet/manifests/init.pp

class puppet::extfacts {
    file { "/etc/facter/facts.d/hostgroup.txt":
        owner => 'root',
        group => 'root',
        mode  => 0644,
        content => "hostgroup=$hostgroup"
    }
}

class puppet::client {
    include puppet::extfacts

    $datacenter = $datacenter ? { undef => "ash1", default => $datacenter }
    
    if ( $hostname =~ /^d0/ ) {
        $puppet_version = 'present'
    } else {
        $puppet_version = 'latest'
    }

    package { puppet: ensure => $puppet_version }

    package { 'ruby-shadow': ensure => latest }
    file { "/etc/sysconfig/puppet":
        owner   => root,
        group   => root,
        mode    => 644,
        source  => "puppet:///modules/puppet/sysconfig-puppet",
        require => [ Package["puppet"], Yumrepo["sym-puppet"], Yumrepo["sym-puppet_deps"] ],
    }
    package { augeas:      ensure => latest }
    package { augeas-libs: ensure => latest }
    package { ruby-augeas: ensure => latest }

    file { "/etc/puppet/puppet.conf":
        owner   => root,
        group   => root,
        mode    => 644,
        content => template("puppet/puppet-client.conf.erb"),
        require => Package["puppet"],
    }

    service { "puppet":
        ensure    => stopped,
        enable    => false,
        restart   => "/etc/init.d/puppet restart",
        require   => Cron["puppet"],
    }

    ### Switch to running puppet from cron, which should be more reliable.  Run it 6 times per hour, based on the last octet of the host IP.
    cron { "puppet":
        ensure => present,
        command => "/usr/bin/puppet agent --onetime --no-daemonize --logdest syslog --report > /dev/null 2>&1",
        user    => "root",
        minute  => ip_to_cron(6),
    }

    file { '/var/lib/puppet/clientbucket':
        ensure  => 'directory',
        recurse => true,
        purge   => true,
        force   => true,
    }

}

