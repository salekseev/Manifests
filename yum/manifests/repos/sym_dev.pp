class yum::repos::sym_dev {
    yumrepo { 'sym-dev':
        descr      => "CentOS-${lsbmajdistrelease} Sym Dev",
        mirrorlist => absent,
        baseurl    => 'http://yum.symnds.net/mrepo/centos$releasever-$basearch/RPMS.dev http://mirror.st2.symnds.net/mrepo/centos$releasever-$basearch/RPMS.dev http://mirror.acc4.symnds.net/mrepo/centos$releasever-$basearch/RPMS.dev',
        enabled    => '1',
        gpgcheck   => '0',
        priority   => '1',
        notify     => Exec[ "yum_makecache" ]
    }
}
