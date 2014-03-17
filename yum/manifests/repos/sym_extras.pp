class yum::repos::sym_extras {
    yumrepo { 'sym-extras':
        gpgkey         => "file:///etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-${lsbmajdistrelease}",
        descr          => "CentOS-${lsbmajdistrelease} - Extras",
        mirrorlist     => absent,
        baseurl        => 'http://yum.symnds.net/mrepo/centos$releasever-$basearch/RPMS.extras http://mirror.st2.symnds.net/mrepo/centos$releasever-$basearch/RPMS.extras http://mirror.acc4.symnds.net/mrepo/centos$releasever-$basearch/RPMS.extras',
        gpgcheck       => '1',
        enabled        => '1',
        priority       => '1'
    }
}
