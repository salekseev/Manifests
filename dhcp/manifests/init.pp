class dhcp::server {

    package { dhcp: ensure => latest }
    package { dhclient: ensure => latest }
    package { dhcpv6-client: ensure => absent }
    service { dhcpd: ensure => running, enable => true }
    package { incron: ensure => latest }
    service { incrond: ensure => running, enable => true }

    $datacenter = $datacenter ? { undef => "st2", default => $datacenter }

    file { "/etc/dhcp/dhcpd.conf":
        owner          => root,
        group          => root,
        mode           => 0644,
        checksum       => md5,
        content        => template( "dhcp/dhcpd.conf.$datacenter.erb" ),
        require        => Package["dhcp"],
     }

    file { "/var/log/dhcp":
        ensure         => directory,
        owner          => root,
        group          => root,
        mode           => 0755,
        require        => Package["dhcp"],
     }

     file { "/etc/dhcp/statics.conf":
        owner          => root,
        group          => root,
        mode           => 0644,
        source         => "puppet:///modules/dhcp/statics.conf.$datacenter.conf",
        require        => Package["dhcp"],
     }

     file { "/etc/dhcp/cobbler-hosts.conf":
        owner          => root,
        group          => root,
        mode           => 0644,
        ensure         => present,
        require        => Package["dhcp"],
     }

     file { "/usr/local/sbin/restart-dhcpd":
        owner          => root,
        group          => root,
        mode           => 0755,
        ensure         => present,
        source         => "puppet:///modules/dhcp/incron-restart-dhcpd",
        require        => Package["incron"],
     }

    file { "/var/spool/incron/root":
        owner          => root,
        group          => root,
        mode           => 0600,
        ensure         => present,
        source         => "puppet:///modules/dhcp/incrontab-root",
        require        => Package["incron"],
        notify         => Service["incrond"],
     }


     exec { "/etc/init.d/dhcpd restart":
         path          => ["/usr/bin", "/usr/sbin"],
         subscribe     => [ File["/etc/dhcp/dhcpd.conf"],
                            File["/etc/dhcp/statics.conf"],
                            File["/etc/dhcp/cobbler-hosts.conf"]
                          ],
         refreshonly   => true,
         timeout       => 30,
         onlyif        => "/etc/init.d/dhcpd configtest",
         require       => Package["dhcp"],
     }
}


### EOF
