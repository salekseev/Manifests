class yum::repos::sym_dell {
    yumrepo { 'sym-dell':
        descr      => "CentOS-${lsbmajdistrelease} Dell Custom",
        mirrorlist => absent,
        baseurl    => 'http://yum.symnds.net/mrepo/centos$releasever-$basearch/RPMS.dell http://mirror.st2.symnds.net/mrepo/centos$releasever-$basearch/RPMS.dell http://mirror.acc4.symnds.net/mrepo/centos$releasever-$basearch/RPMS.dell',
        enabled    => '1',
        gpgcheck   => '0',
        priority   => '1',
        notify     => Exec[ "yum_makecache" ]
    }
}
