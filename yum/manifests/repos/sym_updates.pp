class yum::repos::sym_updates {
    yumrepo { 'sym-updates':
        gpgkey         => "file:///etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-${lsbmajdistrelease}",
        descr          => "CentOS-${lsbmajdistrelease} - Updates",
        mirrorlist     => absent,
        baseurl        => 'http://yum.symnds.net/mrepo/centos$releasever-$basearch/RPMS.updates http://mirror.st2.symnds.net/mrepo/centos$releasever-$basearch/RPMS.updates http://mirror.acc4.symnds.net/mrepo/centos$releasever-$basearch/RPMS.updates',
        failovermethod => 'priority',
        gpgcheck       => '1',
        enabled        => '1',
        priority       => '1',
        notify         => Exec[ "yum_makecache" ]
    }
}
