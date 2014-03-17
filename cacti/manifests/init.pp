# /etc/puppet/cacti/manifests/init.pp

class cacti::bind9 {

    package { perl-SNMP-Extension-PassPersist: ensure => latest }

    file { "/usr/local/sbin/bind9-stats-snmpd.pl":
        owner   => root,
        group   => root,
        mode    => 755,
        source  => "puppet:///modules/cacti/bind9/bind9-stats-snmpd.pl",
        require => Package["bind"],
    }

    file { "/usr/local/sbin/bind9-genstats.sh":
        owner   => root,
        group   => root,
        mode    => 755,
        source  => "puppet:///modules/cacti/bind9/bind9-genstats.sh",
        require => Package["bind"],
    }

    cron { bind9-genstats:
        command => "/usr/local/sbin/bind9-genstats.sh 1> /dev/null 2> /dev/null",
        user    => root,
        minute  => "*/5",
    }
}

class cacti::iostat {
    package { sysstat: ensure => latest }

    file { "/etc/cron.d/iostat-cron":
        ensure  => absent,
        owner   => root,
        group   => root,
        mode    => 644,
        source  => "puppet:///modules/cacti/iostat/iostat-cron",
    }

    file { "/usr/local/bin/iostat-persist.pl":
        ensure  => absent,
        owner   => root,
        group   => root,
        mode    => 755,
        source  => "puppet:///modules/cacti/iostat/iostat-persist.pl",
    }
}

# EOF
