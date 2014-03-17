
class usermgmt::admins {

    group { 'wheel':
                ensure          => present,
                gid             => $operatingsystem ? {
                    'Ubuntu'    => 200,
                    default     => 10,
                },
    }

    user { 'bseitz':
                ensure          => present,
                home            => '/home/bseitz',
                shell           => '/bin/bash',
                comment         => 'Bryan Seitz',
                managehome      => true,
                password        => '$1$L22HGuh4$lpTV.aFdwj0bOhJa9TgEo0',
                uid             => 500,
                gid             => 500,
                require         => Group['bseitz','wheel'],
                groups          => 'wheel',
    }
    group { 'bseitz':
                ensure          => present,
                gid             => 500,
    }

    user { 'sdarone':
                ensure          => present,
                home            => '/home/sdarone',
                shell           => '/bin/bash',
                comment         => 'Scott Darone',
                managehome      => true,
                password        => '$1$g48slMGA$of25NrKfi0ABgBxuB.XzW/',
                uid             => 501,
                gid             => 501,
                require         => Group['sdarone','wheel'],
                groups          => 'wheel',
    }
    group { 'sdarone':
                ensure          => present,
                gid             => 501,
    }

    user { 'sgibson':
                ensure          => present,
                home            => '/home/sgibson',
                shell           => '/bin/bash',
                comment         => 'Shane Gibson',
                managehome      => true,
                password        => '$6$cx2PK/3X$2DxKhBrOfMcowSEFzPWPvbO.WRg/A2M/Ioiv6atUU71bxKHnPiypsLhVvqki92tU792dOafAm6SKHLMJpGHUr.',
                uid             => 502,
                gid             => 502,
                require         => Group['sgibson','wheel'],
                groups          => 'wheel',
    }
    group { 'sgibson':
                ensure          => present,
                gid             => 502,
    }

    user { 'ianc':
                ensure          => present,
                home            => '/home/ianc',
                shell           => '/bin/bash',
                comment         => 'Ian Courtney',
                managehome      => true,
                password        => '$6$Vs5T5G0s$5bFQww.bAZk1CwD/a0nfALUvuNvBnLTyyCrQF.O1BO64gjeYd5DaCjcIWsAfdXi12Y2Fek8Qii1KWZ0NyhddO/',
                uid             => 503,
                gid             => 503,
                require         => Group['ianc','wheel'],
                groups          => 'wheel',
    }           
    group { 'ianc':
                ensure          => present,
                gid             => 503,
    }

    user { 'skolesnikowicz':
                ensure          => present,
                home            => '/home/skolesnikowicz',
                shell           => '/bin/bash',
                comment         => 'Stefan Kolesnikowicz',
                managehome      => true,
                password        => '$6$RhLhn42o$/p6HzSycDuR4b5affo5hgOQ83kfsLko9.ZLoUc4OzkrFA6HB3EJhRMFnV0HaMV98EmTREY4nujE/4Vc4Ud7wc1',
                uid             => 504,
                gid             => 504,
                require         => Group['skolesnikowicz','wheel'],
                groups          => 'wheel',
    }
    group { 'skolesnikowicz':
                ensure          => present,
                gid             => 504,
    }

    file { "/home/tphilip":
        ensure => "directory",
        owner  => "tphilip",
        group  => "tphilip",
        mode   => 700,
        require =>  [ User[tphilip], Group[tphilip] ],
    }

    user { 'tphilip':
                ensure          => present,
                home            => '/home/tphilip',
                shell           => '/bin/bash',
                comment         => 'Tony Philip',
                managehome      => true,
                password        => '$1$B1Irs63U$x/Wj6cXRjTk7sY3d9Ttd./',
                uid             => 506,
                gid             => 10,
                require         => Group['tphilip','wheel'],
                groups          => 'tphilip',
    }
    group { 'tphilip':
                ensure          => present,
                gid             => 506,
    }

 file { "/home/mnagaraj":
        ensure => "directory",
        owner  => "mnagaraj",
        group  => "mnagaraj",
        mode   => 700,
        require =>  [ User[mnagaraj], Group[mnagaraj] ],
    }

    user { 'mnagaraj':
                ensure          => present,
                home            => '/home/mnagaraj',
                shell           => '/bin/bash',
                comment         => 'Mahesh Nagaraj',
                managehome      => true,
                password        => '$1$9NO0ii7N$/8RdHkHlD7xLnuHPQ55oL/',
                uid             => 507,
                gid             => 10,
                require         => Group['mnagaraj','wheel'],
                groups          => 'mnagaraj',
    }
    group { 'mnagaraj':
                ensure          => present,
                gid             => 507,
    }
}


### EOF
