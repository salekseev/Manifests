class named::auth {

    package { bind:       ensure => '9.9.3-104.P2.el6' }
    package { bind-libs:  ensure => '9.9.3-104.P2.el6' }
    package { bind-utils: ensure => '9.9.3-104.P2.el6' }

    service { named: ensure => running, enable => true }

    $datacenter = $datacenter ? { undef => "st2", default => $datacenter }

    file { "/etc/named.conf":
        owner          => named,
        group          => named,
        mode           => 0660,
        content        => template( "named/main.erb", "named/named.conf.erb" ),
        require        => Package["bind"],
     }

    file { "/etc/rndc.key":
        owner   => "named",
        group   => "named",
        mode    => "0664",
        source  => "puppet:///modules/named/rndc.key",
        require => Package["bind"],
     }

    file { "/var/log/named":
        ensure         => directory,
        owner          => named,
        group          => named,
        mode           => 0755,
        require        => Package["bind"],
     }


    file { "/etc/sysconfig/named":
        owner          => root,
        group          => root,
        mode           => 0644,
        source         => "puppet:///modules/named/sysconfig-named",
        require        => Package["bind"],
     }

     file { "/var/named":
         ensure        => directory,
         owner         => named,
         group         => named,
         mode          => 0755,
         require       => Package["bind"],
     }

     file { "/var/named/master":
         ensure        => directory,
         owner         => named,
         group         => named,
         mode          => 0755,
         require       => Package["bind"],
     }

     file { "/var/named/dynamic":
         ensure        => directory,
         owner         => named,
         group         => named,
         mode          => 0755,
         require       => Package["bind"],
     }

     file { "/var/named/reverse":
         ensure        => directory,
         owner         => named,
         group         => named,
         mode          => 0755,
         require       => Package["bind"],
     }

     file { "/var/named/slave":
         ensure        => directory,
         owner         => named,
         group         => named,
         mode          => 0755,
         require       => Package["bind"],
     }

     file { "/var/named/stubs":
         ensure        => directory,
         owner         => named,
         group         => named,
         mode          => 0755,
         require       => Package["bind"],
     }

     file { "/var/run/named":
         ensure        => directory,
         owner         => named,
         group         => named,
         mode          => 1755,
         require       => Package["bind"],
     }

     file { "/var/named/dynamic/managed-keys.bind":
         ensure        => present,
         owner         => named,
         group         => named,
         mode          => 0644,
         replace       => false,
         require       => Package["bind"],
     }

     file { "/var/named/master/master.localhost":
         owner         => named,
         group         => named,
         mode          => 0644,
         replace       => false,
         source        => "puppet:///modules/named/master/master.localhost",
         require       => Package["bind"],
     }

     ### Garbage
     file { "/var/named/master/ipinfodb.com":
         owner         => named,
         group         => named,
         mode          => 0644,
         replace       => true,
         checksum      => md5,
         source        => "puppet:///modules/named/master/ipinfodb.com",
         require       => Package["bind"],
     }

     ### Zone
     file { "/var/named/master/home.norton.com":
         owner         => named,
         group         => named,
         mode          => 0644,
         replace       => true,
         checksum      => md5,
         source        => "puppet:///modules/named/master/home.norton.com",
         require       => Package["bind"],
     }

     file { "/var/named/master/nortonzone.com":
         ensure         => absent,
     }

     file { "/var/named/root.servers":
         owner         => named,
         group         => named,
         mode          => 0644,
         source        => "puppet:///modules/named/root.servers",
         require       => Package["bind"],
     }

     file { "/var/named/empty":
         owner         => named,
         group         => named,
         mode          => 0644,
         source        => "puppet:///modules/named/empty",
         require       => Package["bind"],
     }

     file { "/var/named/reverse/127.0.0.rev":
         owner         => named,
         group         => named,
         mode          => 0644,
         replace       => false,
         source        => "puppet:///modules/named/reverse/127.0.0.rev",
         require       => Package["bind"],
     }

     exec { "/etc/init.d/named reload":
         path          => ["/usr/bin", "/usr/sbin"],
         subscribe     => File["/etc/named.conf"],
         refreshonly   => true,
         require       => Package["bind"],
     }
}
