class yum::repos::sym_cdh4 {
    yumrepo { 'sym-cdh4':
        descr      => "CentOS-${lsbmajdistrelease} Cloudera Hadoop v4",
        mirrorlist => absent,
        baseurl    => 'http://yum.symnds.net/mrepo/centos$releasever-$basearch/RPMS.cdh http://mirror.st2.symnds.net/mrepo/centos$releasever-$basearch/RPMS.cdh http://mirror.acc4.symnds.net/mrepo/centos$releasever-$basearch/RPMS.cdh',
        enabled    => '0',
        gpgcheck   => '0',
        priority   => '1',
    }
}
