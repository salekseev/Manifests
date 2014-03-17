class yum::repos::sym_nof {
    yumrepo { 'sym-nof':
        descr      => "CentOS-${lsbmajdistrelease} Sym NOF",
        mirrorlist => absent,
        baseurl    => 'http://yum.symnds.net/mrepo/centos$releasever-$basearch/RPMS.nof http://mirror.st2.symnds.net/mrepo/centos$releasever-$basearch/RPMS.nof http://mirror.acc4.symnds.net/mrepo/centos$releasever-$basearch/RPMS.nof',
        enabled    => '1',
        gpgcheck   => '0',
        priority   => '1',
        notify     => Exec[ "yum_makecache" ]
    }
}
