class yum::repos::sym_base {
    yumrepo { 'sym-base':
        gpgkey     => "file:///etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-${lsbmajdistrelease}",
        descr      => "CentOS-${lsbmajdistrelease} - Base",
        mirrorlist => absent,
        baseurl    => 'http://yum.symnds.net/mrepo/centos$releasever-$basearch/RPMS.os http://mirror.st2.symnds.net/mrepo/centos$releasever-$basearch/RPMS.os http://mirror.acc4.symnds.net/mrepo/centos$releasever-$basearch/RPMS.os',
        gpgcheck   => '1',
        enabled    => '1',
        priority   => '1',
        notify     => Exec[ "yum_makecache" ]
    }
    Yumrepo['sym-base'] -> Package<||>
}

