class yum::repos::sym_psql {
    yumrepo { 'sym-psql':
        descr      => "CentOS-${lsbmajdistrelease} Sym Postgres",
        baseurl    => 'http://yum.symnds.net/mrepo/centos$releasever-$basearch/RPMS.pgq http://mirror.st2.symnds.net/mrepo/centos$releasever-$basearch/RPMS.pgq http://mirror.acc4.symnds.net/mrepo/centos$releasever-$basearch/RPMS.pgq',
        mirrorlist => absent,
        enabled    => '1',
        gpgcheck   => '0',
        priority   => '1',
        notify     => Exec[ "yum_makecache" ]
    }
}
