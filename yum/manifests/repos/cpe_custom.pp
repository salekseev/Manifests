class yum::repos::cpe_custom {
    yumrepo { 'cpe-custom':
        descr      => "CentOS-${lsbmajdistrelease} CPE Custom",
        mirrorlist => absent,
        baseurl    => 'http://10.119.134.28/mrepo/sym-cpe/6/x86_64',
        enabled    => '1',
        gpgcheck   => '0',
        priority   => '1',
        notify     => Exec[ "yum_makecache" ]
    }
}
