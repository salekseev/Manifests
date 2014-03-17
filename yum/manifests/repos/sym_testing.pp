class yum::repos::sym_testing {
    yumrepo { 'sym-testing':
        gpgkey         => "file:///etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-testing-${lsbmajdistrelease}",
        descr          => "CentOS-${lsbmajdistrelease} - Testing",
        mirrorlist     => absent,
        baseurl        => 'http://yum.symnds.net/mrepo/centos$releasever-$basearch/RPMS.testing http://mirror.st2.symnds.net/mrepo/centos$releasever-$basearch/RPMS.testing http://mirror.acc4.symnds.net/mrepo/centos$releasever-$basearch/RPMS.testing',
        failovermethod => 'priority',
        gpgcheck       => '0',
        enabled        => '1',
        priority       => '1'
    }
}
