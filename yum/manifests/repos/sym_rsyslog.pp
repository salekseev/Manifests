class yum::repos::sym_rsyslog {
    yumrepo { 'sym-rsyslog':
        descr      => "CentOS-${lsbmajdistrelease} Sym Rsyslog",
        baseurl    => 'http://yum.symnds.net/mrepo/centos$releasever-$basearch/RPMS.rsyslog http://mirror.st2.symnds.net/mrepo/centos$releasever-$basearch/RPMS.rsyslog http://mirror.acc4.symnds.net/mrepo/centos$releasever-$basearch/RPMS.rsyslog',
        mirrorlist => absent,
        enabled    => '1',
        gpgcheck   => '0',
        priority   => '1'
    }
}
