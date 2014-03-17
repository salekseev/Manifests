class yum::repos::rhel_base {
    yumrepo { 'rhel-base':
        gpgkey     => "file:///etc/pki/rpm-gpg/RPM-GPG-KEY-redhat-release",
        descr      => "RHEL-${lsbmajdistrelease} - Base",
        mirrorlist => absent,
        baseurl    => 'http://yum.symnds.net/mrepo/rhel6s-x86_64/RPMS.all http://mirror.st2.symnds.net/mrepo/rhel6s-x86_64/RPMS.all http://mirror.acc4.symnds.net/mrepo/rhel6s-x86_64/RPMS.all',
        gpgcheck   => '1',
        enabled    => '1',
        priority   => '1',
        notify     => Exec[ "yum_makecache" ]
    }
}
