class yum::repos::sym_epel {
    yumrepo { 'sym-epel':
        gpgkey         => "file:///etc/pki/rpm-gpg/RPM-GPG-KEY-EPEL-${lsbmajdistrelease}",
        descr          => "CentOS-${lsbmajdistrelease} - Extra Packages",
        mirrorlist     => absent,
        baseurl        => 'http://yum.symnds.net/mrepo/centos$releasever-$basearch/RPMS.epel http://mirror.st2.symnds.net/mrepo/centos$releasever-$basearch/RPMS.epel http://mirror.acc4.symnds.net/mrepo/centos$releasever-$basearch/RPMS.epel',
        enabled        => '1',
        failovermethod => 'priority',
        gpgcheck       => '1',
        priority       => '1',
        exclude        => 'rabbit*,puppet*,dkms*',
        notify         => Exec[ "yum_makecache" ]
    }
}
