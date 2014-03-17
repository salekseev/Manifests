class yum::repos::sym_epel_testing {
    yumrepo { 'sym-epel-testing':
        gpgkey         => "file:///etc/pki/rpm-gpg/RPM-GPG-KEY-EPEL-${lsbmajdistrelease}",
        descr          => "CentOS-${lsbmajdistrelease} - Extra Packages Testing",
        mirrorlist     => absent,
        baseurl        => 'http://yum.symnds.net/mrepo/centos$releasever-$basearch/RPMS.epeltesting http://mirror.st2.symnds.net/mrepo/centos$releasever-$basearch/RPMS.epeltesting http://mirror.acc4.symnds.net/mrepo/centos$releasever-$basearch/RPMS.epeltesting',
        enabled        => '1',
        failovermethod => 'priority',
        gpgcheck       => '1',
        priority       => '3'
    }
}
