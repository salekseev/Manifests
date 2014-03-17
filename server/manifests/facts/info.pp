class server::facts::info {
    file { ["/etc/facter", "/etc/facter/facts.d"]:
        ensure  => directory,
        owner   => 'puppet',
        group   => 'puppet',
        mode    => 0755,
    }

    file { "/etc/facter/facts.d/network_info.pl":
        owner => 'root',
        group => 'root',
        mode  => 0755,
        source => "puppet:///modules/server/facts/info/network_info.pl",
        require => File["/etc/facter","/etc/facter/facts.d"],
    }
}
