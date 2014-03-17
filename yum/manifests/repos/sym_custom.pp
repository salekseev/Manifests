class yum::repos::sym_custom {
    yumrepo { 'sym-custom':
        descr      => "CentOS-${lsbmajdistrelease} Sym Custom",
        mirrorlist => absent,
        baseurl    => 'http://yum.symnds.net/mrepo/centos$releasever-$basearch/RPMS.sym http://mirror.st2.symnds.net/mrepo/centos$releasever-$basearch/RPMS.sym http://mirror.acc4.symnds.net/mrepo/centos$releasever-$basearch/RPMS.sym',
        enabled    => '1',
        gpgcheck   => '0',
        priority   => '1',
        notify     => Exec[ "yum_makecache" ]
    }
}
