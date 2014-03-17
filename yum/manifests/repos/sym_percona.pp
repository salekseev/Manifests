class yum::repos::sym_percona {    
    yumrepo { 'sym-percona':
        descr      => "CentOS-${lsbmajdistrelease} Sym Percona",
        baseurl    => 'http://yum.symnds.net/mrepo/centos$releasever-$basearch/RPMS.percona http://mirror.st2.symnds.net/mrepo/centos$releasever-$basearch/RPMS.percona http://mirror.acc4.symnds.net/mrepo/centos$releasever-$basearch/RPMS.percona',
        mirrorlist => absent,
        enabled    => '1',
        gpgcheck   => '0',
        priority   => '1'
    }
}
