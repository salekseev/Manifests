class yum::repos::sym_puppet {
    yumrepo { 'sym-puppet':
        descr      => "CentOS-${lsbmajdistrelease} Sym Puppet",
        mirrorlist => absent,
        baseurl    => 'http://yum.symnds.net/mrepo/centos$releasever-$basearch/RPMS.puppet http://mirror.st2.symnds.net/mrepo/centos$releasever-$basearch/RPMS.puppet http://mirror.acc4.symnds.net/mrepo/centos$releasever-$basearch/RPMS.puppet',
        enabled    => '1',
        gpgcheck   => '0',
        priority   => '1',
        notify     => Exec[ "yum_makecache" ]
    }

    yumrepo { 'sym-puppet_deps':
        descr      => "CentOS-${lsbmajdistrelease} Sym Puppet",
        mirrorlist => absent,
        baseurl    => 'http://yum.symnds.net/mrepo/centos$releasever-$basearch/RPMS.puppet_deps http://mirror.st2.symnds.net/mrepo/centos$releasever-$basearch/RPMS.puppet_deps http://mirror.acc4.symnds.net/mrepo/centos$releasever-$basearch/RPMS.puppet_deps',
        enabled    => '1',
        gpgcheck   => '0',
        priority   => '1',
        notify     => Exec[ "yum_makecache" ]
    }
}
