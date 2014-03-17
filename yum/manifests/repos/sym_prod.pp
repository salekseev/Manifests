class yum::repos::sym_prod {
    yumrepo { 'sym-prod':
        descr      => "CentOS-${lsbmajdistrelease} Sym Prod",
        mirrorlist => absent,
        baseurl    => 'http://yum.symnds.net/mrepo/centos$releasever-$basearch/RPMS.prod http://mirror.st2.symnds.net/mrepo/centos$releasever-$basearch/RPMS.prod http://mirror.acc4.symnds.net/mrepo/centos$releasever-$basearch/RPMS.prod',
        enabled    => '1',
        gpgcheck   => '0',
        priority   => '1',
        notify     => Exec[ "yum_makecache" ]
    }
}
