class yum::repos::sym_qa {        
    yumrepo { 'sym-qa':
        descr      => "CentOS-${lsbmajdistrelease} Sym QA",
        mirrorlist => absent,
        baseurl    => 'http://yum.symnds.net/mrepo/centos$releasever-$basearch/RPMS.qa http://mirror.st2.symnds.net/mrepo/centos$releasever-$basearch/RPMS.qa http://mirror.acc4.symnds.net/mrepo/centos$releasever-$basearch/RPMS.qa',
        enabled    => '1',
        gpgcheck   => '0',
        priority   => '1',
        notify     => Exec[ "yum_makecache" ]
    }
}
